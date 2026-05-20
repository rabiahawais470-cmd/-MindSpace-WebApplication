# Copilot Instructions for MindSpace

## Build & Run Commands

### Building
```powershell
# Build the solution (Debug configuration)
MSBuild.exe "MindSpace.sln" /p:Configuration=Debug

# Build with Release configuration
MSBuild.exe "MindSpace.sln" /p:Configuration=Release
```

### Running
```powershell
# Start IIS Express
iisexpress.exe /path:".\MindSpace" /port:8080

# Access application
http://localhost:8080/
```

### Database Setup
Execute the SQL schema and seed data:
```powershell
# Run the SQL file in SQL Server Management Studio or sqlcmd
sqlcmd -S (localdb)\MSSQLLocalDB -d MindSpaceDB -i "MindSpace\Database\MindSpaceDB.sql"
```

**Note:** The application uses SQL Server LocalDB. Ensure the connection string in `Web.config` matches your LocalDB instance name.

### Development Notes
- The project compiles as a web application library (`bin\` output)
- IIS Express serves pages dynamically from the project directory
- `batch="false"` in Web.config enables per-file dynamic compilation (critical for development)
- **Playwright MCP** is configured for browser automation and end-to-end testing (see Testing section below)

---

## High-Level Architecture

### Three-Tier Structure
```
Presentation (ASPX Pages)
    ↓
Business Logic (Code-Behind, DatabaseHelper)
    ↓
Data Access (SQL Server via DatabaseHelper)
    ↓
Database (SQL Server LocalDB, MindSpaceDB)
```

### Key Components

#### Pages & Workflows
- **Public:** Default.aspx (home), Login.aspx, Register.aspx, ChangePassword.aspx
- **User Dashboard:** User/UserHome.aspx, User/Profile.aspx, User/ProgressTracking.aspx
- **Courses:** Courses/CourseList.aspx, Courses/CourseDetail.aspx, Courses/Quiz.aspx, Courses/QuizResults.aspx
- **Community:** User/Forum.aspx, User/Discussions.aspx
- **Admin:** Admin/AdminHome.aspx, Admin/UserManagement.aspx, Admin/CourseManagement.aspx
- **Additional:** User/Bookmarks.aspx, User/FAQ.aspx, User/ReportBug.aspx, User/NotificationPreferences.aspx, User/PrivacySettings.aspx

#### Session & Authentication
- Session-based (InProc, 60-minute timeout)
- Session stores: UserID, FullName, Username, Role (admin/user)
- Checked on every protected page via `if (Session["UserID"] == null) Response.Redirect("~/Login.aspx");`
- Password hashing: SHA256 (see DatabaseHelper.HashPassword)

#### Database Schema
- **Users:** UserID (PK), Username, Email, PasswordHash, FullName, Role, IsActive
- **Courses:** CourseID, Title, Category, Duration, Difficulty, InstructorNotes, ImageUrl, IsActive
- **Enrollments:** EnrollmentID, UserID, CourseID, EnrollDate, IsCompleted, Progress (%)
- **Quizzes:** QuizID, CourseID, Title, PassingScore (%), TotalQuestions
- **Questions:** QuestionID, QuizID, QuestionText, QuestionType (MultipleChoice/TrueFalse/ShortAnswer), CorrectAnswer, OrderNum
- **QuizResults:** ResultID, UserID, QuizID, Percentage, AttemptDate, TimeSpent
- **ForumPosts:** PostID, CourseID, UserID, Title, Content, CreatedDate, ViewCount
- **ForumComments:** CommentID, PostID, UserID, Content, CreatedDate
- **UserProgress:** ProgressID, UserID, CourseID, TotalQuizzes, QuizzesPassed, AverageScore, BestScore, ProgressPercentage

#### Frontend & Styling
- **Bootstrap 5.3** for responsive grid and components
- **Custom CSS (Styles/site.css):** Premium UI v3, Jakarta Sans + Inter fonts, purple primary color
- **Font Awesome 6.4** for icons
- **Chart.js 4.4** for quiz score visualizations

---

## Key Conventions

### DatabaseHelper Pattern (App_Code/DatabaseHelper.cs)
All database access goes through static DatabaseHelper methods:

```csharp
// SELECT queries return DataTable
DataTable dt = DatabaseHelper.ExecuteQuery(sql, parameters);
foreach (DataRow row in dt.Rows) { /* process */ }

// INSERT/UPDATE/DELETE return affected row count
int affected = DatabaseHelper.ExecuteNonQuery(sql, parameters);

// Aggregates or single values return object
object result = DatabaseHelper.ExecuteScalar(sql, parameters);
```

**Always use parameterized queries to prevent SQL injection:**
```csharp
string sql = "SELECT * FROM Users WHERE UserID = @id";
SqlParameter[] prms = { new SqlParameter("@id", userId) };
DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);
```

### Page Lifecycle & ViewState
```csharp
protected void Page_Load(object sender, EventArgs e)
{
    // Check authentication first
    if (Session["UserID"] == null) Response.Redirect("~/Login.aspx");

    // IsPostBack distinguishes initial page load from form submission
    if (!IsPostBack)
    {
        LoadInitialData();
    }
    // On postback, ViewState is automatically restored
}

// Button click handlers (protected void btnName_Click)
protected void btnSubmit_Click(object sender, EventArgs e)
{
    if (!Page.IsValid) return; // Respect validation state
    // Process form
}
```

### UI Control Patterns
- **Panels** for conditional visibility: `pnlError.Visible = true/false;`
- **Literal controls** for dynamic content: `litError.Text = "Error message";`
- **Repeater** for data binding: `rptItems.DataSource = dt; rptItems.DataBind();`
- **Master page (Site.Master)** provides consistent layout and navigation

### Error Handling
```csharp
private void ShowError(string message)
{
    pnlError.Visible = true;
    litError.Text = message;
}

private void ShowSuccess(string message)
{
    pnlSuccess.Visible = true;
    litSuccess.Text = message;
}
```

### Data Type Conversions
Always handle DBNull explicitly to prevent InvalidCastException:
```csharp
// DO NOT: int value = Convert.ToInt32(row["Column"]);
// DO:
int value = (row["Column"] == DBNull.Value) ? 0 : Convert.ToInt32(row["Column"]);
string text = row["Column"]?.ToString() ?? "default";
```

### Validation
- Client-side: Validators (RequiredFieldValidator, RegularExpressionValidator) in ASPX markup
- Server-side: Custom validation in code-behind after `if (!Page.IsValid) return;`
- Password strength: 8+ chars, uppercase, lowercase, number, special char (checked in Register.aspx.cs)
- Session checks redirect to Login.aspx before any protected operations

### Naming Conventions
- Classes: PascalCase (LoginPage, QuizPage, SiteMaster)
- Methods: PascalCase (LoadQuiz, ShowError)
- Private fields: camelCase (quizID, questionsTable)
- ASPX controls: Prefix + descriptive name (btnSubmit, lblTitle, txtUsername, pnlError, litContent, rptItems)
- Route parameters: QueryString (Request.QueryString["paramName"])

### Configuration
- Connection string: `web.config` → `<connectionStrings>` → "MindSpaceDB"
- Session timeout: `web.config` → `<sessionState timeout="60">`
- Compilation: `batch="false"` enables dynamic per-file compilation (development-critical)

---

## Common Tasks

### Add a New Protected Page
1. Create `PageName.aspx` with `Site.Master` MasterPageFile
2. Add session check in Page_Load: `if (Session["UserID"] == null) Response.Redirect("~/Login.aspx");`
3. Implement data loading (if needed): `if (!IsPostBack) LoadData();`
4. Add navigation link to Site.Master for the appropriate role

### Query the Database
```csharp
string sql = @"
    SELECT Column1, Column2, Column3
    FROM   TableName
    WHERE  SomeColumn = @param
    ORDER  BY Column1";

SqlParameter[] prms = { new SqlParameter("@param", value) };
DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);

if (dt.Rows.Count > 0)
{
    DataRow row = dt.Rows[0];
    string value = row["Column1"]?.ToString() ?? "";
}
```

### Create/Update/Delete
```csharp
string sql = "INSERT INTO TableName (Col1, Col2) VALUES (@val1, @val2)";
SqlParameter[] prms = {
    new SqlParameter("@val1", value1),
    new SqlParameter("@val2", value2)
};
int affected = DatabaseHelper.ExecuteNonQuery(sql, prms);
if (affected > 0) ShowSuccess("Record created.");
else ShowError("Failed to create record.");
```

### Render Dynamic Controls
Use Repeater with inline rendering:
```aspx
<asp:Repeater ID="rptItems" runat="server">
    <ItemTemplate>
        <div><%# Eval("ItemName") %></div>
        <p><%# Eval("ItemDescription") %></p>
    </ItemTemplate>
</asp:Repeater>
```

### Role-Based Access
```csharp
string role = Session["Role"]?.ToString() ?? "";
if (role != "admin")
{
    Response.Redirect("~/User/UserHome.aspx");
    return;
}
```

---

## Critical Fixes Applied

### 1. DBNull Casting Errors
Always check for DBNull before converting:
```csharp
int value = (row["Column"] == DBNull.Value) ? 0 : Convert.ToInt32(row["Column"]);
```
This prevents InvalidCastException on NULL database columns.

### 2. Duplicate Validation Messages
Use single CustomValidator per field with centralized server-side logic, not multiple validators.

### 3. Build Configuration
- Made WebApplication.targets import conditional: `Condition="'$(VSToolsPath)' != '' and Exists(...)"`
- Set `batch="false"` in compilation element for per-file dynamic compilation

---

## Testing with Playwright

Playwright MCP is configured for browser automation and end-to-end testing. Test artifacts are cached in `.playwright-mcp/`.

### Critical User Workflows to Test
1. **Authentication:** Register → Login → Dashboard redirect by role
2. **Course Enrollment:** Browse courses → Enroll → View progress
3. **Quiz Submission:** Load quiz → Answer questions → Submit → View results → Verify progress update
4. **Admin Functions:** Login as admin → Create/edit course → Manage users → View analytics
5. **Community Engagement:** Create forum post → Add comment → Verify view counts

### Example Test Structure
```javascript
// Test: User completes a quiz and checks progress
test('Quiz completion updates progress', async ({ page }) => {
  // Navigate to course
  await page.goto('http://localhost:8080/Courses/CourseDetail.aspx?courseID=1');
  
  // Click quiz button
  await page.click('text=Take Quiz');
  
  // Answer questions
  for (let i = 1; i <= 5; i++) {
    await page.click(`input[name="q${i}"][value="A"]`);
  }
  
  // Submit
  await page.click('button:has-text("Submit")');
  
  // Verify results page
  await expect(page).toHaveURL(/QuizResults/);
  await expect(page.locator('.score-percentage')).toBeVisible();
});
```

### Running Tests
```powershell
# Run all tests
npx playwright test

# Run specific test file
npx playwright test tests/e2e/authentication.spec.ts

# Run with UI mode for debugging
npx playwright test --ui

# Record new tests
npx playwright codegen http://localhost:8080
```

---

## Related Documentation
- See `PROJECT_DOCUMENTATION.md` for full database schema, user workflows, page descriptions, and feature details
- See `Web.config` for connection string configuration
- See `MindSpace.csproj` for project build settings
