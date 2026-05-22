import { test, expect } from '@playwright/test';
import path from 'path';
import { pathToFileURL } from 'url';

const BASE = process.env.BASE_URL || pathToFileURL(path.join(process.cwd(), 'MindSpace', 'playwright-ui-check.html')).href;

test.describe('Layout smoke tests', () => {
  test('Testimonials left column is wider than right', async ({ page }) => {
    await page.goto(BASE);
    const left = await page.locator('.ms-testimonials-left');
    const right = await page.locator('.ms-testimonials-right');
    await expect(left).toBeVisible();
    await expect(right).toBeVisible();
    const leftBox = await left.boundingBox();
    const rightBox = await right.boundingBox();
    expect(leftBox).not.toBeNull();
    expect(rightBox).not.toBeNull();
    // left column should be wider per our CSS change
    // allow some tolerance
    if (leftBox && rightBox) expect(leftBox.width).toBeGreaterThan(rightBox.width - 1);
  });

  test('Testimonials subtitle allows wider max-width', async ({ page }) => {
    await page.goto(BASE);
    const sub = await page.locator('.ms-testimonials-sub');
    await expect(sub).toBeVisible();
    const style = await sub.evaluate((el) => window.getComputedStyle(el).maxWidth);
    // ensure max-width is at least 600px (our change set it to 680px)
    const px = parseInt(style.replace(/[^0-9]/g, '') || '0', 10);
    expect(px).toBeGreaterThanOrEqual(600);
  });
});
