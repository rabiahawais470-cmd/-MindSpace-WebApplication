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

            // Enrollment count
            int ec = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments WHERE CourseID=@id",
                new[] { new SqlParameter("@id", courseID) }));
            litEnrolled.Text = ec.ToString();

            // Check user enrollment
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

                // Advance progress to at least 50% for enrolled users viewing resources
                if (userID > 0 && isEnrolled)
                {
                    DatabaseHelper.ExecuteNonQuery(
                        "UPDATE Enrollments SET Progress=CASE WHEN Progress<50 THEN 50 ELSE Progress END WHERE UserID=@uid AND CourseID=@cid",
                        new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseID) });
                }
            }
        }

        private void LoadQuizzes(bool isEnrolled, bool isLoggedIn)
        {
            if (!isLoggedIn)
            {
                pnlLoginForQuiz.Visible = true;
                rptQuizzes.Visible      = false;
                pnlNoQuizzes.Visible    = false;
                return;
            }

            if (!isEnrolled)
            {
                pnlNoQuizzes.Visible    = false;
                pnlLoginForQuiz.Visible = false;
                rptQuizzes.Visible      = false;
                return;
            }

            string sql = "SELECT QuizID, Title, Description, PassingScore FROM Quizzes WHERE CourseID=@id";
            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", courseID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoQuizzes.Visible = true;
                rptQuizzes.Visible   = false;
            }
            else
            {
                pnlNoQuizzes.Visible    = false;
                rptQuizzes.DataSource   = dt;
                rptQuizzes.DataBind();
            }
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
            }
            catch { /* Already enrolled */ }

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
    }
}
