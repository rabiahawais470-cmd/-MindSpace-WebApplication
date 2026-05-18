# MindSpace - Mental Wellness Learning Platform

## Project Overview

**MindSpace** is a comprehensive web-based learning platform designed to educate students and young adults about mental wellness, stress management, mindfulness, resilience, and self-care. The platform provides structured micro-courses (30-45 minutes each), interactive quizzes, community forums, and progress tracking to help users build mental health literacy.

**Technology Stack:**
- **Backend:** ASP.NET Web Forms (C#, .NET Framework 4.8)
- **Database:** SQL Server (LocalDB)
- **Frontend:** Bootstrap 5.3, Custom CSS, Font Awesome, Chart.js
- **Architecture:** Three-tier (Presentation, Business Logic, Data Access)

---

## Project Structure

```
MindSpace/
├── App_Code/
│   └── DatabaseHelper.cs          # Database connection and query execution utility
├── Admin/                          # Admin dashboard pages
│   ├── AdminHome.aspx
│   ├── UserManagement.aspx
│   └── CourseManagement.aspx
├── User/                           # User dashboard pages
│   ├── UserHome.aspx
│   ├── Profile.aspx
│   ├── Forum.aspx
│   ├── Discussions.aspx
│   └── ProgressTracking.aspx
├── Courses/                        # Course viewing and quiz pages
│   ├── CourseList.aspx
│   ├── CourseDetail.aspx
│   ├── Quiz.aspx
│   └── QuizResults.aspx
├── Styles/
│   └── site.css                    # Global styling (Premium UI v3)
├── Scripts/
│   └── validation.js               # Client-side validation
├── Database/
│   └── MindSpaceDB.sql             # SQL schema and seed data
├── Default.aspx                    # Home page
├── Login.aspx                      # Authentication
├── Register.aspx                   # User registration
├── ChangePassword.aspx             # Password management
├── Site.Master                     # Master page template
├── Global.asax                     # Application lifecycle
├── Web.config                      # Application configuration
└── MindSpace.csproj               # Project file
```

---

## Database Schema

### Core Tables

#### Users
```sql
UserID (PK)
Username (UNIQUE)
Email (UNIQUE)
PasswordHash
PasswordSalt
FirstName
LastName
Role (User/Admin)
IsActive
CreatedDate
```

#### Courses
```sql
CourseID (PK)
Title
Description
Category (Stress Management, Mindfulness, Anxiety, Sleep Hygiene, Resilience, Self-Care)
Duration (minutes)
Difficulty (Beginner, Intermediate, Advanced)
InstructorNotes
ImageUrl
IsActive
CreatedDate
```

#### Enrollments
```sql
EnrollmentID (PK)
UserID (FK)
CourseID (FK)
EnrollDate
IsCompleted
Progress (%)
LastAccessedDate
```

#### Quizzes
```sql
QuizID (PK)
CourseID (FK)
Title
PassingScore (%)
TotalQuestions
IsActive
```

#### Questions
```sql
QuestionID (PK)
QuizID (FK)
QuestionText
QuestionType (MultipleChoice, TrueFalse, ShortAnswer)
CorrectAnswer
DisplayOrder
```

#### QuizResults
```sql
ResultID (PK)
UserID (FK)
QuizID (FK)
Percentage
AttemptDate
TimeSpent (seconds)
```

#### ForumPosts
```sql
PostID (PK)
CourseID (FK)
UserID (FK)
Title
Content
CreatedDate
IsActive
ViewCount
```

#### ForumComments
```sql
CommentID (PK)
PostID (FK)
UserID (FK)
Content
CreatedDate
IsActive
```

#### UserProgress
```sql
ProgressID (PK)
UserID (FK)
CourseID (FK)
TotalQuizzes
QuizzesPassed
FirstAttemptDate
LastAttemptDate
AverageScore
BestScore
ProgressPercentage
```

---

## User Workflows

### 1. **Guest/Anonymous User**
```
Home Page (Default.aspx)
    ↓
├─→ View Featured Courses
├─→ Browse All Courses (CourseList.aspx)
└─→ Register (Register.aspx) or Login (Login.aspx)
```

### 2. **New User Registration**
```
Register.aspx
    ↓
Enter: Username, Email, Password, Confirm Password
    ↓
Server-side validation (unique username/email, password strength)
    ↓
Password hashing with salt
    ↓
Create user record in database
    ↓
Redirect to Login
```

### 3. **User Authentication**
```
Login.aspx
    ↓
Enter: Username, Password
    ↓
Validate credentials against database
    ↓
If valid: Create session, set authentication cookie
    ↓
Redirect to appropriate dashboard (User/Admin)
```

### 4. **Learner Dashboard Flow**
```
UserHome.aspx (User Dashboard)
    ├─→ Profile.aspx (View/Edit profile, change password)
    ├─→ CourseList.aspx (Browse and enroll in courses)
    ├─→ ProgressTracking.aspx (View learning analytics)
    ├─→ Forum.aspx (View course discussions)
    └─→ Discussions.aspx (Participate in discussions)
```

### 5. **Course Learning Flow**
```
CourseList.aspx
    ↓
Select Course → CourseDetail.aspx
    ↓
├─→ View course content and resources
├─→ Watch videos / Read materials
├─→ Take Quiz (Quiz.aspx)
│       ↓
│   Answer questions
│       ↓
│   Submit answers
│       ↓
│   QuizResults.aspx (View score, feedback)
│       ↓
│   If passed (>= passing score):
│       - Update enrollment progress
│       - Update UserProgress table
│       - Unlock achievements
│   If failed:
│       - Allow retake
│       - Show review resources
│
└─→ Mark course as complete when all quizzes passed
```

### 6. **Progress Tracking**
```
ProgressTracking.aspx
    ├─→ Overall statistics (completion %, quizzes taken, hours spent)
    ├─→ Course progress cards (show % complete, quiz scores)
    ├─→ Quiz score history chart (Chart.js visualization)
    ├─→ Class comparison (user vs class average)
    ├─→ Achievements/Badges (gamification)
    └─→ Recent activity timeline
```

### 7. **Community Engagement**
```
Forum.aspx
    ├─→ View discussion posts
    ├─→ Create new discussion topic
    └─→ Read/Write comments on posts
        ↓
    Discussions.aspx
    ├─→ List all discussions user participated in
    └─→ Quick navigation to posts
```

### 8. **Admin Dashboard Flow**
```
AdminHome.aspx
    ├─→ UserManagement.aspx (View/Manage user accounts, roles, status)
    ├─→ CourseManagement.aspx (Create/Edit/Delete courses, manage quizzes)
    └─→ View system statistics and analytics
```

---

## Page-by-Page Description

### Public Pages

#### Default.aspx (Home Page)
- Hero section with call-to-action
- Featured courses showcase
- Platform benefits highlighted
- Statistics (6+ courses, 100% free, 75 quizzes, 5★ rating)
- Key features grid:
  - Structured Learning
  - Progress Tracking
  - Community Support
  - Self-Assessments
  - Rich Multimedia
  - Safe & Private
- Course cards with "View Course" buttons
- Footer with links and contact info

#### Login.aspx
- Username/Email and password input fields
- "Remember me" option
- Validation with error messages
- Link to registration page
- Server-side authentication against Users table

#### Register.aspx
- Username, Email, Password, Confirm Password fields
- Client and server-side validation:
  - Username: Unique, 3-20 characters, alphanumeric
  - Email: Valid format, unique
  - Password: 8+ characters, contains uppercase, lowercase, number, special char
- Password hashing with PBKDF2 + salt
- User creation with default role (User)
- Redirect to login on success

#### ChangePassword.aspx
- Current password verification
- New password with confirmation
- Password strength requirements
- Updates PasswordHash and PasswordSalt in database

### User Pages

#### UserHome.aspx (Learner Dashboard)
- Personalized greeting
- Quick stats: Enrolled courses, completion %, quiz average
- Currently enrolled courses cards
- Quick links to:
  - Browse Courses
  - View Progress
  - Community Forum
- Recent activity feed

#### Profile.aspx
- View/edit user information (First name, Last name, email)
- Profile picture (if implemented)
- Username display (read-only)
- Change Password link
- Account statistics

#### CourseList.aspx
- Filter by category (Stress Management, Mindfulness, Anxiety, Sleep, Resilience, Self-Care)
- Search functionality
- Course cards display:
  - Course title, description, duration
  - Difficulty level
  - Enrollment status (Enrolled/Not Enrolled)
  - Progress bar (if enrolled)
  - "View Course" button
- Pagination for course list

#### CourseDetail.aspx
- Course title, description, duration, difficulty
- Instructor notes and learning objectives
- Related resources and materials
- Video player (if video content exists)
- Quiz list with passing scores
- Enrollment button (if not enrolled)
- Progress bar (if enrolled)
- Community discussion link
- "Back to Courses" navigation

#### Quiz.aspx
- Display quiz title and instructions
- Load questions dynamically from Questions table
- Render question types:
  - Multiple choice (radio buttons)
  - True/False (radio buttons)
  - Short answer (text input)
- Question counter (e.g., "Question 3 of 10")
- Navigation (Previous, Next, Submit)
- Timer (optional)

#### QuizResults.aspx
- Display score percentage
- Pass/Fail status
- Breakdown of correct/incorrect answers
- Detailed feedback for each question
- Option to:
  - Review answers
  - Retake quiz
  - Return to course
- Update UserProgress table with attempt data

#### ProgressTracking.aspx
- **Stats Cards:**
  - Overall progress %
  - Quizzes taken
  - Forum contributions
  - Time on platform
  
- **Course Progress Section:**
  - List of enrolled courses with progress bars
  - Quizzes passed count
  - Enrollment date
  - "Continue" or "Review" button for each course
  
- **Quiz Score Chart:**
  - Bar chart with Chart.js showing:
    - Individual quiz scores
    - Passing threshold line (70%)
    - Green/red bars based on pass/fail
  
- **Class Comparison:**
  - User's progress vs class average (%)
  - User's quiz score vs class average (%)
  - Forum contributions comparison
  - Visual comparison bars
  
- **Achievements Section:**
  - Badge grid showing earned/locked achievements:
    - 🌱 First Steps (1+ enrolled)
    - 🎓 Graduate (1+ completed)
    - 📚 Avid Learner (3+ enrolled)
    - 🏆 Course Champion (3+ completed)
    - ✏️ Quiz Taker (1+ quiz attempted)
    - ✅ Quiz Passer (1+ quiz passed)
    - ⭐ High Achiever (3+ with 70%+)
    - 💬 Community Voice (1+ forum post)
    - 🤝 Forum Regular (5+ contributions)
    - 🔥 Dedicated Learner (special combo)
  
- **Activity Timeline:**
  - Recent events with timestamps:
    - Course enrollments
    - Quiz completions
    - Forum posts
    - Achievement unlocks

#### Forum.aspx
- List of discussion topics per course
- Create new discussion form
- Display forum posts with:
  - Title, author, date, view count
  - Preview of first few lines
  - Comment count
  - Link to view full discussion
- Pagination

#### Discussions.aspx
- List of discussions user participated in
- Filter by course
- Quick navigation to full discussion

### Admin Pages

#### AdminHome.aspx
- System statistics dashboard
- Total users, active users, suspended accounts
- Total courses, published/draft count
- Total enrollments, completion rate
- Recent activity log
- Quick links to management pages

#### UserManagement.aspx
- Table of all users with columns:
  - Username, Email, First Name, Last Name
  - Role (User/Admin)
  - Status (Active/Suspended)
  - Created date
  - Actions (Edit, Suspend/Activate, Delete)
- Search and filter functionality
- Add new user form
- Edit user form:
  - Change role
  - Suspend/Activate account
  - Reset password

#### CourseManagement.aspx
- Table of all courses
- Create new course form with fields:
  - Title, Description, Category
  - Duration, Difficulty, Instructor notes
  - Course status (Active/Draft)
- Edit course functionality
- Delete course with confirmation
- Manage quizzes for each course
- Add/Edit/Delete questions per quiz

---

## Key Features

### 1. **Authentication & Authorization**
- Username/password authentication
- Password hashing with salt (PBKDF2)
- Session-based authorization
- Role-based access control (User/Admin)
- Secure password change functionality

### 2. **Course Management**
- Create, read, update, delete courses
- Categorize courses (6 categories)
- Track course progress per user
- Support for multiple quiz types
- Course content delivery (videos, materials)

### 3. **Quiz System**
- Multiple question types (MCQ, T/F, Short Answer)
- Configurable passing score per quiz
- Score tracking and history
- Quiz retake functionality
- Instant feedback on answers

### 4. **Progress Tracking**
- Real-time progress calculation
- Personal dashboard with stats
- Quiz score history visualization (Chart.js)
- Class performance comparison
- Achievement/badge system (10 types)
- Activity timeline

### 5. **Community Features**
- Forum for course discussions
- Topic creation and commenting
- User contribution counting
- Active participation badges

### 6. **Admin Features**
- User account management
- Course creation and editing
- Quiz and question management
- System analytics and reporting
- User role assignment

---

## Recent Fixes & Improvements

### 1. **DBNull Casting Error (Fixed)**
**Issue:** ProgressTracking.aspx.cs line 299 threw `InvalidCastException` when database column contained NULL.

**Solution:** Added NULL checking before type conversion:
```csharp
int passed = (r["Passed"] == DBNull.Value) ? 0 : Convert.ToInt32(r["Passed"]);
```

**Impact:** Progress tracking page now loads reliably without runtime errors.

### 2. **Duplicate Validation Messages (Fixed)**
**Issue:** Register.aspx displayed multiple validation error messages for single field (RequiredFieldValidator + RegularExpressionValidator).

**Solution:** Consolidated validators into single CustomValidator per field with centralized server-side validation.

**Impact:** Cleaner UX, single error message per field.

### 3. **Build Infrastructure Optimization (Fixed)**
**Issues:**
- WebApplication.targets import failed when file missing
- IIS Express dynamic compilation couldn't handle Web Application project

**Solutions:**
- Made WebApplication.targets import conditional with existence check
- Configured web.config with `batch="false"` for per-file compilation
- Successfully built with MSBuild

**Impact:** Application now builds and runs reliably in development environment.

---

## Technology Details

### ASP.NET Web Forms Architecture
- **Master Page (Site.Master):** Provides consistent layout and navigation
- **Code-Behind (*.aspx.cs):** Server-side logic for each page
- **Controls:** Literal, Repeater, Panel, CustomValidator, etc.
- **Data Binding:** Server-side control binding with DataTables

### Database Access
```csharp
// DatabaseHelper pattern (App_Code/DatabaseHelper.cs)
DataTable dt = DatabaseHelper.ExecuteQuery(sql, parameters);
int affected = DatabaseHelper.ExecuteNonQuery(sql, parameters);
object scalar = DatabaseHelper.ExecuteScalar(sql, parameters);
```

### Frontend Styling
- **Bootstrap 5.3:** Responsive grid, components
- **Custom CSS (site.css):** 
  - Premium UI v3 with modern typography
  - Jakarta Sans + Inter fonts
  - Custom color scheme (purple primary, green success, etc.)
  - Responsive design for mobile/tablet/desktop
- **Font Awesome 6.4:** Icon library for UI elements
- **Chart.js 4.4:** Interactive quiz score charts

### Session Management
- ASP.NET session state (InProc, 60-minute timeout)
- Authentication forms configured in web.config
- Session user ID used for data filtering

---

## Data Flow Example: Quiz Submission

```
User clicks "Submit Quiz" on Quiz.aspx
    ↓
Client-side validation checks if all questions answered
    ↓
Form POSTs to Quiz.aspx.cs code-behind
    ↓
Server calculates percentage:
    - Count correct answers
    - Calculate percentage = (correct / total) * 100
    ↓
Check if percentage >= quiz's PassingScore
    ↓
Insert QuizResult record:
    INSERT INTO QuizResults (UserID, QuizID, Percentage, AttemptDate)
    ↓
Update UserProgress:
    - Recalculate AverageScore
    - Recalculate BestScore
    - Increment QuizzesPassed (if passed)
    - Recalculate ProgressPercentage
    ↓
Check for new achievements:
    - Query current achievement status
    - Determine unlocked badges
    ↓
Redirect to QuizResults.aspx with results
    ↓
Display score, feedback, and achievements
```

---

## Configuration

### Web.config Settings
```xml
<!-- Database connection -->
<add name="MindSpaceDB" 
     connectionString="Server=(localdb)\MSSQLLocalDB;Database=MindSpaceDB;Integrated Security=True;" />

<!-- Compilation (IIS Express) -->
<compilation debug="true" targetFramework="4.8" batch="false" batchTimeout="300" />

<!-- Session timeout -->
<sessionState mode="InProc" timeout="60" />

<!-- Authentication -->
<authentication mode="None" />

<!-- Error handling -->
<customErrors mode="Off" />
```

### Project Settings (MindSpace.csproj)
```xml
<!-- Target Framework -->
<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>

<!-- Web application settings -->
<UseIISExpress>true</UseIISExpress>
<Use64BitIISExpress />

<!-- WebApplication.targets (optional) -->
<Import Project="$(VSToolsPath)\WebApplications\Microsoft.WebApplication.targets" 
        Condition="'$(VSToolsPath)' != '' and Exists(...)" />
```

---

## Running the Application

### Requirements
- Visual Studio 2022 (Community edition or higher)
- .NET Framework 4.8
- SQL Server LocalDB
- IIS Express

### Build & Run
```powershell
# Build with MSBuild
MSBuild.exe "C:\Learningsytem\MindSpace.sln" /p:Configuration=Debug

# Start IIS Express
iisexpress.exe /path:"C:\Learningsytem\MindSpace" /port:8080

# Access application
http://localhost:8080/
```

### Database Setup
```sql
-- Run MindSpaceDB.sql to create schema and seed data
-- Located at: MindSpace/Database/MindSpaceDB.sql
```

---

## Current Status

✅ **Completed Features:**
- User authentication and registration
- Course management and enrollment
- Quiz system with multiple question types
- Progress tracking with analytics
- Community forum and discussions
- Admin dashboard and user management
- Achievement/badge system
- Mobile-responsive design
- DBNull error handling
- Build infrastructure optimization

✅ **Recent Commits:**
- Fix DBNull casting errors in ProgressTracking.aspx.cs
- Fix duplicate validation error messages on Register.aspx
- Configure IIS Express for dynamic compilation
- Make WebApplication.targets import optional in build

🟢 **Status:** Production-Ready

---

## Future Enhancements

- [ ] Email notifications for forum replies
- [ ] Course certificates upon completion
- [ ] Leaderboard system
- [ ] Mobile app (React Native/Flutter)
- [ ] Video content integration
- [ ] Advanced analytics dashboard
- [ ] Social features (follow users, share achievements)
- [ ] Payment integration (premium courses)
- [ ] API documentation (REST/GraphQL)
- [ ] Unit and integration test suite

---

## Support & Contact

**Email:** ahmadmunir288@gmail.com  
**Repository:** https://github.com/rabiahawais470-cmd/-MindSpace-WebApplication

---

*Documentation created: May 18, 2026*
*Project: MindSpace Mental Wellness Learning Platform*
