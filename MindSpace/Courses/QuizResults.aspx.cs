using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace MindSpace
{
    public partial class QuizResults : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (!int.TryParse(Request.QueryString["resultID"], out int resultID) || resultID <= 0)
                {
                    Response.Redirect("~/User/UserHome.aspx");
                    return;
                }
                LoadResults(resultID);
            }
        }

        private void LoadResults(int resultID)
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            string sql = @"
                SELECT qr.Score, qr.TotalQuestions, qr.Percentage, qr.Feedback, qr.QuizID,
                       q.Title AS QuizTitle, q.PassingScore,
                       (SELECT TOP 1 CourseID FROM Quizzes WHERE QuizID=q.QuizID) AS CourseID
                FROM   QuizResults qr
                JOIN   Quizzes q ON qr.QuizID = q.QuizID
                WHERE  qr.ResultID = @rid AND qr.UserID = @uid";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] {
                new SqlParameter("@rid", resultID),
                new SqlParameter("@uid", userID)
            });

            if (dt.Rows.Count == 0) { Response.Redirect("~/User/UserHome.aspx"); return; }

            DataRow r       = dt.Rows[0];
            int     score   = Convert.ToInt32(r["Score"]);
            int     total   = Convert.ToInt32(r["TotalQuestions"]);
            decimal pct     = Convert.ToDecimal(r["Percentage"]);
            int     passing = Convert.ToInt32(r["PassingScore"]);
            int     quizIDv = Convert.ToInt32(r["QuizID"]);
            int     courseID= Convert.ToInt32(r["CourseID"]);
            bool    passed  = pct >= passing;

            // Set page content
            litQuizTitle.Text   = r["QuizTitle"].ToString();
            litPercentage.Text  = Math.Round(pct, 0).ToString();
            litScore.Text       = $"{score} / {total}";
            litCorrect.Text     = score.ToString();
            litIncorrect.Text   = (total - score).ToString();
            litTotal.Text       = total.ToString();
            litFeedback.Text    = r["Feedback"].ToString();
            litResultLabel.Text = passed ? "Congratulations! 🎉" : "Keep Practising! 💪";

            // Score circle CSS class
            ((HtmlGenericControl)divScoreCircle).Attributes["class"] =
                "score-circle " + (passed ? "pass" : "fail") + " mx-auto mb-3";

            // Pass/Fail badge
            lblPassFailBadge.Text    = (passed ? "<i class='fas fa-trophy me-1'></i>PASSED" : "<i class='fas fa-times-circle me-1'></i>NOT PASSED");
            lblPassFailBadge.CssClass = "badge fs-6 px-3 py-2 " + (passed ? "bg-success" : "bg-danger");

            // Navigation links
            hlRetake.NavigateUrl  = $"~/Courses/Quiz.aspx?quizID={quizIDv}";
            hlCourse.NavigateUrl  = $"~/Courses/CourseDetail.aspx?id={courseID}";

            // Question review
            LoadQuestionReview(quizIDv);
        }

        private void LoadQuestionReview(int quizID)
        {
            string sql = @"
                SELECT QuestionText, CorrectAnswer, QuestionType
                FROM   Questions
                WHERE  QuizID = @qid
                ORDER  BY OrderNum";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@qid", quizID) });

            if (dt.Rows.Count > 0)
            {
                pnlReview.Visible    = true;
                rptReview.DataSource = dt;
                rptReview.DataBind();
            }
            else
            {
                pnlReview.Visible = false;
            }
        }
    }
}
