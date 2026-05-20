# MindSpace Architecture Overview

**Quick Start:** This is shared context for Kimi 2.6 (UI work) and DeepSeek v4 Pro (bug fixes).

---

## Technology Stack

### Backend
- **Framework:** ASP.NET Web Forms (.NET Framework 4.8)
- **Language:** C#
- **Database:** SQL Server LocalDB
- **Session:** InProc (in-memory), 60-minute timeout
- **Authentication:** Session-based (no OAuth/JWT)

### Frontend
- **Bootstrap:** 5.3 (responsive grid, components)
- **CSS:** Custom `Styles/site.css` (Premium UI v3)
- **Typography:** Jakarta Sans + Inter
- **Icons:** Font Awesome 6.4
- **Charts:** Chart.js 4.4
- **Validation:** ASP.NET validators + custom JavaScript

### Data Access
- **Pattern:** DatabaseHelper static class (App_Code/DatabaseHelper.cs)
- **All queries:** Parameterized (SQL injection safe)
- **Connection:** Web.config → "MindSpaceDB" connection string

---

## Project Organization

```
MindSpace/
├── App_Code/
│   └── DatabaseHelper.cs              # Database access layer (all queries go through here)
├── Admin/
│   ├── AdminHome.aspx / .aspx.cs
│   ├── UserManagement.aspx / .aspx.cs
│   └── CourseManagement.aspx / .aspx.cs
├── User/
│   ├── UserHome.aspx / .aspx.cs
│   ├── Profile.aspx / .aspx.cs
│   ├── ProgressTracking.aspx / .aspx.cs
│   ├── Forum.aspx / .aspx.cs
│   ├── Discussions.aspx / .aspx.cs
│   ├── Bookmarks.aspx / .aspx.cs
│   ├── FAQ.aspx / .aspx.cs
│   ├── ReportBug.aspx / .aspx.cs
│   ├── NotificationPreferences.aspx / .aspx.cs
│   └── PrivacySettings.aspx / .aspx.cs
├── Courses/
│   ├── CourseList.aspx / .aspx.cs
│   ├── CourseDetail.aspx / .aspx.cs
│   ├── Quiz.aspx / .aspx.cs
│   └── QuizResults.aspx / .aspx.cs
├── Handlers/
│   └── BookmarkHandler.ashx.cs
├── Styles/
│   └── site.css                       # All custom CSS
├── Scripts/
│   └── validation.js                  # Client-side validation
├── Database/
│   └── MindSpaceDB.sql                # Schema + seed data
├── Default.aspx / .aspx.cs            # Homepage
├── Login.aspx / .aspx.cs
├── Register.aspx / .aspx.cs
├── ChangePassword.aspx / .aspx.cs
├── Site.Master / .Master.cs           # Master page (navigation)
├── Global.asax / .asax.cs
├── Web.config                         # Database connection, session config
└── MindSpace.csproj                   # Build configuration
```

---

## Core Patterns

### Page Lifecycle (Code-Behind)
All `.aspx.cs` files follow this pattern:

```csharp
public partial class PageName : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 1. Check authentication first
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        // 2. For admin pages, verify role
        string role = Session["Role"]?.ToString() ?? "";
        if (role != "admin")
        {
            Response.Redirect("~/User/UserHome.aspx");
            return;
        }

        // 3. Load data only on initial page load
        if (!IsPostBack)
        {
            LoadData();
        }
        // On postback, ViewState is automatically restored
    }

    private void LoadData()
    {
        // Query database, bind to controls
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Always check validation first
        if (!Page.IsValid) return;

        // Process form, update database
        // Show success/error message
    }
}
```

### Database Access Pattern
```csharp
// SELECT - returns DataTable
string sql = "SELECT * FROM Users WHERE UserID = @id";
SqlParameter[] prms = { new SqlParameter("@id", userId) };
DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);

foreach (DataRow row in dt.Rows)
{
    // Always check DBNull before converting
    int id = (row["UserID"] == DBNull.Value) ? 0 : Convert.ToInt32(row["UserID"]);
    string name = row["FullName"]?.ToString() ?? "Unknown";
}

// INSERT/UPDATE/DELETE - returns affected row count
string sql = "INSERT INTO Users (Username, Email) VALUES (@username, @email)";
SqlParameter[] prms = { 
    new SqlParameter("@username", username),
    new SqlParameter("@email", email)
};
int affected = DatabaseHelper.ExecuteNonQuery(sql, prms);

// Aggregate/Scalar - returns object
object count = DatabaseHelper.ExecuteScalar(
    "SELECT COUNT(*) FROM Users WHERE IsActive = 1", null);
```

### UI Control Patterns
```aspx
<!-- Error/Success Messages -->
<asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger" Visible="false">
    <asp:Literal ID="litError" runat="server"></asp:Literal>
</asp:Panel>

<!-- Data Binding with Repeater -->
<asp:Repeater ID="rptItems" runat="server">
    <ItemTemplate>
        <div class="card">
            <h5><%# Eval("Title") %></h5>
            <p><%# Eval("Description") %></p>
        </div>
    </ItemTemplate>
</asp:Repeater>

<!-- Form Controls -->
<div class="mb-3">
    <label for="txtUsername" class="form-label">Username</label>
    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
</div>
```

---

## Database Schema (Key Tables)

```sql
Users
  UserID (PK)
  Username (UNIQUE)
  Email (UNIQUE)
  PasswordHash
  FullName
  Role (user/admin)
  IsActive

Courses
  CourseID (PK)
  Title
  Category (Stress Management, Mindfulness, Anxiety, Sleep, Resilience, Self-Care)
  Duration (minutes)
  Difficulty (Beginner, Intermediate, Advanced)
  IsActive

Enrollments
  EnrollmentID (PK)
  UserID (FK → Users)
  CourseID (FK → Courses)
  EnrollDate
  IsCompleted
  Progress (%)

Quizzes
  QuizID (PK)
  CourseID (FK → Courses)
  Title
  PassingScore (%)
  TotalQuestions

Questions
  QuestionID (PK)
  QuizID (FK → Quizzes)
  QuestionText
  QuestionType (MultipleChoice, TrueFalse, ShortAnswer)
  CorrectAnswer
  OrderNum

QuestionOptions
  OptionID (PK)
  QuestionID (FK → Questions)
  OptionLabel (A, B, C, D)
  OptionText

QuizResults
  ResultID (PK)
  UserID (FK → Users)
  QuizID (FK → Quizzes)
  Percentage
  AttemptDate
  TimeSpent (seconds)

ForumPosts
  PostID (PK)
  CourseID (FK → Courses)
  UserID (FK → Users)
  Title
  Content
  CreatedDate
  ViewCount

ForumComments
  CommentID (PK)
  PostID (FK → ForumPosts)
  UserID (FK → Users)
  Content
  CreatedDate

UserProgress
  ProgressID (PK)
  UserID (FK → Users)
  CourseID (FK → Courses)
  QuizzesPassed
  AverageScore
  BestScore
  ProgressPercentage
```

---

## Build & Run

### Database Setup
```powershell
# Run MindSpaceDB.sql to create tables and seed data
sqlcmd -S (localdb)\MSSQLLocalDB -d MindSpaceDB -i "MindSpace\Database\MindSpaceDB.sql"
```

### Build
```powershell
# Debug
MSBuild.exe "MindSpace.sln" /p:Configuration=Debug

# Release
MSBuild.exe "MindSpace.sln" /p:Configuration=Release
```

### Run
```powershell
# Start IIS Express on port 8080
iisexpress.exe /path:".\MindSpace" /port:8080

# Access at http://localhost:8080/
```

---

## User Roles & Access

### Unauthenticated
- View homepage (Default.aspx)
- Access Login/Register
- Browse public pages

### Authenticated User (role="user")
- Access User/* pages (dashboard, profile, progress, forum, bookmarks, FAQ, etc.)
- Browse and enroll in courses
- Take quizzes
- View progress tracking
- Participate in community forum

### Admin (role="admin")
- Access Admin/* pages (AdminHome, UserManagement, CourseManagement)
- Create/edit/delete courses and quizzes
- Manage user accounts
- View system analytics

---

## Color Scheme

- **Primary Purple:** `#6F42C1` - Buttons, links, highlights
- **Success Green:** `#198754` - Passed quizzes, complete actions
- **Danger Red:** `#DC3545` - Errors, failed quizzes, destructive actions
- **Warning Orange:** `#FFC107` - In-progress, warnings
- **Light Gray:** `#F8F9FA` - Backgrounds, disabled states
- **Dark Gray:** `#212529` - Text, main content
- **Border Gray:** `#DEE2E6` - Lines, dividers

---

## Critical Configuration

### Web.config
```xml
<connectionStrings>
  <add name="MindSpaceDB"
       connectionString="Server=(localdb)\MSSQLLocalDB;Database=MindSpaceDB;Integrated Security=True;MultipleActiveResultSets=True;"
       providerName="System.Data.SqlClient" />
</connectionStrings>

<sessionState mode="InProc" timeout="60" />  <!-- Session timeout in minutes -->

<compilation debug="true" targetFramework="4.8" batch="false" batchTimeout="300" />
<!-- batch="false" is CRITICAL for per-file dynamic compilation in development -->
```

### MindSpace.csproj
```xml
<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>
<UseIISExpress>true</UseIISExpress>
<Use64BitIISExpress />
```

---

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Classes | PascalCase | `LoginPage`, `QuizPage`, `SiteMaster` |
| Methods | PascalCase | `LoadQuiz()`, `ShowError()`, `BindData()` |
| Properties | PascalCase | `UserId`, `CourseTitle` |
| Private Fields | camelCase | `quizID`, `questionsTable`, `currentUser` |
| Database Columns | PascalCase | `UserID`, `CourseTitle`, `IsActive` |
| ASPX Controls | Prefix + Name | `btnSubmit`, `lblTitle`, `txtUsername`, `pnlError`, `litContent`, `rptItems` |
| CSS Classes | kebab-case | `course-card`, `quiz-option`, `progress-bar` |
| Route Parameters | QueryString | `Request.QueryString["courseID"]` |

---

## Known Issues & Fixes

### DBNull Casting
**Problem:** `InvalidCastException` when database column contains NULL
**Solution:** Check `DBNull.Value` before converting
```csharp
int value = (row["Column"] == DBNull.Value) ? 0 : Convert.ToInt32(row["Column"]);
```

### Validation Duplicates
**Problem:** Multiple error messages for single field
**Solution:** Use single CustomValidator with centralized server-side logic

### Build Configuration
**Problem:** WebApplication.targets import fails
**Solution:** Made import conditional in .csproj file

---

## Quick Links

- **Project Lead:** ahmadmunir288@gmail.com
- **Repository:** https://github.com/rabiahawais470-cmd/-MindSpace-WebApplication
- **Detailed Docs:** PROJECT_DOCUMENTATION.md (page descriptions, workflows, database schema)
- **Kimi 2.6 (UI):** `.ai-tools/kimi-cline/.clinerules`
- **DeepSeek v4 Pro (Bugs):** `.ai-tools/deepseek-v4-pro/.clinerules`
