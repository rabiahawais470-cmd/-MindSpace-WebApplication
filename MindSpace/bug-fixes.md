# MindSpace Website - Complete UI/UX Bug Report & Fix List

**Project:** MindSpace  
**Date:** May 21, 2026  
**Purpose:** Fix all reported layout, typography, and UI issues one by one.

---
## EXECUTION CONTRACT (MANDATORY)

You are NOT allowed to:
- Fix unrelated issues outside the current step
- Perform security refactors unless explicitly listed in the current step
- Mark the task complete unless ALL steps are verified

You MUST:
- Work strictly in the order of the numbered tasks
- Complete ONE section at a time
- Only modify files directly related to the current step
- Prefer UI/CSS fixes first before backend changes unless explicitly required

## 1. Text Cut-off & Typography Issues (High Priority)

- [x] Text is frequently cut off on the right side ("s", "Y", "gentle", etc.) across multiple pages.
- [x] Main headings often have letters cut off (e.g., "Settings", "Progress", "Discussions", "Bookmarks", "Privacy Settings", "Report a Bug", etc.).
- [x] Font style across the entire platform looks too "AI-generated" / robotic. Needs a more professional, readable, and human-friendly font + better font sizes/spacing.
- [x] Tick boxes and form elements have alignment/cut-off issues.

**Pages affected:** Homepage, Dashboard, Courses, Progress, Privacy Settings, FAQ, Report a Bug, Change Password, Notification Preferences, etc.

---

## 2. Sidebar Issues

- [x] **Left vertical sidebar** is cut off / too narrow / not fitting properly when logged in (both user and admin accounts).
- [x] Sidebar appears too white and lacks proper contrast/styling.
- [x] Sidebar is too short in some sections (e.g., Courses page).

---

## 3. Dashboard & Progress Section Issues

- [x] **Recent Activity box** feels confusing:
  - [x] Header says "Recent Activity" but shows "No discussion activity yet" while also showing one course activity ("Self-Care Essentials").
  - [x] Inconsistent and doesn't make sense.
- [x] Progress page layout is broken — cards and sections don't link well or feel disconnected.
- [x] "Browse all" button under Course Progress and "Take a quiz" under Quiz Score History feel unnecessary and strange.

---

## 4. Redundant / Unnecessary Elements

- [x] **"Read our latest research"** button on homepage — already covered by another section. Remove it.
- [x] Search bars in some sections (e.g., Report a Bug) feel unnecessary.

---

## 5. Design & Visual Issues

- [x] Hero section ("Mental wellness is gentle") looks too plain/white. Add subtle animation, gradient, or shaded background.
- [x] Many sections look "AI-generated" and need more professional polish.
- [x] Achievements / Badges section looks poor — redesign it to feel more natural and motivating.
- [x] Some sections (e.g., Voices from Community, Bookmarks) are not fitting the page width properly.

---

## 6. Account & Settings Issues

- [x] **Change Password**, **Privacy Settings**, **Notification Preferences** — font/style issues + cut-off text.
- [x] Logout functionality is buggy (especially from the last option in the menu).
- [x] Admin Dashboard:
  - [x] Sidebar cut-off issue persists.
  - [x] Welcome heading "Welcome, System Administrator" should be rephrased or better styled.
  - [x] "Roles" section under Users is unclear.

---

## 7. Other Issues

- [x] Discussion section is mostly fine but could use more refinement (e.g., show more sample comments).
- [x] Notification bell icon in admin account does nothing (acceptable if intentional, but confirm).
- [x] Overall responsiveness — many elements break on different screen sizes.

---

## Task for AI Agent

Fix these issues **one by one** in priority order:

1. [x] Fix all text cut-off issues and improve global typography/font styling.
2. [x] Fix Sidebar (width, fitting, color/contrast).
3. [x] Fix Dashboard + Recent Activity + Progress page logic and layout.
4. [x] Remove redundant elements.
5. [x] Improve hero section and overall visual polish.
6. [x] Fix Settings, Account, and Admin pages.
7. [x] Final QA pass for responsiveness and consistency.

After fixing each major item, reply with:
- What was fixed
- Relevant code changes (HTML + CSS)

---

Let me know if you need anything clarified or want me to adjust the priority!