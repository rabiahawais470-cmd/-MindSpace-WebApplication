import { test, expect } from '@playwright/test';

/**
 * E2E tests for the Course Delete feature on CourseManagement.aspx.
 *
 * Prerequisites:
 *   - IIS Express running at http://localhost:5000
 *   - Admin user exists: username="admin", password="Admin@123"
 *
 * These tests verify the full delete flow:
 *   1. Click delete button → custom modal opens (no native confirm())
 *   2. Modal shows course name and warning text
 *   3. Cancel / Escape / outside-click closes modal without postback
 *   4. Confirm triggers __doPostBack → row removed → success message shown
 */

const ADMIN_USERNAME = process.env.ADMIN_USERNAME || 'admin';
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'Admin@123';
const BASE_URL = process.env.BASE_URL || 'http://localhost:5000';

/** Helper: log in as admin and navigate to CourseManagement */
async function loginAsAdmin(page: import('@playwright/test').Page) {
    await page.goto(`${BASE_URL}/Login.aspx`);
    await page.waitForLoadState('domcontentloaded');

    // ASP.NET WebForms renders IDs with MasterPage prefix: MainContent_txtCredential
    await page.locator('#MainContent_txtCredential').fill(ADMIN_USERNAME);
    await page.locator('#MainContent_txtPassword').fill(ADMIN_PASSWORD);

    // Click Sign In (rendered as MainContent_btnLogin)
    await page.locator('#MainContent_btnLogin').click();

    // Wait for redirect to admin area
    await page.waitForURL('**/Admin/**', { timeout: 10000 });

    // Navigate to CourseManagement
    await page.goto(`${BASE_URL}/Admin/CourseManagement.aspx`);
    await page.waitForLoadState('networkidle');
}

test.describe('Course Delete Feature', () => {

    test.beforeEach(async ({ page }) => {
        await loginAsAdmin(page);
    });

    test('delete button opens custom confirmation modal', async ({ page }) => {
        // Ensure there's at least one course row with a delete trigger
        const deleteTrigger = page.locator('.btn-delete-trigger').first();
        await expect(deleteTrigger).toBeVisible({ timeout: 5000 });

        // Click the delete trigger
        await deleteTrigger.click();

        // The custom modal overlay should become visible
        const modalOverlay = page.locator('#deleteModal');
        await expect(modalOverlay).toHaveClass(/active/);

        // Modal should contain the warning icon and title
        await expect(page.locator('#deleteModalTitle')).toHaveText('Delete Course');

        // Course name should be displayed in the modal
        const courseName = page.locator('#deleteModalCourseName');
        await expect(courseName).not.toBeEmpty();

        // Confirm and Cancel buttons should be visible
        await expect(page.locator('#btnDeleteConfirm')).toBeVisible();
        await expect(page.locator('#btnDeleteCancel')).toBeVisible();
    });

    test('cancel button closes modal without deleting', async ({ page }) => {
        const deleteTrigger = page.locator('.btn-delete-trigger').first();
        await expect(deleteTrigger).toBeVisible({ timeout: 5000 });

        // Count rows before
        const rowCountBefore = await page.locator('.btn-delete-trigger').count();

        // Open modal
        await deleteTrigger.click();
        const modalOverlay = page.locator('#deleteModal');
        await expect(modalOverlay).toHaveClass(/active/);

        // Click Cancel
        await page.locator('#btnDeleteCancel').click();

        // Modal should close
        await expect(modalOverlay).not.toHaveClass(/active/);

        // Row count should be unchanged
        const rowCountAfter = await page.locator('.btn-delete-trigger').count();
        expect(rowCountAfter).toBe(rowCountBefore);
    });

    test('clicking outside modal closes it without deleting', async ({ page }) => {
        const deleteTrigger = page.locator('.btn-delete-trigger').first();
        await expect(deleteTrigger).toBeVisible({ timeout: 5000 });

        // Open modal
        await deleteTrigger.click();
        const modalOverlay = page.locator('#deleteModal');
        await expect(modalOverlay).toHaveClass(/active/);

        // Click on the overlay (outside the dialog) — top-left corner
        await modalOverlay.click({ position: { x: 5, y: 5 } });

        // Modal should close
        await expect(modalOverlay).not.toHaveClass(/active/);
    });

    test('escape key closes modal without deleting', async ({ page }) => {
        const deleteTrigger = page.locator('.btn-delete-trigger').first();
        await expect(deleteTrigger).toBeVisible({ timeout: 5000 });

        // Open modal
        await deleteTrigger.click();
        const modalOverlay = page.locator('#deleteModal');
        await expect(modalOverlay).toHaveClass(/active/);

        // Press Escape
        await page.keyboard.press('Escape');

        // Modal should close
        await expect(modalOverlay).not.toHaveClass(/active/);
    });

    test('no browser native confirm dialog appears on delete click', async ({ page }) => {
        const deleteTrigger = page.locator('.btn-delete-trigger').first();
        await expect(deleteTrigger).toBeVisible({ timeout: 5000 });

        // Set up a listener for native dialog — it should NOT appear
        let dialogAppeared = false;
        page.on('dialog', async (dialog) => {
            dialogAppeared = true;
            await dialog.dismiss();
        });

        // Click the delete trigger
        await deleteTrigger.click();

        // Give a brief moment for any dialog to appear
        await page.waitForTimeout(500);

        // No native confirm() dialog should have been triggered
        expect(dialogAppeared).toBe(false);

        // Instead, the custom modal should be visible
        const modalOverlay = page.locator('#deleteModal');
        await expect(modalOverlay).toHaveClass(/active/);

        // Clean up — close the modal
        await page.locator('#btnDeleteCancel').click();
    });

    test('confirm delete removes course row and shows success message', async ({ page }) => {
        const deleteTriggers = page.locator('.btn-delete-trigger');
        const initialCount = await deleteTriggers.count();

        // Skip if no courses to delete
        if (initialCount === 0) {
            test.skip();
            return;
        }

        // Get the course title of the first row to verify modal shows it
        const firstTrigger = deleteTriggers.first();
        const courseTitle = await firstTrigger.getAttribute('data-course-title');

        // Open modal
        await firstTrigger.click();
        const modalOverlay = page.locator('#deleteModal');
        await expect(modalOverlay).toHaveClass(/active/);

        // Verify the modal shows the correct course name
        const modalCourseName = page.locator('#deleteModalCourseName');
        await expect(modalCourseName).toHaveText(courseTitle || '');

        // Click Confirm — __doPostBack submits a form causing full page reload.
        // Wrap with waitForNavigation to properly await the postback response.
        await Promise.all([
            page.waitForNavigation({ waitUntil: 'networkidle', timeout: 15000 }),
            page.locator('#btnDeleteConfirm').click(),
        ]);

        // The success alert should appear with "permanently deleted"
        const successAlert = page.locator('.alert-ms-success');
        await expect(successAlert).toBeVisible({ timeout: 10000 });
        await expect(successAlert).toContainText('permanently deleted');

        // Total row count should decrease by 1
        const newCount = await page.locator('.btn-delete-trigger').count();
        expect(newCount).toBe(initialCount - 1);
    });
});
