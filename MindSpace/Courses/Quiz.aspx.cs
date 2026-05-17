using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace MindSpace
{
    public partial class QuizPage : Page
    {
        private int quizID;
        private DataTable questionsTable;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["quizID"], out quizID) || quizID <= 0)
            {
                Response.Redirect("~/Courses/CourseList.aspx");
                return;
            }

            if (!IsPostBack)
                LoadQuiz();
        }

        private void LoadQuiz()
        {
            // Load quiz info
            string sql = "SELECT QuizID, Title, Description, PassingScore FROM Quizzes WHERE QuizID=@id";
            DataTable quiz = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", quizID) });

            if (quiz.Rows.Count == 0) { Response.Redirect("~/Courses/CourseList.aspx"); return; }

            DataRow q = quiz.Rows[0];
            Page.Title          = q["Title"].ToString() + " - Quiz";
            litQuizTitle.Text   = q["Title"].ToString();
            litQuizDesc.Text    = q["Description"].ToString();
            litPassingScore.Text = q["PassingScore"].ToString();
            hdnQuizID.Value     = quizID.ToString();

            // Load questions
            string qSql = @"
                SELECT q.QuestionID, q.QuestionText, q.QuestionType, q.CorrectAnswer, q.OrderNum
                FROM   Questions q
                WHERE  q.QuizID = @qid
                ORDER  BY q.OrderNum";

            questionsTable = DatabaseHelper.ExecuteQuery(qSql, new[] { new SqlParameter("@qid", quizID) });
            litQuestionCount.Text = questionsTable.Rows.Count.ToString();
            hdnTotalQuestions.Value = questionsTable.Rows.Count.ToString();

            rptQuestions.DataSource = questionsTable;
            rptQuestions.DataBind();
        }

        // Render radio buttons for multiple-choice questions
        protected string RenderOptions(int questionID)
        {
            string sql = @"SELECT OptionLabel, OptionText FROM QuestionOptions WHERE QuestionID=@qid ORDER BY OptionLabel";
            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@qid", questionID) });

            var sb = new StringBuilder();
            foreach (DataRow row in dt.Rows)
            {
                string label = row["OptionLabel"].ToString();
                string text  = row["OptionText"].ToString();
                sb.AppendFormat(
                    "<label class='quiz-option'>" +
                    "<input type='radio' name='q{0}' value='{1}' />" +
                    "<strong class='me-2'>{1}.</strong> {2}" +
                    "</label>",
                    questionID, label, text);
            }
            return sb.ToString();
        }

        // Render True/False radio buttons
        protected string RenderTrueFalse(int questionID)
        {
            return string.Format(
                "<label class='quiz-option'><input type='radio' name='q{0}' value='True' /> True</label>" +
                "<label class='quiz-option'><input type='radio' name='q{0}' value='False' /> False</label>",
                questionID);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            quizID     = Convert.ToInt32(hdnQuizID.Value);
            int total  = Convert.ToInt32(hdnTotalQuestions.Value);

            // Load correct answers
            string sql = @"SELECT QuestionID, CorrectAnswer FROM Questions WHERE QuizID=@qid ORDER BY OrderNum";
            DataTable questions = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@qid", quizID) });

            int score = 0;
            foreach (DataRow row in questions.Rows)
            {
                int    qID     = Convert.ToInt32(row["QuestionID"]);
                string correct = row["CorrectAnswer"].ToString();
                string userAns = Request.Form["q" + qID] ?? "";

                if (userAns.Trim().Equals(correct.Trim(), StringComparison.OrdinalIgnoreCase))
                    score++;
            }

            decimal percentage = total > 0 ? Math.Round((decimal)score / total * 100, 1) : 0;

            // Get passing score
            int passingScore = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT PassingScore FROM Quizzes WHERE QuizID=@id",
                new[] { new SqlParameter("@id", quizID) }));

            // Generate feedback
            string feedback;
            if (percentage >= passingScore)
                feedback = $"Excellent work! You passed with {percentage}%. Keep up your mental wellness journey!";
            else if (percentage >= 50)
                feedback = $"Good effort! You scored {percentage}%. Review the course materials and try again.";
            else
                feedback = $"You scored {percentage}%. Don't be discouraged - revisit the course content and try again.";

            // Save result
            string insertSql = @"
                INSERT INTO QuizResults (UserID, QuizID, Score, TotalQuestions, Percentage, Feedback)
                VALUES (@uid, @qid, @score, @total, @pct, @feedback);
                SELECT SCOPE_IDENTITY();";

            object resultID = DatabaseHelper.ExecuteScalar(insertSql, new[] {
                new SqlParameter("@uid",      userID),
                new SqlParameter("@qid",      quizID),
                new SqlParameter("@score",    score),
                new SqlParameter("@total",    total),
                new SqlParameter("@pct",      percentage),
                new SqlParameter("@feedback", feedback)
            });

            // Update enrollment progress and log UserProgress event
            object courseIDObj = DatabaseHelper.ExecuteScalar(
                "SELECT CourseID FROM Quizzes WHERE QuizID=@id",
                new[] { new SqlParameter("@id", quizID) });
            int courseIDForProgress = courseIDObj != null ? Convert.ToInt32(courseIDObj) : 0;

            if (percentage >= passingScore && courseIDForProgress > 0)
            {
                DatabaseHelper.ExecuteNonQuery(
                    "UPDATE Enrollments SET Progress=100,IsCompleted=1 WHERE UserID=@uid AND CourseID=@cid",
                    new[] { new SqlParameter("@uid", userID), new SqlParameter("@cid", courseIDForProgress) });
            }

            // Log to UserProgress table
            string evtType = percentage >= passingScore ? "quiz_pass" : "quiz_fail";
            DatabaseHelper.ExecuteNonQuery(
                @"INSERT INTO UserProgress (UserID,EventType,ReferenceID,ProgressPct,ScoreValue,MinutesSpent)
                  VALUES (@uid,@evt,@rid,@pct,@score,10)",
                new[] {
                    new SqlParameter("@uid",   userID),
                    new SqlParameter("@evt",   evtType),
                    new SqlParameter("@rid",   quizID),
                    new SqlParameter("@pct",   (int)percentage),
                    new SqlParameter("@score", percentage)
                });

            Response.Redirect("~/Courses/QuizResults.aspx?resultID=" + resultID);
        }
    }
}
