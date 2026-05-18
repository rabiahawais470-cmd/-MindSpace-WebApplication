# MindSpace — UI Plan
> Mental Wellness Learning Platform  
> Stack: ASP.NET Web Forms 4.8 · Bootstrap 5.3 · Chart.js · Font Awesome 6.4  
> Reference design: Skillzone e-learning UI (screenshots provided)

---

## 1. Design Tokens

### 1.1 Color Palette (copied directly from Skillzone screenshots)

| Token | Value | Usage |
|---|---|---|
| `--color-bg` | `#EDE8F5` | Page background (light lilac) |
| `--color-sidebar-bg` | `#1C1C2E` | Dark sidebar |
| `--color-sidebar-text` | `#FFFFFF` | Sidebar labels |
| `--color-sidebar-active` | `#3D3A6B` | Active nav item fill |
| `--color-primary` | `#7C6FCD` | Primary purple (buttons, links, accents) |
| `--color-primary-hover` | `#6558C0` | Button hover |
| `--color-primary-light` | `#EDE8F5` | Light purple fills (badge bg, selected state) |
| `--color-card-bg` | `#FFFFFF` | Card surfaces |
| `--color-card-border` | `#F0EDF8` | Card border |
| `--color-text-primary` | `#1C1C2E` | Main text |
| `--color-text-secondary` | `#6B7280` | Muted/label text |
| `--color-text-link` | `#7C6FCD` | Links, "View all" |
| `--color-badge-beginner-bg` | `#D1FAE5` | Beginner badge background |
| `--color-badge-beginner-text` | `#065F46` | Beginner badge text |
| `--color-badge-intermediate-bg` | `#FEF3C7` | Intermediate badge background |
| `--color-badge-intermediate-text` | `#92400E` | Intermediate badge text |
| `--color-badge-advanced-bg` | `#FEE2E2` | Advanced badge background |
| `--color-badge-advanced-text` | `#991B1B` | Advanced badge text |
| `--color-success` | `#10B981` | Pass / correct / checkmarks |
| `--color-danger` | `#EF4444` | Fail / error / incorrect |
| `--color-warning` | `#F59E0B` | Warnings, star ratings |
| `--color-tag-bg` | `#1C1C2E` | Dark course tags (like Skillzone) |
| `--color-tag-text` | `#FFFFFF` | Tag text |

### 1.2 Typography

```css
--font-heading: 'Plus Jakarta Sans', sans-serif;
--font-body:    'Inter', sans-serif;

--text-xs:   0.75rem;   /* 12px */
--text-sm:   0.875rem;  /* 14px */
--text-base: 1rem;      /* 16px */
--text-lg:   1.125rem;  /* 18px */
--text-xl:   1.25rem;   /* 20px */
--text-2xl:  1.5rem;    /* 24px */
--text-3xl:  1.875rem;  /* 30px */

--font-weight-normal:   400;
--font-weight-medium:   500;
--font-weight-semibold: 600;
--font-weight-bold:     700;
```

### 1.3 Spacing & Shape

```css
--radius-sm:  8px;
--radius-md:  12px;
--radius-lg:  16px;
--radius-xl:  24px;
--radius-pill: 999px;

--shadow-card: 0 2px 8px rgba(124, 111, 205, 0.08);
--shadow-card-hover: 0 4px 20px rgba(124, 111, 205, 0.15);
--shadow-sidebar: 4px 0 24px rgba(0,0,0,0.12);

--sidebar-width: 240px;
--topbar-height: 64px;
--right-panel-width: 300px;
```

### 1.4 Bootstrap Overrides (add to site.css)

```css
:root {
  --bs-primary: #7C6FCD;
  --bs-primary-rgb: 124, 111, 205;
  --bs-border-radius: 12px;
  --bs-body-bg: #EDE8F5;
  --bs-body-font-family: 'Inter', sans-serif;
}

.btn-primary {
  background-color: var(--color-primary);
  border-color: var(--color-primary);
}
.btn-primary:hover {
  background-color: var(--color-primary-hover);
  border-color: var(--color-primary-hover);
}
```

---

## 2. Global Layout (Site.Master)

```
┌─────────────────────────────────────────────────────────────┐
│  SIDEBAR (240px, dark #1C1C2E)  │  MAIN CONTENT             │
│                                 │  ┌─────────────────────┐  │
│  [Logo] MindSpace               │  │ TOP BAR (search,    │  │
│                                 │  │ bell, avatar)       │  │
│  ● Dashboard                    │  └─────────────────────┘  │
│  ○ Courses                      │                           │
│  ○ Progress                     │  <asp:ContentPlaceHolder> │
│  ○ Forum                        │                           │
│  ○ Profile                      │                           │
│  ─────────────────              │                           │
│  ○ Settings                     │                           │
│  ○ Help                         │                           │
└─────────────────────────────────────────────────────────────┘
```

### Site.Master HTML Skeleton

```html
<body class="d-flex" style="background:var(--color-bg); min-height:100vh;">

  <!-- Sidebar -->
  <nav id="sidebar" style="width:var(--sidebar-width); background:var(--color-sidebar-bg); min-height:100vh; box-shadow:var(--shadow-sidebar);">
    <div class="p-4">
      <!-- Logo -->
      <div class="d-flex align-items-center gap-2 mb-4">
        <img src="~/Images/logo.png" width="32" />
        <span style="color:#fff; font-family:var(--font-heading); font-weight:700; font-size:1.1rem;">MindSpace</span>
      </div>
      <!-- Nav Items -->
      <ul class="nav flex-column gap-1">
        <li class="nav-item">
          <a href="~/User/UserHome.aspx" class="nav-link sidebar-link">
            <i class="fa-solid fa-grid-2"></i> Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a href="~/Courses/CourseList.aspx" class="nav-link sidebar-link">
            <i class="fa-solid fa-book-open"></i> Courses
          </a>
        </li>
        <li class="nav-item">
          <a href="~/User/ProgressTracking.aspx" class="nav-link sidebar-link">
            <i class="fa-solid fa-chart-line"></i> Progress
          </a>
        </li>
        <li class="nav-item position-relative">
          <a href="~/User/Forum.aspx" class="nav-link sidebar-link">
            <i class="fa-solid fa-comments"></i> Forum
            <asp:Literal ID="litForumBadge" runat="server" />
          </a>
        </li>
        <li class="nav-item">
          <a href="~/User/Profile.aspx" class="nav-link sidebar-link">
            <i class="fa-solid fa-user"></i> Profile
          </a>
        </li>
      </ul>
    </div>
    <!-- Bottom links -->
    <div class="mt-auto p-4 pb-5">
      <a href="~/Default.aspx" class="nav-link sidebar-link">
        <i class="fa-solid fa-circle-question"></i> Help
      </a>
      <a href="~/Login.aspx?action=logout" class="nav-link sidebar-link text-danger">
        <i class="fa-solid fa-right-from-bracket"></i> Logout
      </a>
    </div>
  </nav>

  <!-- Main -->
  <div class="flex-grow-1 d-flex flex-column">
    <!-- Top Bar -->
    <header class="d-flex align-items-center justify-content-between px-4" style="height:var(--topbar-height); background:#fff; border-bottom:1px solid var(--color-card-border);">
      <div class="input-group" style="max-width:320px;">
        <span class="input-group-text border-0 bg-light"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
        <input type="text" class="form-control border-0 bg-light" placeholder="Search courses, topics..." />
      </div>
      <div class="d-flex align-items-center gap-3">
        <button class="btn btn-light position-relative rounded-circle p-2">
          <i class="fa-solid fa-bell"></i>
          <asp:Literal ID="litNotifBadge" runat="server" />
        </button>
        <a href="~/User/Profile.aspx">
          <img src="~/Images/avatar-default.png" width="36" height="36" class="rounded-circle" style="object-fit:cover;" />
        </a>
      </div>
    </header>

    <!-- Page Content -->
    <main class="flex-grow-1 p-4">
      <asp:ContentPlaceHolder ID="MainContent" runat="server" />
    </main>
  </div>

</body>
```

### CSS for sidebar links (site.css)

```css
.sidebar-link {
  color: rgba(255,255,255,0.65);
  border-radius: var(--radius-md);
  padding: 10px 14px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: var(--text-sm);
  font-weight: var(--font-weight-medium);
  transition: background 0.15s, color 0.15s;
}
.sidebar-link:hover,
.sidebar-link.active {
  background: var(--color-sidebar-active);
  color: #ffffff;
}
.sidebar-link i { width: 18px; text-align: center; }
```

---

## 3. Page Specifications

---

### 3.1 Default.aspx — Landing / Home Page

**Layout:** No sidebar. Full-width with navbar (logo + Login/Register buttons).

#### Sections

**Hero**
```html
<section class="py-5 text-center" style="background: linear-gradient(135deg, #7C6FCD 0%, #9D8FE0 100%); color:#fff;">
  <h1 style="font-family:var(--font-heading); font-size:3rem; font-weight:700;">Your Mental Wellness Journey Starts Here</h1>
  <p class="lead mb-4">Free micro-courses on stress, mindfulness, resilience, and self-care.</p>
  <a href="Register.aspx" class="btn btn-light btn-lg px-5 rounded-pill" style="color:var(--color-primary); font-weight:600;">Get Started Free</a>
  <a href="Courses/CourseList.aspx" class="btn btn-outline-light btn-lg px-5 ms-2 rounded-pill">Browse Courses</a>
</section>
```

**Stats Bar** (4 pills in a row)
```
[ 📚 6+ Courses ]  [ 🧩 75 Quizzes ]  [ 💰 100% Free ]  [ ⭐ 5.0 Rating ]
```

**Features Grid** (2×3, Bootstrap `row-cols-2 row-cols-md-3`)
| Icon | Feature |
|---|---|
| fa-sitemap | Structured Learning |
| fa-chart-bar | Progress Tracking |
| fa-users | Community Support |
| fa-clipboard-check | Self-Assessments |
| fa-photo-film | Rich Multimedia |
| fa-shield-halved | Safe & Private |

**Featured Courses** — `<asp:Repeater>` rendering course cards (see Component 5.1).

**Footer** — links, copyright, contact email.

#### Server Controls
- `<asp:Repeater ID="rptFeaturedCourses">` — binds top 6 active courses from DB
- `<asp:HyperLink>` for CTA buttons

---

### 3.2 Login.aspx

**Layout:** No sidebar. Centered split card (50/50).

```
┌──────────────────────────────────────────┐
│   LEFT: Branded illustration             │
│   Purple gradient bg                     │
│   Logo + tagline                         │
│   ─────────────────────────────────────  │
│   RIGHT: White card form                 │
│   "Welcome back 👋"                      │
│   Username field                         │
│   Password field (show/hide toggle)      │
│   [Remember me]  [Forgot password?]      │
│   [Sign In] button (full width, purple)  │
│   ─────────────────────────────────────  │
│   "Don't have an account? Register"      │
└──────────────────────────────────────────┘
```

#### Server Controls
```aspx
<asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
<asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
<asp:CheckBox ID="chkRemember" runat="server" />
<asp:CustomValidator ID="cvLogin" runat="server" OnServerValidate="cvLogin_ServerValidate" CssClass="text-danger small" />
<asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-primary w-100 rounded-pill py-2" OnClick="btnLogin_Click" />
<asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-none" />
```

#### Interactions
- `btnLogin_Click` → validate creds → set session `UserID`, `Username`, `Role` → redirect to `/User/UserHome.aspx` (User) or `/Admin/AdminHome.aspx` (Admin)
- Invalid login → show `lblError` with "Invalid username or password"

---

### 3.3 Register.aspx

**Layout:** Same split card as Login.

#### Fields
```
Username      [_____________________]  (3–20 chars, alphanumeric)
Email         [_____________________]  (valid format)
Password      [_____________________]  (strength bar below)
Confirm Pwd   [_____________________]
              [Create Account] ← full width purple pill button
```

**Password strength bar:** `<div>` with JS-driven width + color (red → orange → green).

#### Server Controls
```aspx
<asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
<asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
<asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
<asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
<asp:CustomValidator ID="cvRegister" runat="server" OnServerValidate="cvRegister_ServerValidate" />
<asp:Button ID="btnRegister" runat="server" Text="Create Account" OnClick="btnRegister_Click" CssClass="btn btn-primary w-100 rounded-pill py-2" />
```

#### Validation (server-side, one CustomValidator per field)
- Username: unique, 3–20 chars, alphanumeric only
- Email: valid format, unique in Users table
- Password: 8+ chars, 1 uppercase, 1 lowercase, 1 digit, 1 special char
- Confirm: matches Password

---

### 3.4 ChangePassword.aspx

**Layout:** Authenticated. Sidebar + narrow centered card (max-width: 480px).

```
Current Password   [_____]
New Password       [_____]  + strength bar
Confirm Password   [_____]
[Cancel]  [Update Password]
```

#### Server Controls
```aspx
<asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control" />
<asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" />
<asp:TextBox ID="txtConfirmNewPassword" runat="server" TextMode="Password" CssClass="form-control" />
<asp:CustomValidator ID="cvChangePassword" runat="server" OnServerValidate="cvChangePassword_ServerValidate" />
<asp:Button ID="btnUpdate" runat="server" Text="Update Password" OnClick="btnUpdate_Click" CssClass="btn btn-primary rounded-pill px-4" />
<asp:Label ID="lblSuccess" runat="server" CssClass="alert alert-success" Visible="false" />
```

---

### 3.5 UserHome.aspx — Learner Dashboard

**Layout:** Sidebar + 2-column main (content + right panel), matching Skillzone screenshot 1.

```
┌─────────────┬────────────────────────────────┬────────────────┐
│  SIDEBAR    │  MAIN CONTENT                  │  RIGHT PANEL   │
│             │                                │                │
│  Dashboard  │  "Good morning, [Name] 👋"     │  Calendar      │
│  Courses    │                                │  (mini month)  │
│  Progress   │  Top Courses You May Like      │                │
│  Forum      │  ┌──────┐ ┌──────┐            │  Upcoming      │
│  Profile    │  │card  │ │card  │            │  (next quiz)   │
│             │  └──────┘ └──────┘            │                │
│             │  ┌──────┐ ┌──────┐            │  Productivity  │
│             │  │card  │ │card  │            │  Bar Chart     │
│             │  └──────┘ └──────┘            │                │
│             │                                │                │
│             │  My Courses [View all →]       │                │
│             │  ┌────────────────────────┐    │                │
│             │  │ Course row + progress  │    │                │
│             │  │ Course row + progress  │    │                │
│             │  └────────────────────────┘    │                │
└─────────────┴────────────────────────────────┴────────────────┘
```

#### Top of page — greeting + stats strip

```html
<div class="d-flex align-items-center justify-content-between mb-4">
  <div>
    <h4 style="font-family:var(--font-heading); font-weight:700;">Good morning, <asp:Literal ID="litName" runat="server" /> 👋</h4>
    <p class="text-muted mb-0">Continue your wellness journey.</p>
  </div>
</div>

<!-- Quick Stats Strip -->
<div class="row g-3 mb-4">
  <div class="col-4">
    <div class="card border-0 rounded-3 p-3 text-center" style="background:#fff; box-shadow:var(--shadow-card);">
      <div style="font-size:1.5rem; font-weight:700; color:var(--color-primary);">
        <asp:Literal ID="litEnrolled" runat="server" />
      </div>
      <div class="text-muted small">Enrolled</div>
    </div>
  </div>
  <div class="col-4">
    <div class="card border-0 rounded-3 p-3 text-center" style="background:#fff; box-shadow:var(--shadow-card);">
      <div style="font-size:1.5rem; font-weight:700; color:#10B981;">
        <asp:Literal ID="litCompleted" runat="server" />%
      </div>
      <div class="text-muted small">Completed</div>
    </div>
  </div>
  <div class="col-4">
    <div class="card border-0 rounded-3 p-3 text-center" style="background:#fff; box-shadow:var(--shadow-card);">
      <div style="font-size:1.5rem; font-weight:700; color:#F59E0B;">
        <asp:Literal ID="litAvgScore" runat="server" />%
      </div>
      <div class="text-muted small">Quiz Avg</div>
    </div>
  </div>
</div>
```

#### Top Courses Grid (2×2)

```aspx
<div class="d-flex justify-content-between align-items-center mb-3">
  <h6 class="fw-bold mb-0">Top courses you may like</h6>
  <a href="~/Courses/CourseList.aspx" style="color:var(--color-primary); font-size:var(--text-sm);">View all</a>
</div>
<div class="row row-cols-2 g-3 mb-4">
  <asp:Repeater ID="rptTopCourses" runat="server">
    <ItemTemplate>
      <!-- Course Card — see Component 5.1 -->
    </ItemTemplate>
  </asp:Repeater>
</div>
```

#### My Courses List

```aspx
<asp:Repeater ID="rptMyCourses" runat="server">
  <ItemTemplate>
    <div class="card border-0 rounded-3 mb-2 p-3" style="background:#fff; box-shadow:var(--shadow-card);">
      <div class="d-flex align-items-center gap-3">
        <img src='<%# Eval("ImageUrl") %>' width="48" height="48" class="rounded-2 object-fit-cover" />
        <div class="flex-grow-1">
          <div class="fw-semibold small"><%# Eval("Title") %></div>
          <div class="text-muted" style="font-size:0.75rem;">Sessions completed: <%# Eval("Progress") %>%</div>
          <div class="progress mt-1" style="height:4px;">
            <div class="progress-bar" style="width:<%# Eval("Progress") %>%; background:var(--color-primary);"></div>
          </div>
        </div>
        <a href='<%# "~/Courses/CourseDetail.aspx?id=" + Eval("CourseID") %>' class="btn btn-sm btn-outline-primary rounded-pill">Continue</a>
      </div>
    </div>
  </ItemTemplate>
</asp:Repeater>
```

#### Right Panel — Calendar Widget

```html
<div class="card border-0 rounded-3 p-3 mb-3" style="background:#fff; box-shadow:var(--shadow-card);">
  <div class="d-flex justify-content-between align-items-center mb-2">
    <small class="text-muted"><i class="fa-regular fa-calendar me-1"></i> <asp:Literal ID="litMonth" runat="server" /></small>
    <div>
      <button class="btn btn-sm btn-light py-0 px-1"><i class="fa-solid fa-chevron-left"></i></button>
      <button class="btn btn-sm btn-light py-0 px-1"><i class="fa-solid fa-chevron-right"></i></button>
    </div>
  </div>
  <!-- Static calendar grid — Mo Tu We Th Fr Sa Su + dates -->
  <asp:Literal ID="litCalendar" runat="server" />
</div>
```

#### Right Panel — Productivity Chart

```html
<div class="card border-0 rounded-3 p-3" style="background:#fff; box-shadow:var(--shadow-card);">
  <div class="d-flex justify-content-between align-items-center mb-2">
    <span class="fw-semibold small">Productivity</span>
    <a href="~/User/ProgressTracking.aspx" style="color:var(--color-primary); font-size:0.75rem;">View details</a>
  </div>
  <canvas id="productivityChart" height="120"></canvas>
</div>
```

*Chart.js init in page JS:*
```javascript
new Chart(document.getElementById('productivityChart'), {
  type: 'bar',
  data: {
    labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
    datasets: [
      { label: 'Score', data: [75, 80, 60, 90, 70, 55, 85], backgroundColor: '#7C6FCD', borderRadius: 6 },
      { label: 'Activity', data: [40, 60, 30, 80, 50, 20, 70], backgroundColor: '#C4B5F4', borderRadius: 6 }
    ]
  },
  options: { plugins: { legend: { display: false } }, scales: { x: { grid: { display:false } }, y: { display: false } } }
});
```

#### Code-Behind (UserHome.aspx.cs)

```csharp
protected void Page_Load(object sender, EventArgs e) {
  if (!IsPostBack) {
    int uid = (int)Session["UserID"];
    litName.Text = Session["FirstName"].ToString();
    
    // Stats
    DataTable stats = DatabaseHelper.ExecuteQuery(
      "SELECT COUNT(*) AS Enrolled, AVG(Progress) AS AvgProg FROM Enrollments WHERE UserID=@uid",
      new[] { new SqlParameter("@uid", uid) });
    litEnrolled.Text = stats.Rows[0]["Enrolled"].ToString();
    litCompleted.Text = Convert.ToDecimal(stats.Rows[0]["AvgProg"]).ToString("0");

    // Top courses not enrolled
    rptTopCourses.DataSource = DatabaseHelper.ExecuteQuery(
      "SELECT TOP 4 * FROM Courses WHERE IsActive=1 AND CourseID NOT IN (SELECT CourseID FROM Enrollments WHERE UserID=@uid)",
      new[] { new SqlParameter("@uid", uid) });
    rptTopCourses.DataBind();

    // My courses
    rptMyCourses.DataSource = DatabaseHelper.ExecuteQuery(
      "SELECT c.*, e.Progress FROM Courses c JOIN Enrollments e ON c.CourseID=e.CourseID WHERE e.UserID=@uid ORDER BY e.LastAccessedDate DESC",
      new[] { new SqlParameter("@uid", uid) });
    rptMyCourses.DataBind();

    // Calendar
    litMonth.Text = DateTime.Now.ToString("MMMM yyyy");
    litCalendar.Text = BuildCalendarHtml(DateTime.Now);
  }
}
```

---

### 3.6 Profile.aspx

**Layout:** Sidebar + centered single-column (max-width: 720px).

#### Sections

**Profile Header Card**
```html
<div class="card border-0 rounded-3 p-4 d-flex flex-row align-items-center gap-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <div class="rounded-circle d-flex align-items-center justify-content-center" style="width:80px;height:80px;background:var(--color-primary-light);font-size:2rem;color:var(--color-primary);">
    <i class="fa-solid fa-user"></i>
  </div>
  <div>
    <h5 class="fw-bold mb-0"><asp:Literal ID="litFullName" runat="server" /></h5>
    <div class="text-muted small">@<asp:Literal ID="litUsername" runat="server" /></div>
    <div class="d-flex gap-2 mt-2">
      <span class="badge rounded-pill" style="background:var(--color-primary-light);color:var(--color-primary);">
        <asp:Literal ID="litRole" runat="server" />
      </span>
    </div>
  </div>
</div>
```

**Account Stats Strip** (3 cards: Courses Enrolled / Quizzes Passed / Badges Earned)

**Edit Info Form**
```aspx
<div class="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Personal Information</h6>
  <div class="row g-3">
    <div class="col-6">
      <label class="form-label small text-muted">First Name</label>
      <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
    </div>
    <div class="col-6">
      <label class="form-label small text-muted">Last Name</label>
      <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
    </div>
    <div class="col-12">
      <label class="form-label small text-muted">Email</label>
      <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
    </div>
  </div>
  <div class="d-flex gap-2 mt-3">
    <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary rounded-pill px-4" OnClick="btnSave_Click" />
    <a href="~/ChangePassword.aspx" class="btn btn-outline-secondary rounded-pill px-4">Change Password</a>
  </div>
  <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success mt-2 d-none" />
</div>
```

---

### 3.7 CourseList.aspx

**Layout:** Sidebar + full main content. No right panel.

#### Filter Bar

```html
<div class="d-flex flex-wrap gap-2 mb-4">
  <asp:LinkButton ID="btnAll" runat="server" CssClass="btn btn-sm rounded-pill btn-primary" CommandArgument="All" OnClick="btnFilter_Click">All</asp:LinkButton>
  <asp:LinkButton runat="server" CssClass="btn btn-sm rounded-pill btn-outline-secondary" CommandArgument="Stress Management" OnClick="btnFilter_Click">Stress Management</asp:LinkButton>
  <asp:LinkButton runat="server" CssClass="btn btn-sm rounded-pill btn-outline-secondary" CommandArgument="Mindfulness" OnClick="btnFilter_Click">Mindfulness</asp:LinkButton>
  <asp:LinkButton runat="server" CssClass="btn btn-sm rounded-pill btn-outline-secondary" CommandArgument="Anxiety" OnClick="btnFilter_Click">Anxiety</asp:LinkButton>
  <asp:LinkButton runat="server" CssClass="btn btn-sm rounded-pill btn-outline-secondary" CommandArgument="Sleep Hygiene" OnClick="btnFilter_Click">Sleep Hygiene</asp:LinkButton>
  <asp:LinkButton runat="server" CssClass="btn btn-sm rounded-pill btn-outline-secondary" CommandArgument="Resilience" OnClick="btnFilter_Click">Resilience</asp:LinkButton>
  <asp:LinkButton runat="server" CssClass="btn btn-sm rounded-pill btn-outline-secondary" CommandArgument="Self-Care" OnClick="btnFilter_Click">Self-Care</asp:LinkButton>
</div>
```

#### Search Bar

```aspx
<div class="input-group mb-4" style="max-width:400px;">
  <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
  <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0" placeholder="Search courses..." />
  <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
</div>
```

#### Course Grid (3 columns)

```aspx
<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
  <asp:Repeater ID="rptCourses" runat="server">
    <ItemTemplate>
      <div class="col">
        <!-- Course Card — Component 5.1 -->
      </div>
    </ItemTemplate>
  </asp:Repeater>
</div>
```

#### Code-Behind

```csharp
private void LoadCourses(string category = null, string search = null) {
  string sql = "SELECT c.*, CASE WHEN e.CourseID IS NOT NULL THEN 1 ELSE 0 END AS IsEnrolled, ISNULL(e.Progress,0) AS Progress FROM Courses c LEFT JOIN Enrollments e ON c.CourseID=e.CourseID AND e.UserID=@uid WHERE c.IsActive=1";
  var ps = new List<SqlParameter> { new SqlParameter("@uid", (int)Session["UserID"]) };
  if (!string.IsNullOrEmpty(category) && category != "All") {
    sql += " AND c.Category=@cat";
    ps.Add(new SqlParameter("@cat", category));
  }
  if (!string.IsNullOrEmpty(search)) {
    sql += " AND (c.Title LIKE @s OR c.Description LIKE @s)";
    ps.Add(new SqlParameter("@s", "%" + search + "%"));
  }
  rptCourses.DataSource = DatabaseHelper.ExecuteQuery(sql, ps.ToArray());
  rptCourses.DataBind();
}
```

---

### 3.8 CourseDetail.aspx

**Layout:** Sidebar + 2-column (main left 65%, sidebar right 35%). Matches Skillzone publish page adapted for student view.

#### Left Column

```html
<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-3">
  <ol class="breadcrumb small">
    <li class="breadcrumb-item"><a href="~/User/UserHome.aspx">Dashboard</a></li>
    <li class="breadcrumb-item"><a href="~/Courses/CourseList.aspx">Courses</a></li>
    <li class="breadcrumb-item active"><asp:Literal ID="litCourseTitle" runat="server" /></li>
  </ol>
</nav>

<h3 style="font-family:var(--font-heading); font-weight:700;"><asp:Literal ID="litTitle" runat="server" /></h3>

<!-- Cover Image -->
<img src="" id="imgCover" runat="server" class="img-fluid rounded-3 mb-4 w-100" style="max-height:320px; object-fit:cover;" />

<!-- Description -->
<div class="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-2">About this course</h6>
  <asp:Literal ID="litDescription" runat="server" />
  <asp:Literal ID="litInstructorNotes" runat="server" />
</div>

<!-- Quiz List (Content Sections) -->
<div class="card border-0 rounded-3 p-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Course Quizzes</h6>
  <asp:Repeater ID="rptQuizzes" runat="server">
    <ItemTemplate>
      <div class="d-flex align-items-center justify-content-between p-2 mb-2 rounded-2" style="background:var(--color-primary-light);">
        <div class="d-flex align-items-center gap-2">
          <i class="fa-solid fa-circle-question" style="color:var(--color-primary);"></i>
          <span class="small fw-medium"><%# Eval("Title") %></span>
        </div>
        <div class="d-flex align-items-center gap-2">
          <span class="text-muted small">Pass: <%# Eval("PassingScore") %>%</span>
          <a href='<%# "~/Courses/Quiz.aspx?id=" + Eval("QuizID") %>' class="btn btn-sm btn-primary rounded-pill">Start</a>
        </div>
      </div>
    </ItemTemplate>
  </asp:Repeater>
</div>
```

#### Right Column

```html
<div class="card border-0 rounded-3 p-4 mb-3" style="background:#fff; box-shadow:var(--shadow-card);">
  <!-- Enroll / Progress CTA -->
  <asp:Panel ID="pnlEnroll" runat="server">
    <asp:Button ID="btnEnroll" runat="server" Text="Enroll Now" CssClass="btn btn-primary w-100 rounded-pill py-2 mb-3" OnClick="btnEnroll_Click" />
  </asp:Panel>
  <asp:Panel ID="pnlProgress" runat="server" Visible="false">
    <div class="d-flex justify-content-between small mb-1">
      <span>Your Progress</span>
      <asp:Literal ID="litProgress" runat="server" />%
    </div>
    <div class="progress mb-3" style="height:8px;">
      <div class="progress-bar" id="progressBar" runat="server" style="background:var(--color-primary);"></div>
    </div>
    <a href="" id="lnkContinue" runat="server" class="btn btn-primary w-100 rounded-pill py-2">Continue Learning</a>
  </asp:Panel>

  <!-- Course Metadata -->
  <hr />
  <div class="d-flex justify-content-between small mb-2">
    <span class="text-muted">Category</span>
    <span class="fw-medium"><asp:Literal ID="litCategory" runat="server" /></span>
  </div>
  <div class="d-flex justify-content-between small mb-2">
    <span class="text-muted">Duration</span>
    <span class="fw-medium"><asp:Literal ID="litDuration" runat="server" /> min</span>
  </div>
  <div class="d-flex justify-content-between small mb-2">
    <span class="text-muted">Difficulty</span>
    <asp:Literal ID="litDifficultyBadge" runat="server" />
  </div>
  <div class="d-flex justify-content-between small">
    <span class="text-muted">Quizzes</span>
    <span class="fw-medium"><asp:Literal ID="litQuizCount" runat="server" /></span>
  </div>

  <!-- Community Link -->
  <a href="~/User/Forum.aspx" class="btn btn-outline-secondary w-100 rounded-pill mt-3">
    <i class="fa-solid fa-comments me-1"></i> Community Discussion
  </a>
</div>
```

---

### 3.9 Quiz.aspx — Taking a Quiz

**Layout:** No sidebar (full focus). 2-column: dark left panel (280px) + main content. Matches Skillzone quiz screenshot 3.

```
┌───────────────────────────┬────────────────────────────────────────┐
│  DARK LEFT PANEL          │  MAIN QUIZ AREA                        │
│  [≡ Hide]                 │                                        │
│  Quiz Title               │  Lesson 1 of X — [Week/Module label]  │
│  Student Name             │  ──────────────────────────── [Next]  │
│                           │                                        │
│  ┌─ Quiz 1 (current) ─┐  │  Question 2 of 6                      │
│  │ Question preview   │  │  Instructions text (italic)            │
│  └───────────────────┘  │                                        │
│  ○ Quiz 2               │  [Question text — large bold]          │
│  ○ Quiz 3               │                                        │
│  ○ Quiz 4               │  [Optional image — rounded]            │
│  ○ Quiz 5               │                                        │
│  ○ Quiz 6               │  ┌─────────────────────────────────┐   │
│                           │  │  Answer Option A                │   │
│  ┌─────────────────────┐  │  └─────────────────────────────────┘  │
│  │ Timer               │  │  ┌─────────────────────────────────┐  │
│  │  00 : 59 : 32       │  │  │  Answer Option B                │  │
│  └─────────────────────┘  │  └─────────────────────────────────┘  │
│                           │                                        │
│                           │  [Finish quiz]        [Next question →]│
└───────────────────────────┴────────────────────────────────────────┘
```

#### Left Panel HTML

```html
<div style="width:280px; background:#1C1C2E; min-height:100vh; color:#fff; padding:24px; display:flex; flex-direction:column;">
  <div class="d-flex align-items-center gap-2 mb-3">
    <button onclick="toggleSidebar()" class="btn btn-sm btn-outline-light py-0"><i class="fa-solid fa-bars"></i></button>
    <span class="small text-white-50">Hide</span>
  </div>
  <h6 class="fw-bold mb-1"><asp:Literal ID="litQuizTitle" runat="server" /></h6>
  <div class="d-flex align-items-center gap-2 mb-4">
    <img src="" id="imgStudentAvatar" runat="server" width="28" height="28" class="rounded-circle" />
    <span class="small text-white-50"><asp:Literal ID="litStudentName" runat="server" /></span>
  </div>

  <!-- Question Index List -->
  <div class="d-flex flex-column gap-2 flex-grow-1">
    <asp:Repeater ID="rptQuestionIndex" runat="server">
      <ItemTemplate>
        <div class="rounded-2 p-2 small" style='<%# (int)Eval("DisplayOrder") == currentQ ? "background:#7C6FCD;" : "background:rgba(255,255,255,0.05);" %>'>
          <div class="text-white-50 mb-1">Quiz <%# Eval("DisplayOrder") %></div>
          <div style="font-size:0.75rem; color:#fff;"><%# TruncateText(Eval("QuestionText").ToString(), 60) %></div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>

  <!-- Timer -->
  <div class="rounded-2 p-3 mt-4" style="background:#2D2D3F;">
    <div class="small text-white-50 mb-1">Timer</div>
    <div id="timerDisplay" style="font-size:1.5rem; font-weight:700; font-family:monospace; letter-spacing:0.1em; color:#fff;">00 : 59 : 59</div>
  </div>
</div>
```

#### Main Quiz Area

```html
<div class="flex-grow-1 p-5">
  <!-- Breadcrumb header -->
  <div class="d-flex justify-content-between align-items-start mb-4">
    <div>
      <div style="color:var(--color-primary); font-size:var(--text-sm); font-weight:600;">Lesson <asp:Literal ID="litLessonNum" runat="server" /></div>
      <div class="fw-semibold"><asp:Literal ID="litWeekLabel" runat="server" /></div>
    </div>
    <asp:Button ID="btnNextLesson" runat="server" Text="Next lesson" CssClass="btn btn-outline-secondary rounded-pill" />
  </div>

  <!-- Question -->
  <div class="mb-2 text-muted small">Question <asp:Literal ID="litQNum" runat="server" /> of <asp:Literal ID="litQTotal" runat="server" /></div>
  <p class="text-muted small fst-italic mb-3"><asp:Literal ID="litInstruction" runat="server" /></p>
  <h4 class="fw-bold mb-4" style="font-family:var(--font-heading);"><asp:Literal ID="litQuestionText" runat="server" /></h4>

  <!-- Optional image -->
  <asp:Panel ID="pnlImage" runat="server" Visible="false">
    <img id="imgQuestion" runat="server" class="img-fluid rounded-3 mb-4 w-100" style="max-height:280px; object-fit:cover;" />
  </asp:Panel>

  <!-- Answer Options (MCQ / True-False) -->
  <asp:Repeater ID="rptAnswers" runat="server">
    <ItemTemplate>
      <div class="answer-option mb-3 p-3 rounded-3 border" style="cursor:pointer; transition:all 0.15s;" onclick="selectAnswer(this, '<%# Eval("Value") %>')">
        <asp:RadioButton ID="rbAnswer" runat="server" GroupName="quizAnswer" CssClass="me-2" />
        <%# Eval("Label") %>
      </div>
    </ItemTemplate>
  </asp:Repeater>

  <!-- Short Answer -->
  <asp:Panel ID="pnlShortAnswer" runat="server" Visible="false">
    <asp:TextBox ID="txtShortAnswer" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Type your answer here..." />
  </asp:Panel>

  <!-- Navigation -->
  <div class="d-flex justify-content-between mt-5">
    <asp:Button ID="btnFinish" runat="server" Text="Finish quiz" CssClass="btn btn-outline-secondary rounded-pill px-4" OnClick="btnFinish_Click" />
    <asp:Button ID="btnNext" runat="server" Text="Next question →" CssClass="btn btn-primary rounded-pill px-4" OnClick="btnNext_Click" />
  </div>
</div>
```

#### CSS for answer options

```css
.answer-option {
  background: #fff;
  border-color: var(--color-card-border) !important;
  border-radius: var(--radius-md) !important;
}
.answer-option:hover {
  border-color: var(--color-primary) !important;
  background: var(--color-primary-light);
}
.answer-option.selected {
  border-color: var(--color-primary) !important;
  background: var(--color-primary-light);
}
```

#### Code-Behind key logic

```csharp
// Session keys: QuizID, CurrentQuestion (int index), Answers (Dictionary<int,string>), StartTime
protected void Page_Load(object sender, EventArgs e) {
  if (!IsPostBack) {
    int quizId = int.Parse(Request.QueryString["id"]);
    Session["QuizID"] = quizId;
    Session["CurrentQuestion"] = 0;
    Session["Answers"] = new Dictionary<int, string>();
    Session["StartTime"] = DateTime.Now;
    LoadQuestion(0);
  }
}

private void LoadQuestion(int index) {
  DataTable qs = GetQuestions((int)Session["QuizID"]);
  if (index >= qs.Rows.Count) { SubmitQuiz(); return; }
  DataRow q = qs.Rows[index];
  litQNum.Text = (index + 1).ToString();
  litQTotal.Text = qs.Rows.Count.ToString();
  litQuestionText.Text = q["QuestionText"].ToString();
  // bind answers based on QuestionType
}
```

---

### 3.10 QuizResults.aspx — Results Review

**Layout:** No sidebar (focus mode). 2-column: left panel (course tree) + main results. Matches Skillzone screenshot 5.

#### Left Panel — Course Module Tree

```html
<div style="width:300px; min-height:100vh; background:#fff; border-right:1px solid var(--color-card-border); padding:24px;">
  <!-- Header -->
  <div class="d-flex align-items-center gap-2 mb-2">
    <button class="btn btn-sm btn-outline-secondary py-0"><i class="fa-solid fa-bars"></i></button>
    <span class="small text-muted">Hide</span>
  </div>
  <h6 class="fw-bold mb-1"><asp:Literal ID="litCourseName" runat="server" /></h6>
  <div class="d-flex align-items-center gap-2 mb-2">
    <img src="" id="imgInstructor" runat="server" width="24" height="24" class="rounded-circle" />
    <span class="small text-muted"><asp:Literal ID="litInstructorRef" runat="server" /></span>
  </div>
  <!-- Progress bar -->
  <div class="progress mb-4" style="height:4px;">
    <div class="progress-bar" id="pbarCourse" runat="server" style="background:var(--color-primary);"></div>
  </div>

  <!-- Module tree -->
  <asp:Repeater ID="rptModules" runat="server">
    <ItemTemplate>
      <div class="mb-2">
        <div class="d-flex justify-content-between align-items-start p-2">
          <div>
            <div class="small fw-medium"><%# Eval("Title") %></div>
          </div>
          <asp:Literal ID="litCheckmark" runat="server" />
        </div>
      </div>
    </ItemTemplate>
  </asp:Repeater>
</div>
```

#### Main Results Area

```html
<div class="flex-grow-1 p-5">
  <!-- Lesson header -->
  <div class="d-flex justify-content-between align-items-start mb-4 pb-3 border-bottom">
    <div>
      <div style="color:var(--color-primary); font-size:var(--text-sm);">Lesson <asp:Literal ID="litLessonRef" runat="server" /></div>
      <div class="fw-semibold"><asp:Literal ID="litWeekRef" runat="server" /></div>
    </div>
    <asp:Button ID="btnNextLesson" runat="server" Text="Next lesson" CssClass="btn btn-outline-secondary rounded-pill" OnClick="btnNextLesson_Click" />
  </div>

  <!-- Score Summary -->
  <div class="mb-4">
    <div class="text-muted small mb-1">Results</div>
    <h5 class="fw-bold">You've answered right <asp:Literal ID="litCorrect" runat="server" /> out of <asp:Literal ID="litTotal" runat="server" /> quizzes.</h5>
  </div>

  <!-- Per-question review -->
  <asp:Repeater ID="rptResults" runat="server">
    <ItemTemplate>
      <div class="card border-0 rounded-3 p-4 mb-3" style='background:<%# (bool)Eval("IsCorrect") ? "#F0FFF8" : "#FFF8F8" %>; border-left: 4px solid <%# (bool)Eval("IsCorrect") ? "#10B981" : "#EF4444" %> !important;'>
        <div class="d-flex align-items-center gap-2 mb-2">
          <i class='fa-solid <%# (bool)Eval("IsCorrect") ? "fa-circle-check text-success" : "fa-circle-xmark text-danger" %>'></i>
          <span class="fw-semibold small">Quiz <%# Eval("QuestionNum") %></span>
        </div>
        <p class="fw-medium mb-3"><%# Eval("QuestionText") %></p>

        <!-- Answer options shown with correct highlighted -->
        <asp:Repeater ID="rptOptions" runat="server" DataSource='<%# Eval("Options") %>'>
          <ItemTemplate>
            <div class="d-flex align-items-center gap-2 p-2 mb-1 rounded-2 border" style='<%# GetOptionStyle(Container.DataItem) %>'>
              <div class="rounded-circle border d-flex align-items-center justify-content-center" style="width:18px;height:18px;">
                <%# GetOptionIcon(Container.DataItem) %>
              </div>
              <%# Eval("Label") %>
            </div>
          </ItemTemplate>
        </asp:Repeater>

        <div class="mt-2 fw-semibold small" style='color:<%# (bool)Eval("IsCorrect") ? "#10B981" : "#EF4444" %>'>
          Your answer: <asp:Literal runat="server" Text='<%# Eval("UserAnswer") %>' />
        </div>
        <asp:Panel runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Explanation").ToString()) %>'>
          <div class="mt-2 small text-muted"><strong>Explanation:</strong> <%# Eval("Explanation") %></div>
        </asp:Panel>
      </div>
    </ItemTemplate>
  </asp:Repeater>

  <!-- Bottom actions -->
  <div class="d-flex justify-content-between mt-4">
    <asp:Button ID="btnRetake" runat="server" Text="Retake quiz" CssClass="btn btn-outline-secondary rounded-pill px-4" OnClick="btnRetake_Click" />
    <asp:Button ID="btnNextLesson2" runat="server" Text="Next lesson" CssClass="btn btn-primary rounded-pill px-4" OnClick="btnNextLesson_Click" />
  </div>
</div>
```

---

### 3.11 ProgressTracking.aspx

**Layout:** Sidebar + full main content.

#### Stats Cards Row (4 cards)

```aspx
<div class="row g-3 mb-4">
  <!-- Card template -->
  <div class="col-3">
    <div class="card border-0 rounded-3 p-4" style="background:#fff; box-shadow:var(--shadow-card);">
      <div class="d-flex justify-content-between align-items-start mb-2">
        <div class="rounded-2 p-2" style="background:var(--color-primary-light);">
          <i class="fa-solid fa-book-open" style="color:var(--color-primary);"></i>
        </div>
        <span class="badge rounded-pill small" style="background:#D1FAE5;color:#065F46;">+13%</span>
      </div>
      <div style="font-size:1.75rem; font-weight:700;"><asp:Literal ID="litOverallProgress" runat="server" />%</div>
      <div class="text-muted small">Overall Progress</div>
    </div>
  </div>
  <!-- Repeat for: Quizzes Taken / Forum Posts / Time on Platform -->
</div>
```

#### Quiz Score Chart

```html
<div class="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Quiz Score History</h6>
  <canvas id="quizScoreChart" height="80"></canvas>
</div>
```

```javascript
// Populated from server via hidden fields or inline JSON
new Chart(document.getElementById('quizScoreChart'), {
  type: 'bar',
  data: {
    labels: quizLabels,   // e.g. ["Mindfulness Q1", "Stress Q1", ...]
    datasets: [{
      data: quizScores,
      backgroundColor: quizScores.map(s => s >= 70 ? '#10B981' : '#EF4444'),
      borderRadius: 6
    }]
  },
  options: {
    plugins: {
      legend: { display: false },
      annotation: { annotations: { line: { type:'line', yMin:70, yMax:70, borderColor:'#7C6FCD', borderDash:[6,3] } } }
    },
    scales: { y: { min:0, max:100 } }
  }
});
```

#### Course Progress Cards

```aspx
<asp:Repeater ID="rptCourseProgress" runat="server">
  <ItemTemplate>
    <div class="card border-0 rounded-3 p-3 mb-3" style="background:#fff; box-shadow:var(--shadow-card);">
      <div class="d-flex align-items-center gap-3">
        <div class="rounded-2 d-flex align-items-center justify-content-center" style="width:48px;height:48px;background:var(--color-primary-light);">
          <i class="fa-solid fa-brain" style="color:var(--color-primary);"></i>
        </div>
        <div class="flex-grow-1">
          <div class="fw-semibold"><%# Eval("Title") %></div>
          <div class="text-muted small">Quizzes passed: <%# Eval("QuizzesPassed") %> / <%# Eval("TotalQuizzes") %></div>
          <div class="progress mt-2" style="height:6px;">
            <div class="progress-bar" style="width:<%# Eval("ProgressPercentage") %>%;background:var(--color-primary);"></div>
          </div>
        </div>
        <div class="text-end">
          <div class="fw-bold"><%# Eval("AverageScore") %>%</div>
          <a href='<%# "~/Courses/CourseDetail.aspx?id=" + Eval("CourseID") %>' class="btn btn-sm btn-primary rounded-pill">Continue</a>
        </div>
      </div>
    </div>
  </ItemTemplate>
</asp:Repeater>
```

#### Achievement Badge Grid

```aspx
<div class="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Achievements</h6>
  <div class="row row-cols-2 row-cols-md-5 g-3">
    <asp:Repeater ID="rptBadges" runat="server">
      <ItemTemplate>
        <div class="col text-center">
          <div class="rounded-circle mx-auto mb-2 d-flex align-items-center justify-content-center" style='width:56px;height:56px;background:<%# (bool)Eval("Earned") ? "var(--color-primary-light)" : "#F3F4F6" %>;'>
            <span style="font-size:1.5rem;"><%# Eval("Emoji") %></span>
          </div>
          <div class="small fw-medium" style='color:<%# (bool)Eval("Earned") ? "var(--color-primary)" : "#9CA3AF" %>'><%# Eval("Name") %></div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</div>
```

**Badge data (server-side list):**
| Emoji | Name | Condition |
|---|---|---|
| 🌱 | First Steps | 1+ enrolled |
| 🎓 | Graduate | 1+ completed |
| 📚 | Avid Learner | 3+ enrolled |
| 🏆 | Course Champion | 3+ completed |
| ✏️ | Quiz Taker | 1+ quiz attempted |
| ✅ | Quiz Passer | 1+ quiz passed |
| ⭐ | High Achiever | 3+ quizzes at 70%+ |
| 💬 | Community Voice | 1+ forum post |
| 🤝 | Forum Regular | 5+ contributions |
| 🔥 | Dedicated Learner | 5+ completed + 80% avg |

#### Class Comparison Section

```html
<div class="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Class Comparison</h6>
  <div class="mb-3">
    <div class="d-flex justify-content-between small mb-1">
      <span>Your progress</span><span class="fw-bold"><asp:Literal ID="litUserProg" runat="server" />%</span>
    </div>
    <div class="progress mb-1" style="height:8px;">
      <div class="progress-bar" id="barUserProg" runat="server" style="background:var(--color-primary);"></div>
    </div>
    <div class="d-flex justify-content-between small mb-1">
      <span class="text-muted">Class average</span><span><asp:Literal ID="litClassProg" runat="server" />%</span>
    </div>
    <div class="progress" style="height:8px;">
      <div class="progress-bar" id="barClassProg" runat="server" style="background:#C4B5F4;"></div>
    </div>
  </div>
</div>
```

#### Activity Timeline

```aspx
<asp:Repeater ID="rptActivity" runat="server">
  <ItemTemplate>
    <div class="d-flex gap-3 mb-3">
      <div class="rounded-circle d-flex align-items-center justify-content-center flex-shrink-0" style="width:36px;height:36px;background:var(--color-primary-light);">
        <asp:Literal ID="litIcon" runat="server" />
      </div>
      <div>
        <div class="small fw-medium"><%# Eval("Description") %></div>
        <div class="text-muted" style="font-size:0.75rem;"><%# Eval("Timestamp") %></div>
      </div>
    </div>
  </ItemTemplate>
</asp:Repeater>
```

---

### 3.12 Forum.aspx

**Layout:** Sidebar + main content (max-width: 860px centered in main).

```aspx
<!-- Create post -->
<div class="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Start a Discussion</h6>
  <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-select mb-2" />
  <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control mb-2" placeholder="Topic title..." />
  <asp:TextBox ID="txtPostContent" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control mb-2" placeholder="Share your thoughts..." />
  <asp:Button ID="btnPost" runat="server" Text="Post Discussion" CssClass="btn btn-primary rounded-pill px-4" OnClick="btnPost_Click" />
</div>

<!-- Thread list -->
<asp:Repeater ID="rptPosts" runat="server">
  <ItemTemplate>
    <div class="card border-0 rounded-3 p-4 mb-3" style="background:#fff; box-shadow:var(--shadow-card);">
      <div class="d-flex justify-content-between align-items-start">
        <div class="d-flex gap-3">
          <div class="rounded-circle d-flex align-items-center justify-content-center" style="width:40px;height:40px;background:var(--color-primary-light);flex-shrink:0;">
            <i class="fa-solid fa-user" style="color:var(--color-primary);"></i>
          </div>
          <div>
            <a href='<%# "~/User/Discussions.aspx?post=" + Eval("PostID") %>' class="fw-semibold text-dark text-decoration-none"><%# Eval("Title") %></a>
            <div class="text-muted small mt-1"><%# Server.HtmlEncode(Eval("ContentPreview").ToString()) %></div>
            <div class="d-flex gap-3 mt-2 text-muted" style="font-size:0.75rem;">
              <span><i class="fa-regular fa-user me-1"></i><%# Eval("Username") %></span>
              <span><i class="fa-regular fa-clock me-1"></i><%# Eval("CreatedDate") %></span>
              <span><i class="fa-regular fa-eye me-1"></i><%# Eval("ViewCount") %></span>
              <span><i class="fa-regular fa-comment me-1"></i><%# Eval("CommentCount") %></span>
            </div>
          </div>
        </div>
        <span class="badge rounded-pill small" style="background:var(--color-primary-light);color:var(--color-primary);"><%# Eval("Category") %></span>
      </div>
    </div>
  </ItemTemplate>
</asp:Repeater>
```

---

### 3.13 Discussions.aspx

**Layout:** Sidebar + main content.

```aspx
<asp:DropDownList ID="ddlFilterCourse" runat="server" CssClass="form-select mb-4" style="max-width:280px;" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_Changed" />

<asp:Repeater ID="rptDiscussions" runat="server">
  <ItemTemplate>
    <div class="card border-0 rounded-3 p-3 mb-2" style="background:#fff; box-shadow:var(--shadow-card);">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <a href='<%# "~/User/Discussions.aspx?post=" + Eval("PostID") %>' class="fw-medium text-dark"><%# Eval("Title") %></a>
          <div class="text-muted small"><%# Eval("CourseName") %> · <%# Eval("LastActivity") %></div>
        </div>
        <span class="badge rounded-pill" style="background:var(--color-primary-light);color:var(--color-primary);"><%# Eval("CommentCount") %> replies</span>
      </div>
    </div>
  </ItemTemplate>
</asp:Repeater>
```

---

### 3.14 AdminHome.aspx

**Layout:** Admin sidebar (same dark sidebar, different nav links) + main content.

Admin sidebar links: Dashboard · Users · Courses · ─ · Logout

#### Stats Cards (2×3 grid)

| Stat | Icon | Color |
|---|---|---|
| Total Users | fa-users | primary purple |
| Active Users | fa-user-check | success green |
| Suspended | fa-user-slash | danger red |
| Total Courses | fa-book-open | primary purple |
| Total Enrollments | fa-graduation-cap | warning amber |
| Completion Rate | fa-chart-pie | success green |

#### Recent Activity Log

```aspx
<div class="card border-0 rounded-3 p-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Recent Activity</h6>
  <asp:GridView ID="gvActivity" runat="server" CssClass="table table-hover table-sm"
    AutoGenerateColumns="false" BorderStyle="None">
    <Columns>
      <asp:BoundField DataField="Timestamp" HeaderText="Time" />
      <asp:BoundField DataField="Username" HeaderText="User" />
      <asp:BoundField DataField="Action" HeaderText="Action" />
    </Columns>
  </asp:GridView>
</div>
```

---

### 3.15 UserManagement.aspx

**Layout:** Admin sidebar + full main.

#### Search/Filter bar + Add User button

```aspx
<div class="d-flex gap-2 mb-3">
  <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" style="max-width:280px;" placeholder="Search by username or email..." />
  <asp:DropDownList ID="ddlRoleFilter" runat="server" CssClass="form-select" style="max-width:160px;">
    <asp:ListItem Text="All Roles" Value="" />
    <asp:ListItem Text="User" Value="User" />
    <asp:ListItem Text="Admin" Value="Admin" />
  </asp:DropDownList>
  <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary rounded-pill" OnClick="btnSearch_Click" />
  <asp:Button ID="btnAddUser" runat="server" Text="+ Add User" CssClass="btn btn-outline-primary rounded-pill ms-auto" OnClick="btnAddUser_Click" />
</div>
```

#### Users Table

```aspx
<asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover align-middle"
  AutoGenerateColumns="false" BorderStyle="None" DataKeyNames="UserID"
  OnRowCommand="gvUsers_RowCommand">
  <Columns>
    <asp:BoundField DataField="Username" HeaderText="Username" />
    <asp:BoundField DataField="Email" HeaderText="Email" />
    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
    <asp:TemplateField HeaderText="Role">
      <ItemTemplate>
        <span class="badge rounded-pill" style='background:<%# (string)Eval("Role")=="Admin"?"#EDE8F5":"#D1FAE5" %>;color:<%# (string)Eval("Role")=="Admin"?"#7C6FCD":"#065F46" %>'><%# Eval("Role") %></span>
      </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Status">
      <ItemTemplate>
        <span class="badge rounded-pill" style='background:<%# (bool)Eval("IsActive")?"#D1FAE5":"#FEE2E2" %>;color:<%# (bool)Eval("IsActive")?"#065F46":"#991B1B" %>'>
          <%# (bool)Eval("IsActive") ? "Active" : "Suspended" %>
        </span>
      </ItemTemplate>
    </asp:TemplateField>
    <asp:BoundField DataField="CreatedDate" HeaderText="Joined" DataFormatString="{0:MMM d, yyyy}" />
    <asp:TemplateField HeaderText="Actions">
      <ItemTemplate>
        <asp:LinkButton CommandName="ToggleStatus" CommandArgument='<%# Eval("UserID") %>' runat="server" CssClass="btn btn-sm btn-outline-secondary rounded-pill me-1">
          <%# (bool)Eval("IsActive") ? "Suspend" : "Activate" %>
        </asp:LinkButton>
        <asp:LinkButton CommandName="Delete" CommandArgument='<%# Eval("UserID") %>' runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill" OnClientClick="return confirm('Delete this user?');">Delete</asp:LinkButton>
      </ItemTemplate>
    </asp:TemplateField>
  </Columns>
</asp:GridView>
```

---

### 3.16 CourseManagement.aspx

**Layout:** Admin sidebar + main content. Two panels: course table + edit/create form.

#### Course Table

```aspx
<asp:GridView ID="gvCourses" runat="server" CssClass="table table-hover align-middle"
  AutoGenerateColumns="false" DataKeyNames="CourseID" OnRowCommand="gvCourses_RowCommand">
  <Columns>
    <asp:BoundField DataField="Title" HeaderText="Title" />
    <asp:BoundField DataField="Category" HeaderText="Category" />
    <asp:BoundField DataField="Difficulty" HeaderText="Level" />
    <asp:BoundField DataField="Duration" HeaderText="Duration (min)" />
    <asp:TemplateField HeaderText="Status">
      <ItemTemplate>
        <span class="badge rounded-pill" style='background:<%# (bool)Eval("IsActive")?"#D1FAE5":"#F3F4F6" %>;color:<%# (bool)Eval("IsActive")?"#065F46":"#6B7280" %>'>
          <%# (bool)Eval("IsActive") ? "Active" : "Draft" %>
        </span>
      </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Actions">
      <ItemTemplate>
        <asp:LinkButton CommandName="Edit" CommandArgument='<%# Eval("CourseID") %>' runat="server" CssClass="btn btn-sm btn-outline-primary rounded-pill me-1">Edit</asp:LinkButton>
        <asp:LinkButton CommandName="ManageQuizzes" CommandArgument='<%# Eval("CourseID") %>' runat="server" CssClass="btn btn-sm btn-outline-secondary rounded-pill me-1">Quizzes</asp:LinkButton>
        <asp:LinkButton CommandName="Delete" CommandArgument='<%# Eval("CourseID") %>' runat="server" CssClass="btn btn-sm btn-outline-danger rounded-pill" OnClientClick="return confirm('Delete?');">Delete</asp:LinkButton>
      </ItemTemplate>
    </asp:TemplateField>
  </Columns>
</asp:GridView>
```

#### Create/Edit Course Form

```aspx
<asp:Panel ID="pnlCourseForm" runat="server" CssClass="card border-0 rounded-3 p-4 mb-4" style="background:#fff; box-shadow:var(--shadow-card);">
  <h6 class="fw-bold mb-3">Course Details</h6>
  <div class="mb-3">
    <label class="form-label small text-muted">Title</label>
    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
  </div>
  <div class="mb-3">
    <label class="form-label small text-muted">Description</label>
    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
  </div>
  <div class="row g-3 mb-3">
    <div class="col-6">
      <label class="form-label small text-muted">Category</label>
      <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
        <asp:ListItem>Stress Management</asp:ListItem>
        <asp:ListItem>Mindfulness</asp:ListItem>
        <asp:ListItem>Anxiety</asp:ListItem>
        <asp:ListItem>Sleep Hygiene</asp:ListItem>
        <asp:ListItem>Resilience</asp:ListItem>
        <asp:ListItem>Self-Care</asp:ListItem>
      </asp:DropDownList>
    </div>
    <div class="col-6">
      <label class="form-label small text-muted">Difficulty</label>
      <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
        <asp:ListItem>Beginner</asp:ListItem>
        <asp:ListItem>Intermediate</asp:ListItem>
        <asp:ListItem>Advanced</asp:ListItem>
      </asp:DropDownList>
    </div>
  </div>
  <div class="row g-3 mb-3">
    <div class="col-6">
      <label class="form-label small text-muted">Duration (minutes)</label>
      <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" TextMode="Number" />
    </div>
    <div class="col-6">
      <label class="form-label small text-muted">Image URL</label>
      <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" />
    </div>
  </div>
  <div class="mb-3">
    <label class="form-label small text-muted">Instructor Notes</label>
    <asp:TextBox ID="txtInstructorNotes" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
  </div>
  <div class="form-check form-switch mb-3">
    <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
    <label class="form-check-label small">Active (published)</label>
  </div>
  <div class="d-flex gap-2">
    <asp:Button ID="btnSaveCourse" runat="server" Text="Save Course" CssClass="btn btn-primary rounded-pill px-4" OnClick="btnSaveCourse_Click" />
    <asp:Button ID="btnCancelCourse" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary rounded-pill px-4" OnClick="btnCancelCourse_Click" />
  </div>
</asp:Panel>
```

#### Quiz & Question Manager (shown when "Quizzes" clicked on a course)

3-column layout: left = quiz list, center = question builder, right = quiz overview.

```
┌──────────────────┬──────────────────────────────┬──────────────────┐
│  Quiz List       │  Question Builder             │  Quiz Overview   │
│  + Add Quiz      │                               │                  │
│  [Quiz 1] [Edit] │  Question type selector:      │  Description     │
│  [Quiz 2] [Edit] │  ● Multiple Choice            │  Pass Score %    │
│                  │  ○ True/False                 │                  │
│                  │  ○ Open Ended                 │  Additional      │
│                  │                               │  media upload    │
│                  │  Question text [_________]    │                  │
│                  │                               │                  │
│                  │  Answer option 1 [_____] [x]  │                  │
│                  │  Answer option 2 [_____] [x]  │                  │
│                  │  ✓ Answer option 3 [_____] [x]│                  │
│                  │  Answer option 4 [_____] [x]  │                  │
│                  │  [+ Add Choice]               │                  │
└──────────────────┴──────────────────────────────┴──────────────────┘
```

Question type selector cards (styled like Skillzone screenshot 4):

```html
<div class="mb-3">
  <p class="small fw-semibold text-muted mb-2">Question Type</p>
  <div class="d-flex flex-column gap-2">
    <label class="d-flex align-items-center gap-2 p-2 rounded-2 border" style="cursor:pointer;">
      <input type="radio" name="qtype" value="MultipleChoice" class="form-check-input m-0" />
      <span class="rounded-2 p-1" style="background:#EDE8F5;"><i class="fa-solid fa-list-check" style="color:#7C6FCD;"></i></span>
      <span class="small fw-medium">Multiple Choice</span>
    </label>
    <label class="d-flex align-items-center gap-2 p-2 rounded-2 border" style="cursor:pointer;">
      <input type="radio" name="qtype" value="TrueFalse" class="form-check-input m-0" />
      <span class="rounded-2 p-1" style="background:#F0FFF8;"><i class="fa-solid fa-toggle-on" style="color:#10B981;"></i></span>
      <span class="small fw-medium">True/False</span>
    </label>
    <label class="d-flex align-items-center gap-2 p-2 rounded-2 border" style="cursor:pointer;">
      <input type="radio" name="qtype" value="ShortAnswer" class="form-check-input m-0" />
      <span class="rounded-2 p-1" style="background:#FEF3C7;"><i class="fa-solid fa-pen-to-square" style="color:#F59E0B;"></i></span>
      <span class="small fw-medium">Short Answer</span>
    </label>
  </div>
</div>
```

---

## 4. Reusable Components

### 5.1 Course Card

```html
<div class="card border-0 rounded-3 h-100" style="background:#fff; box-shadow:var(--shadow-card); transition:box-shadow 0.2s;">
  <!-- Cover Image -->
  <div class="position-relative">
    <img src="{ImageUrl}" class="card-img-top rounded-top-3" style="height:160px; object-fit:cover;" />
    <button class="btn btn-light btn-sm position-absolute top-0 end-0 m-2 rounded-circle p-1">
      <i class="fa-regular fa-bookmark"></i>
    </button>
    <!-- Difficulty badge -->
    <span class="badge position-absolute bottom-0 start-0 m-2 rounded-pill px-2 py-1"
      style="background:{DiffBadgeBg};color:{DiffBadgeText};font-size:0.7rem;">
      {Difficulty}
    </span>
  </div>
  <!-- Body -->
  <div class="card-body p-3">
    <div class="d-flex align-items-center gap-2 mb-1">
      <i class="fa-solid fa-users text-muted" style="font-size:0.75rem;"></i>
      <span class="text-muted" style="font-size:0.75rem;">{EnrollmentCount}</span>
      <i class="fa-solid fa-star ms-auto" style="color:#F59E0B;font-size:0.75rem;"></i>
      <span class="text-muted" style="font-size:0.75rem;">4.8</span>
    </div>
    <h6 class="card-title fw-semibold mb-2" style="font-size:0.875rem; line-height:1.4;">{Title}</h6>
    <!-- Instructor -->
    <div class="d-flex align-items-center gap-2 mt-auto">
      <div class="rounded-circle d-flex align-items-center justify-content-center" style="width:24px;height:24px;background:var(--color-primary-light);flex-shrink:0;">
        <i class="fa-solid fa-user" style="font-size:0.65rem;color:var(--color-primary);"></i>
      </div>
      <span class="text-muted" style="font-size:0.75rem;">{Category}</span>
    </div>
    <!-- Progress bar (if enrolled) -->
    <asp:Panel runat="server" Visible="{IsEnrolled}">
      <div class="progress mt-2" style="height:4px;">
        <div class="progress-bar" style="width:{Progress}%;background:var(--color-primary);"></div>
      </div>
      <span class="text-muted" style="font-size:0.7rem;">{Progress}% complete</span>
    </asp:Panel>
    <!-- Enroll button -->
    <a href="/Courses/CourseDetail.aspx?id={CourseID}" class="btn btn-primary btn-sm w-100 rounded-pill mt-2">
      {IsEnrolled ? "Continue" : "View Course"}
    </a>
  </div>
</div>
```

### 5.2 Difficulty Badge Helper (C#)

```csharp
public static string GetDifficultyBadgeHtml(string difficulty) {
  return difficulty switch {
    "Beginner" => "<span class='badge rounded-pill' style='background:#D1FAE5;color:#065F46;'>Beginner</span>",
    "Intermediate" => "<span class='badge rounded-pill' style='background:#FEF3C7;color:#92400E;'>Intermediate</span>",
    "Advanced" => "<span class='badge rounded-pill' style='background:#FEE2E2;color:#991B1B;'>Advanced</span>",
    _ => "<span class='badge rounded-pill bg-secondary'>Unknown</span>"
  };
}
```

### 5.3 Stats Card

```html
<div class="card border-0 rounded-3 p-4 h-100" style="background:#fff; box-shadow:var(--shadow-card);">
  <div class="d-flex justify-content-between align-items-start mb-3">
    <div class="rounded-2 p-2" style="background:var(--color-primary-light);">
      <i class="fa-solid {icon}" style="color:var(--color-primary);"></i>
    </div>
    <span class="badge rounded-pill small" style="background:#D1FAE5;color:#065F46;">{trend}</span>
  </div>
  <div style="font-size:2rem; font-weight:700; font-family:var(--font-heading);">{value}</div>
  <div class="text-muted small">{label}</div>
</div>
```

### 5.4 Notification Badge

```csharp
// In Site.Master code-behind
protected void Page_Load(object sender, EventArgs e) {
  if (Session["UserID"] != null) {
    int uid = (int)Session["UserID"];
    // Unread forum replies count
    object count = DatabaseHelper.ExecuteScalar(
      "SELECT COUNT(*) FROM ForumComments fc JOIN ForumPosts fp ON fc.PostID=fp.PostID WHERE fp.UserID=@uid AND fc.UserID<>@uid AND fc.CreatedDate > ISNULL((SELECT MAX(LastAccessedDate) FROM Enrollments WHERE UserID=@uid), '2000-01-01')",
      new[] { new SqlParameter("@uid", uid) });
    int n = count == DBNull.Value ? 0 : Convert.ToInt32(count);
    if (n > 0)
      litForumBadge.Text = $"<span class='badge rounded-pill position-absolute top-0 end-0' style='background:var(--color-primary);font-size:0.6rem;'>{n}</span>";
  }
}
```

---

## 5. Navigation & Routing Map

```
Default.aspx ──────────────→ Login.aspx ──────────────→ UserHome.aspx (User)
                          └──────────────────────────→ AdminHome.aspx (Admin)

Default.aspx ──────────────→ Register.aspx ───────────→ Login.aspx

UserHome.aspx ─────────────→ CourseList.aspx ─────────→ CourseDetail.aspx ─→ Quiz.aspx ─→ QuizResults.aspx
            └──────────────→ ProgressTracking.aspx
            └──────────────→ Forum.aspx ──────────────→ Discussions.aspx
            └──────────────→ Profile.aspx ────────────→ ChangePassword.aspx

AdminHome.aspx ────────────→ UserManagement.aspx
             └─────────────→ CourseManagement.aspx
```

**Session guard** — add to every authenticated page's `Page_Load`:
```csharp
if (Session["UserID"] == null) Response.Redirect("~/Login.aspx");
if (Page is AdminPage && Session["Role"].ToString() != "Admin") Response.Redirect("~/User/UserHome.aspx");
```

---

## 6. Responsive Breakpoints

| Breakpoint | Sidebar | Layout Change |
|---|---|---|
| `≥lg` (992px+) | Visible, 240px fixed | 2-column / 3-column as designed |
| `md` (768–991px) | Collapsed to icon-only (56px) | Main fills remaining width |
| `sm` (< 768px) | Hidden (off-canvas drawer, hamburger toggle) | Single column, stacked |

**Sidebar responsive CSS:**
```css
@media (max-width: 991px) {
  #sidebar { width: 56px; }
  #sidebar .nav-label { display: none; }
  #sidebar .brand-name { display: none; }
}
@media (max-width: 767px) {
  #sidebar { position: fixed; left: -240px; width: 240px; z-index: 1050; transition: left 0.25s; }
  #sidebar.open { left: 0; }
  .sidebar-overlay { display: block; position:fixed; inset:0; background:rgba(0,0,0,0.5); z-index:1040; }
}
```

---

## 7. ASP.NET Web Forms Implementation Notes

### General Pattern

```csharp
// Every page code-behind follows:
public partial class PageName : System.Web.UI.Page {
  protected void Page_Load(object sender, EventArgs e) {
    AuthGuard();           // redirect if not logged in
    if (!IsPostBack) {
      BindData();          // populate controls
    }
  }
  private void AuthGuard() {
    if (Session["UserID"] == null) Response.Redirect("~/Login.aspx");
  }
}
```

### Control Selection Reference

| Need | Control | Notes |
|---|---|---|
| Repeating list of items | `<asp:Repeater>` | Use for course cards, quiz lists, forum posts |
| Tabular admin data | `<asp:GridView>` | Users table, courses table — set `BorderStyle="None"` |
| Conditional sections | `<asp:Panel Visible="...">` | Use for enroll vs. progress, pass vs. fail |
| Dynamic text output | `<asp:Literal>` | Safe HTML output; use `Server.HtmlEncode()` for user content |
| Form validation | `<asp:CustomValidator>` | One per field; set `Display="Dynamic"` |
| Dropdowns | `<asp:DropDownList>` | Bind DataTable via `.DataSource` + `.DataBind()` |
| Buttons with commands | `<asp:LinkButton CommandName CommandArgument>` | Use in GridView for edit/delete row actions |

### PostBack Considerations

- Wrap all `DataBind()` calls in `if (!IsPostBack)` to avoid losing ViewState on postback
- Store quiz state in Session, not ViewState (session survives across pages)
- Use `Response.Redirect("url", false); Context.ApplicationInstance.CompleteRequest();` to avoid ThreadAbortException
- For quiz timer: implement client-side JS countdown; POST remaining seconds as hidden field on submit

### ViewState

```aspx
<%-- Disable on read-heavy pages for performance --%>
<%@ Page EnableViewState="false" ... %> <%-- CourseList, Forum --%>
<%@ Page EnableViewState="true" ...  %> <%-- Quiz, CourseManagement --%>
```

### DatabaseHelper Usage Per Page

```csharp
// SELECT → DataTable
DataTable dt = DatabaseHelper.ExecuteQuery(sql, params);
rptCourses.DataSource = dt;
rptCourses.DataBind();

// INSERT/UPDATE/DELETE → int (rows affected)
int rows = DatabaseHelper.ExecuteNonQuery(sql, params);

// Single value → object (cast carefully, check DBNull)
object val = DatabaseHelper.ExecuteScalar(sql, params);
int n = (val == null || val == DBNull.Value) ? 0 : Convert.ToInt32(val);
```

---

## 8. Global CSS Additions (site.css)

```css
/* Import fonts */
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap');

/* Smooth transitions */
.card { transition: box-shadow 0.2s ease; }
.card:hover { box-shadow: var(--shadow-card-hover) !important; }

/* Form controls */
.form-control, .form-select {
  border-radius: var(--radius-md);
  border-color: #E5E7EB;
  padding: 10px 14px;
  font-size: var(--text-sm);
}
.form-control:focus, .form-select:focus {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(124,111,205,0.15);
}

/* Buttons */
.btn-primary { border-radius: var(--radius-pill); font-weight: 600; padding: 8px 20px; }
.btn-outline-primary { border-radius: var(--radius-pill); font-weight: 600; padding: 8px 20px; border-color: var(--color-primary); color: var(--color-primary); }
.btn-outline-primary:hover { background: var(--color-primary); color: #fff; }

/* Table */
.table th { font-size: var(--text-sm); color: var(--color-text-secondary); font-weight: 600; border-bottom: 2px solid #F3F4F6; }
.table td { font-size: var(--text-sm); vertical-align: middle; border-bottom: 1px solid #F9FAFB; }

/* Progress bars */
.progress { border-radius: var(--radius-pill); background: #F3F4F6; }
.progress-bar { border-radius: var(--radius-pill); }

/* Scrollbar */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: rgba(124,111,205,0.3); border-radius: 3px; }
```

---

*ui-plan.md — MindSpace Mental Wellness Platform*  
*Generated: May 2026 | Ready for Claude Code implementation*
