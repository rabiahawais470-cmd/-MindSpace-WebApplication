# AI Tools Instructions Directory

This folder contains specialized instructions for different AI tools working on MindSpace.

## Structure

### `/kimi-cline/`
- **Tool:** Kimi 2.6 integrated with Cline
- **Purpose:** UI/Frontend development, styling, component improvements
- **File:** `.clinerules` (automatically loaded by Cline)
- **Use:** CSS changes, ASPX markup, Bootstrap components, responsive design

### `/deepseek-v4-pro/`
- **Tool:** DeepSeek v4 Pro
- **Purpose:** Bug fixes, code quality, security, performance
- **File:** `.clinerules` (your instructions file)
- **Use:** DBNull errors, SQL injection prevention, validation logic, database consistency

### `/shared/`
- **ARCHITECTURE.md** - Shared context for both tools (technology stack, patterns, database schema, build commands)
- **CRITICAL_FIXES.md** - Known issues and how they were solved (reference for pattern matching)
- **DATABASE.md** - Detailed schema reference with relationships and constraints

---

## How to Use

### For Kimi 2.6 (UI Work)
1. Open the repository in Cline
2. Cline automatically loads `.ai-tools/kimi-cline/.clinerules`
3. Start with: "Make the [page name] responsive" or "Fix the [component] styling"
4. Reference: `.ai-tools/shared/ARCHITECTURE.md` for tech details

### For DeepSeek v4 Pro (Bug Fixes)
1. Copy the instructions from `.ai-tools/deepseek-v4-pro/.clinerules` into your prompt
2. Include the bug description and steps to reproduce
3. Reference: `.ai-tools/shared/ARCHITECTURE.md` and `.ai-tools/deepseek-v4-pro/.clinerules` patterns
4. Example: "I'm getting DBNull casting error on ProgressTracking.aspx line 299. Use the debug patterns in `.clinerules` to fix it."

---

## Key Points

### Both Tools Have Access To:
- ✅ `.ai-tools/shared/ARCHITECTURE.md` - Tech stack, patterns, database schema
- ✅ Their respective `.clinerules` files
- ✅ `PROJECT_DOCUMENTATION.md` - Full project context
- ✅ `Web.config`, `MindSpace.csproj` - Configuration reference
- ✅ All ASPX and C# files in the project

### Not Included (Too Large/Not Useful):
- ❌ `.playwright-mcp/` - Playwright test cache (images/logs)
- ❌ `bin/` & `obj/` - Build artifacts
- ❌ `.git/` - Repository history
- ❌ PNG screenshot files - For visual reference only
- ❌ `MindSpace.sln` binary content (just configs)

---

## Quick Reference

### Kimi 2.6 Commands
```
"Make [page] mobile responsive"
"Update [component] CSS to match premium UI v3"
"Add Bootstrap [class] to [section]"
"Fix the styling of [element] for better [metric]"
```

### DeepSeek v4 Pro Commands
```
"Find and fix the DBNull casting error in [page].aspx.cs"
"Check [page].aspx.cs for SQL injection vulnerabilities"
"Fix the [validation/session/database] bug with [description]"
"Optimize [query/operation] performance"
```

---

## Configuration Files

### For Cline Integration (Kimi)
- `.clinerules` file in `kimi-cline/` folder
- Loaded automatically by Cline IDE extension
- Format: Plain text instructions with code examples
- Cline context window: All project files accessible

### For DeepSeek v4 Pro (Manual)
- Copy contents of `.clinerules` into your system prompt or chat
- Include specific bug details and reproduction steps
- Reference ARCHITECTURE.md for patterns
- Context window: Text + code examples from files

---

## File Organization Philosophy

**Why separate from `.github/`?**
- `.github/` is for GitHub-specific workflows (CI/CD, issue templates)
- `.ai-tools/` is for AI assistant instructions (easy discovery, tool-specific)

**Why accessible to both tools?**
- Cline: Reads files from IDE, looks for `.clinerules`
- DeepSeek: You paste instructions + context manually
- Shared: Same patterns, same project, different specializations

**Why not in git?**
- Consider adding to `.gitignore` if you want to keep them private
- Or track them if you want version history on AI instruction changes

---

## Maintenance

### When to Update Instructions
- After applying a critical bug fix → Add pattern to `.clinerules` files
- After UI redesign → Update Kimi's `.clinerules`
- When you discover new patterns → Add to `shared/ARCHITECTURE.md`

### Example Update Flow
1. DeepSeek fixes DBNull bug with new pattern
2. You copy the pattern into `.ai-tools/deepseek-v4-pro/.clinerules` under "Bug Categories"
3. Next time DeepSeek works on a similar issue, it has the pattern ready

---

## Contact

For questions about these instructions, refer to:
- **Project Lead:** ahmadmunir288@gmail.com
- **Repository:** https://github.com/rabiahawais470-cmd/-MindSpace-WebApplication

For specific tool issues:
- **Cline:** Check Cline IDE documentation
- **DeepSeek:** Provide feedback on instruction quality for refinement
