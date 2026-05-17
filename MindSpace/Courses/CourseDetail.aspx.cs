using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace MindSpace
{
    public partial class CourseDetail : Page
    {
        private int courseID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out courseID) || courseID <= 0)
            {
                Response.Redirect("~/Courses/CourseList.aspx");
                return;
            }

            if (!IsPostBack)
                LoadCourse();
        }

        private void LoadCourse()
        {
            string sql = "SELECT * FROM Courses WHERE CourseID=@id AND IsActive=1";
            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", courseID) });

            if (dt.Rows.Count == 0) { Response.Redirect("~/Courses/CourseList.aspx"); return; }

            DataRow r = dt.Rows[0];
            Page.Title          = r["Title"].ToString();
            litCourseTitle.Text = r["Title"].ToString();
            litCourseDesc.Text  = r["Description"].ToString();
            litLevel.Text       = r["DifficultyLevel"].ToString();
            litDuration.Text    = r["Duration"].ToString();
            litIcon.Text        = GetIcon(r["Category"].ToString());
            litCatBadge.Text    = $"<span class='course-cat-badge cat-{GetCatClass(r["Category"].ToString())}'>{r["Category"]}</span>";

            int ec = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE CourseID=@id",
                new[] { new SqlParameter("@id", courseID) }));
            litEnrolled.Text = ec.ToString();

            int  userID     = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;
            bool isEnrolled = false;

            if (userID > 0)
            {
                int enrolled = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                    "SELECT COUNT(*) FROM Enrollments WHERE UserID=@uid AND CourseID=@cid",
                    new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) }));
                isEnrolled = enrolled > 0;

                if (isEnrolled)
                {
                    pnlEnrollBtn.Visible     = false;
                    pnlEnrolled.Visible      = true;
                    pnlLoginToEnroll.Visible = false;
                    pnlProgress.Visible      = true;

                    int progress = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                        "SELECT Progress FROM Enrollments WHERE UserID=@uid AND CourseID=@cid",
                        new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) }));

                    litProgressPct.Text = progress.ToString();
                    courseProgressBar.Attributes["style"] = $"width:{progress}%;";
                }
                else
                {
                    pnlEnrollBtn.Visible     = true;
                    pnlEnrolled.Visible      = false;
                    pnlLoginToEnroll.Visible = false;
                    pnlProgress.Visible      = false;
                }
            }
            else
            {
                pnlEnrollBtn.Visible     = false;
                pnlEnrolled.Visible      = false;
                pnlLoginToEnroll.Visible = true;
                pnlLoginForQuiz.Visible  = true;
                pnlProgress.Visible      = false;
            }

            LoadResources(userID, isEnrolled);
            LoadQuizzes(isEnrolled, userID > 0);
            LoadCertificate(userID);
        }

        private void LoadResources(int userID, bool isEnrolled)
        {
            string sql = "SELECT * FROM Resources WHERE CourseID=@id ORDER BY OrderNum";
            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", courseID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoResources.Visible = true;
                rptResources.Visible   = false;
            }
            else
            {
                pnlNoResources.Visible  = false;
                rptResources.DataSource = dt;
                rptResources.DataBind();

                if (userID > 0 && isEnrolled)
                {
                    int rowsChanged = DatabaseHelper.ExecuteNonQuery(
                        "UPDATE Enrollments SET Progress=50 WHERE UserID=@uid AND CourseID=@cid AND Progress<50",
                        new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });

                    if (rowsChanged > 0)
                    {
                        try
                        {
                            DatabaseHelper.ExecuteNonQuery(
                                @"INSERT INTO UserProgress (UserID,EventType,ReferenceID,ProgressPct,MinutesSpent)
                                  VALUES (@uid,'resource_view',@cid,50,15)",
                                new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });
                        }
                        catch { }
                    }
                }
            }
        }

        private void LoadQuizzes(bool isEnrolled, bool isLoggedIn)
        {
            string sql = "SELECT QuizID, Title, Description, PassingScore FROM Quizzes WHERE CourseID=@id";
            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", courseID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoQuizzes.Visible    = true;
                rptQuizzes.Visible      = false;
                pnlLoginForQuiz.Visible = false;
            }
            else
            {
                pnlNoQuizzes.Visible    = false;
                pnlLoginForQuiz.Visible = !isLoggedIn;
                rptQuizzes.DataSource   = dt;
                rptQuizzes.DataBind();
            }
        }

        private void LoadCertificate(int userID)
        {
            if (userID <= 0) return;

            // Find the best passing result (>=70%) for any quiz in this course
            string sql = @"SELECT TOP 1
                               u.FullName,
                               qr.Percentage,
                               qr.DateTaken
                           FROM QuizResults qr
                           JOIN Quizzes q  ON qr.QuizID  = q.QuizID
                           JOIN Users   u  ON qr.UserID  = u.UserID
                           WHERE qr.UserID = @uid
                             AND q.CourseID = @cid
                             AND qr.Percentage >= 70
                           ORDER BY qr.Percentage DESC";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql,
                new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });

            if (dt.Rows.Count == 0) return;

            DataRow r = dt.Rows[0];
            pnlCertificate.Visible = true;

            litCertName.Text   = System.Web.HttpUtility.HtmlEncode(r["FullName"].ToString());
            litCertCourse.Text = System.Web.HttpUtility.HtmlEncode(litCourseTitle.Text);
            litCertScore.Text  = $"{Convert.ToDecimal(r["Percentage"]):0}";
            litCertDate.Text   = Convert.ToDateTime(r["DateTaken"]).ToString("dd MMMM yyyy");
            litCertNum.Text    = $"CERT-{userID:D4}-{courseID:D3}";

            // Mark enrollment as completed if not already
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE Enrollments SET Progress=100, IsCompleted=1 WHERE UserID=@uid AND CourseID=@cid AND IsCompleted=0",
                new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });
        }

        protected void btnEnroll_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) { Response.Redirect("~/Login.aspx"); return; }

            int userID = Convert.ToInt32(Session["UserID"]);
            try
            {
                DatabaseHelper.ExecuteNonQuery(
                    "INSERT INTO Enrollments (UserID, CourseID) VALUES (@uid, @cid)",
                    new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });

                pnlMsg.Visible = true;
                litMsg.Text    = "Successfully enrolled! You now have access to all resources and quizzes.";

                try
                {
                    DatabaseHelper.ExecuteNonQuery(
                        @"INSERT INTO UserProgress (UserID,EventType,ReferenceID,ProgressPct,MinutesSpent)
                          VALUES (@uid,'enroll',@cid,0,5)",
                        new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });
                }
                catch { }
            }
            catch { }

            LoadCourse();
        }

        protected string GetCatClass(string cat)
        {
            switch (cat?.ToLower())
            {
                case "stress management": return "stress";
                case "mindfulness":       return "mindfulness";
                case "anxiety":           return "anxiety";
                case "sleep hygiene":     return "sleep";
                case "resilience":        return "resilience";
                default:                  return "mindfulness";
            }
        }

        protected string GetIcon(string cat)
        {
            switch (cat?.ToLower())
            {
                case "stress management": return "🧘";
                case "mindfulness":       return "🌿";
                case "anxiety":           return "💙";
                case "sleep hygiene":     return "🌙";
                case "resilience":        return "💪";
                default:                  return "📚";
            }
        }

        protected string GetResourceIcon(string type)
        {
            switch (type?.ToLower())
            {
                case "video":    return "fas fa-play";
                case "download": return "fas fa-download";
                default:         return "fas fa-file-alt";
            }
        }

        protected string GetResourceBg(string type)
        {
            switch (type?.ToLower())
            {
                case "video":    return "#6C5CE7";
                case "download": return "#00B894";
                default:         return "#74B9FF";
            }
        }

        protected string GetDownloadButton(object urlObj, object titleObj)
        {
            string url   = Convert.ToString(urlObj);
            string title = Convert.ToString(titleObj);
            if (string.IsNullOrEmpty(url))
                return "<span class='btn btn-outline-secondary btn-sm mt-2 disabled'><i class=\"fas fa-download me-1\"></i>Coming Soon</span>";

            string resolved = Page.ResolveUrl("~" + url);
            string encoded  = System.Web.HttpUtility.HtmlAttributeEncode(resolved);
            string download = System.Web.HttpUtility.HtmlAttributeEncode(
                System.IO.Path.GetFileName(url));
            return $"<a href='{encoded}' download='{download}' class='btn btn-outline-primary btn-sm mt-2'>" +
                   "<i class=\"fas fa-download me-1\"></i>Download Resource</a>";
        }
    }
}
