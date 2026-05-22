using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

namespace MindSpace
{
    public partial class UserHome : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (Session["Role"]?.ToString() == "admin")
            {
                Response.Redirect("~/Admin/AdminHome.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int userID = Convert.ToInt32(Session["UserID"]);
                LoadWelcomeBanner(userID);
                LoadStats(userID);
                LoadEnrolledCourses(userID);
                LoadCertificates(userID);
                int discussionCount = LoadDiscussionActivity(userID);
                int quizCount = LoadQuizResults(userID);
                pnlNoActivity.Visible = discussionCount == 0 && quizCount == 0;
                LoadProfileCard(userID);
                LoadAchievements(userID);
            }
        }

        // ============================================================
        // WELCOME BANNER
        // ============================================================
        private void LoadWelcomeBanner(int userID)
        {
            string fullName = Session["FullName"]?.ToString() ?? "Learner";
            litWelcome.Text       = HttpUtility.HtmlEncode(fullName.Split(' ')[0]);
            litAvatarInitial.Text = fullName.Length > 0 ? HttpUtility.HtmlEncode(fullName[0].ToString().ToUpper()) : "U";

            object joined = DatabaseHelper.ExecuteScalar(
                "SELECT DateRegistered FROM Users WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) });
            litMemberSince.Text = (joined != null && joined != DBNull.Value)
                ? Convert.ToDateTime(joined).ToString("MMMM yyyy") : "";
        }

        // ============================================================
        // STATS CARDS
        // ============================================================
        private void LoadStats(int userID)
        {
            litEnrolled.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }).ToString();

            litCompleted.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE UserID=@uid AND IsCompleted=1",
                new[] { new SqlParameter("@uid", userID) }).ToString();

            litQuizzesTaken.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizResults WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }).ToString();

            // Forum posts + comments combined
            object fp = DatabaseHelper.ExecuteScalar(
                @"SELECT (SELECT COUNT(*) FROM ForumPosts    WHERE UserID=@uid AND IsActive=1) +
                         (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", userID) });
            litForumPosts.Text = fp?.ToString() ?? "0";
        }

        // ============================================================
        // ENROLLED COURSES
        // ============================================================
        private void LoadEnrolledCourses(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT e.CourseID, c.Title, c.Category, e.Progress, e.IsCompleted
                FROM   Enrollments e
                JOIN   Courses c ON e.CourseID = c.CourseID
                WHERE  e.UserID = @uid
                ORDER  BY e.IsCompleted ASC, e.EnrollDate DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoCourses.Visible = true;
                rptEnrolled.Visible  = false;
            }
            else
            {
                pnlNoCourses.Visible = false;
                rptEnrolled.DataSource = dt;
                rptEnrolled.DataBind();
            }
        }

        // ============================================================
        // CERTIFICATES (completed courses)
        // ============================================================
        private void LoadCertificates(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT e.EnrollmentID, e.UserID, e.CourseID, e.EnrollDate,
                       c.Title, c.Category
                FROM   Enrollments e
                JOIN   Courses c ON e.CourseID = c.CourseID
                WHERE  e.UserID = @uid AND e.IsCompleted = 1
                ORDER  BY e.EnrollDate DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count > 0)
            {
                pnlCertificates.Visible  = true;
                litCertCount.Text        = dt.Rows.Count.ToString();
                rptCertificates.DataSource = dt;
                rptCertificates.DataBind();
            }
            else
            {
                pnlCertificates.Visible = false;
            }
        }

        // ============================================================
        // DISCUSSION ACTIVITY (last 5 posts + comments)
        // ============================================================
        private int LoadDiscussionActivity(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT TOP 5 ActivityType, PostID, Label, DatePosted, Context
                FROM (
                    SELECT 'post' AS ActivityType,
                           fp.PostID,
                           fp.Title AS Label,
                           fp.DatePosted,
                           CAST(NULL AS NVARCHAR(200)) AS Context
                    FROM   ForumPosts fp
                    WHERE  fp.UserID = @uid AND fp.IsActive = 1

                    UNION ALL

                    SELECT 'reply',
                           fc.PostID,
                           LEFT(fc.Content, 80),
                           fc.DatePosted,
                           fp.Title
                    FROM   ForumComments fc
                    JOIN   ForumPosts fp ON fc.PostID = fp.PostID
                    WHERE  fc.UserID = @uid AND fc.IsActive = 1
                ) AS Combined
                ORDER BY DatePosted DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                rptActivity.Visible = false;
                return 0;
            }

            rptActivity.Visible = true;
            rptActivity.DataSource = dt;
            rptActivity.DataBind();
            return dt.Rows.Count;
        }

        // ============================================================
        // QUIZ RESULTS
        // ============================================================
        private int LoadQuizResults(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT TOP 5 qr.Score, qr.TotalQuestions, qr.Percentage, qr.DateTaken,
                       q.Title AS QuizTitle
                FROM   QuizResults qr
                JOIN   Quizzes q ON qr.QuizID = q.QuizID
                WHERE  qr.UserID = @uid
                ORDER  BY qr.DateTaken DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoQuizzes.Visible   = true;
                rptQuizResults.Visible = false;
                return 0;
            }

            pnlNoQuizzes.Visible      = false;
            rptQuizResults.DataSource = dt;
            rptQuizResults.DataBind();
            return dt.Rows.Count;
        }

        // ============================================================
        // PROFILE CARD
        // ============================================================
        private void LoadProfileCard(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(
                "SELECT FullName, Username, Bio FROM Users WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0) return;
            DataRow row = dt.Rows[0];

            string fullName = row["FullName"].ToString();
            string bio      = row["Bio"]?.ToString() ?? "";

            litProfileName.Text    = HttpUtility.HtmlEncode(fullName);
            litProfileUsername.Text = HttpUtility.HtmlEncode(row["Username"].ToString());
            litProfileInitial.Text = fullName.Length > 0 ? HttpUtility.HtmlEncode(fullName[0].ToString().ToUpper()) : "U";

            if (!string.IsNullOrWhiteSpace(bio))
            {
                pnlBio.Visible    = true;
                litProfileBio.Text = HttpUtility.HtmlEncode(bio);
            }
            else
            {
                pnlBio.Visible = false;
            }
        }

        // ============================================================
        // ACHIEVEMENTS
        // ============================================================
        private void LoadAchievements(int userID)
        {
            int enrolled     = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }));
            int completed    = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE UserID=@uid AND IsCompleted=1",
                new[] { new SqlParameter("@uid", userID) }));
            int quizzesTaken = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizResults WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }));
            int forumPosts   = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                @"SELECT (SELECT COUNT(*) FROM ForumPosts    WHERE UserID=@uid AND IsActive=1) +
                         (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", userID) }));
            int highScores   = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizResults WHERE UserID=@uid AND Percentage >= 70",
                new[] { new SqlParameter("@uid", userID) }));

            var badges = new List<(string IconClass, string Name, string Desc, bool Unlocked)>
            {
                ("fa-leaf", "First Steps",       "Enrolled in your first course",         enrolled >= 1),
                ("fa-graduation-cap", "Graduate",          "Completed your first course",           completed >= 1),
                ("fa-book", "Avid Learner",      "Enrolled in 3 or more courses",         enrolled >= 3),
                ("fa-trophy", "Course Champion",   "Completed 3 or more courses",           completed >= 3),
                ("fa-pen",  "Quiz Taker",        "Attempted your first quiz",             quizzesTaken >= 1),
                ("fa-star", "High Achiever",     "Scored 70%+ on 3 or more quizzes",     highScores >= 3),
                ("fa-comments", "Community Voice",   "Made your first forum post",            forumPosts >= 1),
                ("fa-handshake", "Forum Regular",     "Made 5 or more forum contributions",    forumPosts >= 5),
            };

            var sb = new StringBuilder();
            foreach (var (iconClass, name, desc, unlocked) in badges)
            {
                string cls = unlocked ? "unlocked" : "locked";
                sb.Append($@"<div class=""achievement-badge {cls}"">
                    <span class=""badge-icon""><i class=""fa-solid {iconClass}""></i></span>
                    <div class=""badge-info"">
                        <div class=""badge-name"">{HttpUtility.HtmlEncode(name)}</div>
                        <div class=""badge-desc"">{HttpUtility.HtmlEncode(desc)}</div>
                    </div>
                </div>");
            }

            litAchievements.Text = sb.ToString();
        }

        // ============================================================
        // HELPER
        // ============================================================
        protected string GetCatClass(string category)
        {
            switch (category?.ToLower())
            {
                case "stress management":    return "stress";
                case "mindfulness":          return "mindfulness";
                case "anxiety":              return "anxiety";
                case "sleep hygiene":        return "sleep";
                case "resilience":           return "resilience";
                case "self-care":            return "selfcare";
                case "cognitive therapy":    return "cognitive";
                case "trauma recovery":      return "trauma";
                case "emotional regulation": return "regulation";
                case "positive psychology":  return "positive";
                default:                     return "mindfulness";
            }
        }
    }
}
