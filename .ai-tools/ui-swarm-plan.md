# MindSpace UI Debugging Agent Swarm Plan

## Objective
Systematically audit, debug, and improve the UI/Frontend of the MindSpace ASP.NET Web Forms application using a coordinated agent swarm.

## MCP Servers for UI/Frontend Work

### Primary MCP Servers
1. **Playwright MCP** (already used in `.playwright-mcp/`)
   - Automated browser testing
   - Screenshots & visual regression
   - DOM inspection & accessibility tree extraction
   - Console/network log capture

2. **Puppeteer MCP** (if available)
   - Chrome DevTools Protocol access
   - Performance profiling
   - CSS coverage analysis

3. **Browser Tools MCP**
   - Console log streaming
   - Performance timeline recording
   - Accessibility audit (Lighthouse-style)

4. **Web Vitals MCP**
   - CLS/FID/LCP/DI measurement
   - Real page load performance
   - Mobile viewport simulation

### Recommended Windows Installation
```powershell
# Playwright MCP
npm install -g @anthropic-ai/playwright-mcp

# Puppeteer MCP (if needed)  
npm install -g @modelcontextprotocol/puppeteer

# Browser tools (if available as MCP)
# Check: https://github.com/modelcontextprotocol
```

## Agent Swarm Structure

### Agent 1: `ui-public-pages`
**Scope:** Default.aspx, Login.aspx, Register.aspx, ChangePassword.aspx, Site.Master
**Focus:**
- Hero sections, CTA buttons, landing page flow
- Form UX (Login/Register/Change Password)
- Global navigation consistency
- Mobile responsive layout
- Accessibility on public entry points

### Agent 2: `ui-user-pages`
**Scope:** UserHome.aspx, Profile.aspx, ProgressTracking.aspx, Forum.aspx, Discussions.aspx, Bookmarks.aspx, FAQ.aspx, ReportBug.aspx, NotificationPreferences.aspx, PrivacySettings.aspx
**Focus:**
- Dashboard card layouts and grid
- Data visualization (Chart.js on ProgressTracking)
- Forum/discussion styling
- Profile form UX
- Settings page consistency

### Agent 3: `ui-courses-quiz`
**Scope:** CourseList.aspx, CourseDetail.aspx, Quiz.aspx, QuizResults.aspx, Admin pages
**Focus:**
- Course card grids and filters
- Course detail page information architecture
- Quiz question styling and UX
- Quiz results feedback display
- Admin dashboard tables and forms

### Agent 4: `ui-css-architect`
**Scope:** site.css, Web.config (CDN references), Site.Master (includes)
**Focus:**
- CSS architecture and organization
- Bootstrap 5.3 utilisation vs custom overrides
- Color scheme consistency (#6F42C1, #198754, #DC3545)
- Typography (Jakarta Sans + Inter)
- Responsive breakpoint handling
- No inline styles enforcement
- Shadow/elevation consistency
- Animation/transition standards

## Task Dependencies
1. `ui-css-architect` has NO dependencies (can run first)
2. `ui-public-pages`, `ui-user-pages`, `ui-courses-quiz` can run in parallel (no deps on each other)
3. All agents feed findings into a consolidated UI Bug Report

## Execution Order
1. Spawn all 4 agents simultaneously (parallel)
2. Each agent audits assigned pages based on `.clinerules` conventions
3. Agents output structured findings (file, line, issue, severity, suggested fix)
4. Consolidate findings into prioritized action list
5. Author assigns/fixes top-priority items

## Output Format per Agent
```
### Page Name (e.g., Default.aspx)
- **Issue:** Description
  - **Severity:** Critical/Major/Minor
  - **Location:** Line/Element
  - **Standard Violated:** Bootstrap utility miss, custom CSS pattern, color/contrast, responsive, accessibility
  - **Suggested Fix:** ...
```

## Integration Checkpoint
- All findings merged into `ui-audit-report.md`
- Prioritized by: Crash/Blocker > UX degradation > Visual polish > Accessibility fix > Enhancement
