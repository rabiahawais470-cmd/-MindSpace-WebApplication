using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

namespace MindSpace
{
    public partial class ProgressTracking : Page
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
                LoadStats(userID);
                LoadCourseProgress(userID);
                LoadChartData(userID);
                LoadActivityTimeline(userID);
                LoadQuizPerformance(userID);
                LoadClassComparison(userID);
                LoadAchievements(userID);
                LoadRecommendedCourses(userID);
            }
        }

        // ============================================================
        // STATS ROW
        // ============================================================
        private void LoadStats(int userID)
        {
            // Overall progress = average progress across all enrolled courses
            object avgPct = DatabaseHelper.ExecuteScalar(
                "SELECT ISNULL(AVG(CAST(Progress AS FLOAT)),0) FROM Enrollments WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) });
            litOverallPct.Text = Math.Round(Convert.ToDouble(avgPct)).ToString();

            // Quizzes taken
            litQuizzesDone.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizResults WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }).ToString();

            // Forum contributions (posts + comments)
            object forum = DatabaseHelper.ExecuteScalar(
                @"SELECT (SELECT COUNT(*) FROM ForumPosts    WHERE UserID=@uid AND IsActive=1)
                       + (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", userID) });
            litForumCount.Text = forum?.ToString() ?? "0";

            // Estimated hours on platform
            int enrollments   = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }));
            int quizzesTaken  = Convert.ToInt32(litQuizzesDone.Text);
            int forumPosts    = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM ForumPosts WHERE UserID=@uid AND IsActive=1",
                new[] { new SqlParameter("@uid", userID) }));
            int forumComments = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1",
                new[] { new SqlParameter("@uid", userID) }));
            int extraMins = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT ISNULL(SUM(MinutesSpent),0) FROM UserProgress WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }));

            // Estimate: enrollment browsing=10min, per resource set=15min, quiz=10min, post=5min, reply=3min
            int totalMinutes = enrollments * 10
                             + enrollments * 15   // assumed resource viewing per enrolled course
                             + quizzesTaken  * 10
                             + forumPosts    * 5
                             + forumComments * 3
                             + extraMins;
            litHours.Text = Math.Round(totalMinutes / 60.0, 1).ToString();
            litSnapHours.Text = litHours.Text;
        }

        // ============================================================
        // COURSE PROGRESS REPEATER
        // ============================================================
        private void LoadCourseProgress(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT e.CourseID, e.UserID, c.Title, c.Category,
                       e.Progress, e.IsCompleted, e.EnrollDate,
                       (SELECT COUNT(*) FROM Quizzes WHERE CourseID=c.CourseID) AS TotalQuizzes,
                       (SELECT COUNT(*)
                        FROM   QuizResults qr
                        JOIN   Quizzes q ON qr.QuizID=q.QuizID
                        WHERE  q.CourseID=c.CourseID
                          AND  qr.UserID=e.UserID
                          AND  qr.Percentage >= q.PassingScore) AS QuizzesPassed
                FROM   Enrollments e
                JOIN   Courses     c ON e.CourseID=c.CourseID
                WHERE  e.UserID=@uid
                ORDER  BY e.IsCompleted ASC, e.EnrollDate DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoCourses.Visible       = true;
                rptCourseProgress.Visible  = false;
            }
            else
            {
                pnlNoCourses.Visible          = false;
                rptCourseProgress.DataSource  = dt;
                rptCourseProgress.DataBind();
            }
        }

        // ============================================================
        // CHART DATA (JSON for Chart.js)
        // ============================================================
        private void LoadChartData(int userID)
        {
            // Latest score per quiz for this user, ordered by quiz ID
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT qu.Title AS QuizTitle,
                       MAX(qr.Percentage)  AS BestScore,
                       MIN(qr.DateTaken)   AS FirstTaken
                FROM   QuizResults qr
                JOIN   Quizzes qu ON qr.QuizID=qu.QuizID
                WHERE  qr.UserID=@uid
                GROUP  BY qr.QuizID, qu.Title
                ORDER  BY MIN(qr.DateTaken)",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoChart.Visible = true;
                pnlChart.Visible   = false;
                return;
            }

            pnlNoChart.Visible = false;
            pnlChart.Visible   = true;

            // Build JSON manually (no external library needed)
            var labels = new StringBuilder();
            var scores = new StringBuilder();
            bool first = true;
            foreach (DataRow row in dt.Rows)
            {
                if (!first) { labels.Append(","); scores.Append(","); }
                // Escape the quiz title for JSON
                string title = row["QuizTitle"].ToString()
                    .Replace("\\", "\\\\").Replace("\"", "\\\"");
                labels.Append("\"").Append(title).Append("\"");
                scores.Append(Math.Round(Convert.ToDecimal(row["BestScore"]), 1).ToString(
                    System.Globalization.CultureInfo.InvariantCulture));
                first = false;
            }

            hdnChartData.Value = "{\"labels\":[" + labels + "],\"scores\":[" + scores + "]}";
        }

        // ============================================================
        // ACTIVITY TIMELINE
        // ============================================================
        private void LoadActivityTimeline(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT TOP 12 Label, Detail, RecordedAt, IconClass, Icon
                FROM (
                    -- Enrollments
                    SELECT
                        'Enrolled in ' + c.Title            AS Label,
                        c.Category                          AS Detail,
                        e.EnrollDate                        AS RecordedAt,
                        'timeline-info'                     AS IconClass,
                        'fa-book-open'                      AS Icon
                    FROM  Enrollments e
                    JOIN  Courses c ON e.CourseID=c.CourseID
                    WHERE e.UserID=@uid

                    UNION ALL

                    -- Quiz results
                    SELECT
                        CASE WHEN qr.Percentage >= qu.PassingScore
                             THEN 'Passed: ' ELSE 'Attempted: ' END + qu.Title AS Label,
                        CAST(CAST(qr.Percentage AS INT) AS NVARCHAR)
                            + '% (' + CAST(qr.Score AS NVARCHAR)
                            + '/' + CAST(qr.TotalQuestions AS NVARCHAR) + ')' AS Detail,
                        qr.DateTaken                        AS RecordedAt,
                        CASE WHEN qr.Percentage >= qu.PassingScore
                             THEN 'timeline-success' ELSE 'timeline-danger' END AS IconClass,
                        CASE WHEN qr.Percentage >= qu.PassingScore
                             THEN 'fa-trophy' ELSE 'fa-redo' END AS Icon
                    FROM  QuizResults qr
                    JOIN  Quizzes qu ON qr.QuizID=qu.QuizID
                    WHERE qr.UserID=@uid

                    UNION ALL

                    -- Forum posts
                    SELECT
                        'Posted: '  + LEFT(fp.Title,60)     AS Label,
                        'New discussion thread'              AS Detail,
                        fp.DatePosted                       AS RecordedAt,
                        'timeline-purple'                   AS IconClass,
                        'fa-pen'                            AS Icon
                    FROM  ForumPosts fp
                    WHERE fp.UserID=@uid AND fp.IsActive=1

                    UNION ALL

                    -- Forum replies
                    SELECT
                        'Replied in: ' + LEFT(p.Title,60)   AS Label,
                        'Forum discussion reply'             AS Detail,
                        fc.DatePosted                       AS RecordedAt,
                        'timeline-purple'                   AS IconClass,
                        'fa-reply'                          AS Icon
                    FROM  ForumComments fc
                    JOIN  ForumPosts p ON fc.PostID=p.PostID
                    WHERE fc.UserID=@uid AND fc.IsActive=1

                    UNION ALL

                    -- Extra UserProgress events not already covered above
                    SELECT
                        CASE up.EventType
                            WHEN 'resource_view'
                                THEN 'Viewed resources: ' + ISNULL(c2.Title,'course content')
                            WHEN 'course_complete'
                                THEN 'Completed course: ' + ISNULL(c2.Title,'')
                            ELSE up.EventType
                        END AS Label,
                        CASE up.EventType
                            WHEN 'resource_view'   THEN 'Content viewed'
                            WHEN 'course_complete' THEN 'Course finished!'
                            ELSE ''
                        END AS Detail,
                        up.RecordedAt                       AS RecordedAt,
                        CASE up.EventType
                            WHEN 'resource_view'   THEN 'timeline-info'
                            WHEN 'course_complete' THEN 'timeline-success'
                            ELSE 'timeline-info'
                        END AS IconClass,
                        CASE up.EventType
                            WHEN 'resource_view'   THEN 'fa-eye'
                            WHEN 'course_complete' THEN 'fa-graduation-cap'
                            ELSE 'fa-circle'
                        END AS Icon
                    FROM  UserProgress up
                    LEFT  JOIN Courses c2 ON up.ReferenceID=c2.CourseID
                    WHERE up.UserID=@uid
                      AND up.EventType NOT IN ('enroll','quiz_pass','quiz_fail','forum_post','forum_reply')

                ) AS Activity
                ORDER BY RecordedAt DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoActivity.Visible = true;
                rptActivity.Visible   = false;
            }
            else
            {
                pnlNoActivity.Visible    = false;
                rptActivity.DataSource   = dt;
                rptActivity.DataBind();
            }
        }

        // ============================================================
        // QUIZ PERFORMANCE CARD
        // ============================================================
        private void LoadQuizPerformance(int userID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT COUNT(*)                              AS TotalAttempts,
                       ISNULL(AVG(Percentage),0)            AS AvgScore,
                       ISNULL(MAX(Percentage),0)            AS BestScore,
                       SUM(CASE WHEN qr.Percentage >= qu.PassingScore THEN 1 ELSE 0 END) AS Passed
                FROM   QuizResults qr
                JOIN   Quizzes qu ON qr.QuizID=qu.QuizID
                WHERE  qr.UserID=@uid",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0) return;
            DataRow r = dt.Rows[0];

            int   total  = (r["TotalAttempts"] == DBNull.Value) ? 0 : Convert.ToInt32(r["TotalAttempts"]);
            decimal avg  = (r["AvgScore"] == DBNull.Value) ? 0 : Convert.ToDecimal(r["AvgScore"]);
            decimal best = (r["BestScore"] == DBNull.Value) ? 0 : Convert.ToDecimal(r["BestScore"]);
            int   passed = (r["Passed"] == DBNull.Value) ? 0 : Convert.ToInt32(r["Passed"]);

            if (total == 0)
            {
                litAvgScore.Text      = "—";
                litBestScore.Text     = "—";
                litQuizzesPassed.Text = "0";
                litPassRate.Text      = "—";
            }
            else
            {
                litAvgScore.Text      = Math.Round(avg, 0) + "%";
                litBestScore.Text     = Math.Round(best, 0) + "%";
                litQuizzesPassed.Text = passed.ToString();
                litPassRate.Text      = Math.Round((decimal)passed / total * 100, 0) + "%";
            }

            // Sync snapshot panel
            litSnapAvgScore.Text      = litAvgScore.Text;
            litSnapPassRate.Text      = litPassRate.Text;
            litSnapQuizzesPassed.Text = litQuizzesPassed.Text;
        }

        // ============================================================
        // CLASS COMPARISON
        // ============================================================
        private void LoadClassComparison(int userID)
        {
            // User's avg course progress
            double userProgress = Convert.ToDouble(DatabaseHelper.ExecuteScalar(
                "SELECT ISNULL(AVG(CAST(Progress AS FLOAT)),0) FROM Enrollments WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }));

            // Global avg course progress (all users)
            double classProgress = Convert.ToDouble(DatabaseHelper.ExecuteScalar(
                "SELECT ISNULL(AVG(CAST(Progress AS FLOAT)),0) FROM Enrollments", null));

            // User's avg quiz score
            double userQuizScore = Convert.ToDouble(DatabaseHelper.ExecuteScalar(
                "SELECT ISNULL(AVG(CAST(Percentage AS FLOAT)),0) FROM QuizResults WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", userID) }));

            // Global avg quiz score
            double classQuizScore = Convert.ToDouble(DatabaseHelper.ExecuteScalar(
                "SELECT ISNULL(AVG(CAST(Percentage AS FLOAT)),0) FROM QuizResults", null));

            // User's forum count
            int userForum = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                @"SELECT (SELECT COUNT(*) FROM ForumPosts WHERE UserID=@uid AND IsActive=1)
                       + (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", userID) }));

            // Average forum count per user (users who have posted)
            double classForum = Convert.ToDouble(DatabaseHelper.ExecuteScalar(@"
                SELECT ISNULL(AVG(CAST(cnt AS FLOAT)),0) FROM (
                    SELECT UserID, COUNT(*) AS cnt FROM (
                        SELECT UserID FROM ForumPosts WHERE IsActive=1
                        UNION ALL
                        SELECT UserID FROM ForumComments WHERE IsActive=1
                    ) AS x GROUP BY UserID
                ) AS y", null));

            int uP  = (int)Math.Round(userProgress);
            int cP  = (int)Math.Round(classProgress);
            int uQ  = (int)Math.Round(userQuizScore);
            int cQ  = (int)Math.Round(classQuizScore);

            string progressStatus = uP >= cP
                ? $"<span class='badge bg-success ms-1'><i class='fas fa-arrow-up me-1'></i>Above avg</span>"
                : $"<span class='badge bg-light text-muted border ms-1'>Below avg</span>";
            string quizStatus = uQ >= cQ
                ? $"<span class='badge bg-success ms-1'><i class='fas fa-arrow-up me-1'></i>Above avg</span>"
                : $"<span class='badge bg-light text-muted border ms-1'>Below avg</span>";

            var sb = new StringBuilder();

            // Course Progress comparison
            sb.Append(@"<div class='comparison-group mb-3'>
                <div class='d-flex justify-content-between align-items-center small mb-1'>
                    <span class='text-muted fw-semibold'>Course Progress</span>
                    " + progressStatus + @"
                </div>
                <div class='mb-1'>
                    <div class='d-flex justify-content-between' style='font-size:0.75rem;'>
                        <span>You <strong>" + uP + @"%</strong></span>
                        <span>Class avg <strong>" + cP + @"%</strong></span>
                    </div>
                    <div class='comparison-track mt-1'>
                        <div class='comparison-bar-you'  style='width:" + Math.Min(uP, 100) + @"%;'></div>
                    </div>
                    <div class='comparison-track mt-1' style='background:#f0effe;'>
                        <div class='comparison-bar-class' style='width:" + Math.Min(cP, 100) + @"%;'></div>
                    </div>
                </div>
            </div>");

            // Quiz Score comparison
            sb.Append(@"<div class='comparison-group mb-3'>
                <div class='d-flex justify-content-between align-items-center small mb-1'>
                    <span class='text-muted fw-semibold'>Quiz Score</span>
                    " + quizStatus + @"
                </div>
                <div class='mb-1'>
                    <div class='d-flex justify-content-between' style='font-size:0.75rem;'>
                        <span>You <strong>" + (uQ > 0 ? uQ + "%" : "—") + @"</strong></span>
                        <span>Class avg <strong>" + (cQ > 0 ? cQ + "%" : "—") + @"</strong></span>
                    </div>
                    <div class='comparison-track mt-1'>
                        <div class='comparison-bar-you'  style='width:" + Math.Min(uQ, 100) + @"%;'></div>
                    </div>
                    <div class='comparison-track mt-1' style='background:#f0effe;'>
                        <div class='comparison-bar-class' style='width:" + Math.Min(cQ, 100) + @"%;'></div>
                    </div>
                </div>
            </div>");

            // Forum participation
            string forumCmp = userForum >= (int)Math.Round(classForum)
                ? "<span class='text-success fw-bold'>" + userForum + " contributions</span> <small class='text-success'>(above avg)</small>"
                : "<span class='fw-bold'>" + userForum + " contributions</span> <small class='text-muted'>(avg: " + (int)Math.Round(classForum) + ")</small>";

            sb.Append(@"<div class='comparison-group'>
                <div class='small text-muted fw-semibold mb-1'>Forum Participation</div>
                <div class='small'>" + forumCmp + @"</div>
            </div>");

            // Legend
            sb.Append(@"<div class='d-flex gap-3 mt-3 small text-muted'>
                <span><span class='legend-dot you-dot'></span>You</span>
                <span><span class='legend-dot class-dot'></span>Class average</span>
            </div>");

            litComparison.Text = sb.ToString();
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
            int quizzesPassed = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                @"SELECT COUNT(*) FROM QuizResults qr JOIN Quizzes q ON qr.QuizID=q.QuizID
                  WHERE qr.UserID=@uid AND qr.Percentage>=q.PassingScore",
                new[] { new SqlParameter("@uid", userID) }));
            int forumPosts   = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                @"SELECT (SELECT COUNT(*) FROM ForumPosts    WHERE UserID=@uid AND IsActive=1)
                       + (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", userID) }));
            int highScores   = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizResults WHERE UserID=@uid AND Percentage>=70",
                new[] { new SqlParameter("@uid", userID) }));

            var badges = new List<(string IconClass, string Name, string Desc, bool Unlocked)>
            {
                ("fa-leaf", "First Steps",      "Enrolled in your first course",        enrolled     >= 1),
                ("fa-graduation-cap", "Graduate",         "Completed your first course",          completed    >= 1),
                ("fa-book", "Avid Learner",     "Enrolled in 3 or more courses",        enrolled     >= 3),
                ("fa-trophy", "Course Champion",  "Completed 3 or more courses",          completed    >= 3),
                ("fa-pen",  "Quiz Taker",       "Attempted your first quiz",            quizzesTaken >= 1),
                ("fa-check", "Quiz Passer",      "Passed your first quiz",              quizzesPassed >= 1),
                ("fa-star", "High Achiever",   "Scored 70%+ on 3 or more quizzes",    highScores   >= 3),
                ("fa-comments", "Community Voice",  "Made your first forum post",           forumPosts   >= 1),
                ("fa-handshake", "Forum Regular",    "Made 5+ forum contributions",          forumPosts   >= 5),
                ("fa-fire", "Dedicated Learner","Completed a quiz after 3 enrollments", enrolled>=3 && quizzesTaken>=1),
            };

            int unlockCount = 0;
            var sb = new StringBuilder();
            foreach (var (iconClass, name, desc, unlocked) in badges)
            {
                if (unlocked) unlockCount++;
                string cls = unlocked ? "unlocked" : "locked";
                sb.Append($@"<div class=""achievement-badge {cls}"">
                    <span class=""badge-icon""><i class=""fa-solid {iconClass}""></i></span>
                    <div class=""badge-info"">
                        <div class=""badge-name"">{HttpUtility.HtmlEncode(name)}</div>
                        <div class=""badge-desc"">{HttpUtility.HtmlEncode(desc)}</div>
                    </div>
                    <span class=""badge-status"">{(unlocked ? "Unlocked" : "Locked")}</span>
                </div>");
            }

            int total = badges.Count;
            int pct = total == 0 ? 0 : (int)Math.Round((unlockCount / (double)total) * 100);
            string progress = $@"<div class=""achievement-progress"">
                <div class=""achievement-progress-head"">
                    <span class=""achievement-progress-title"">Badges earned</span>
                    <span class=""achievement-progress-count"">{unlockCount}/{total}</span>
                </div>
                <div class=""achievement-progress-bar""><span style=""width:{pct}%""></span></div>
            </div>";

            litAchievements.Text = progress + $@"<div class=""achievement-grid"">{sb}</div>";
        }

        // ============================================================
        // RECOMMENDED COURSES (carousel)
        // ============================================================
        private void LoadRecommendedCourses(int userID)
        {
            // Show courses the user is NOT enrolled in, with module count
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT TOP 12
                    c.CourseID,
                    c.Title,
                    c.Category,
                    c.DifficultyLevel,
                    c.Duration,
                    (SELECT COUNT(*) FROM Quizzes q WHERE q.CourseID = c.CourseID) AS ModuleCount
                FROM   Courses c
                WHERE  c.IsActive = 1
                  AND  c.CourseID NOT IN (
                      SELECT e.CourseID FROM Enrollments e WHERE e.UserID = @uid
                  )
                ORDER  BY c.DateCreated DESC",
                new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoRecommendations.Visible = true;
                pnlRecommendations.Visible   = false;
            }
            else
            {
                pnlNoRecommendations.Visible = false;
                pnlRecommendations.Visible   = true;
                rptRecommended.DataSource    = dt;
                rptRecommended.DataBind();
            }
        }

        // ============================================================
        // HELPERS
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

        protected string GetStatusBadge(object isCompleted, object progress)
        {
            if (Convert.ToBoolean(isCompleted))
                return "<span class='badge bg-success'><i class='fas fa-check me-1'></i>Completed</span>";
            int pct = Convert.ToInt32(progress);
            return pct == 0
                ? "<span class='badge bg-light text-muted border'>Not started</span>"
                : $"<span class='badge bg-light text-dark border'>{pct}% done</span>";
        }
    }
}
