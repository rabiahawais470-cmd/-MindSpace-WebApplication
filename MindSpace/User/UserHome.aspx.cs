using System;
using System.Data;
using System.Data.SqlClient;
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
                litWelcome.Text = Session["FullName"]?.ToString() ?? "Learner";
                int userID = Convert.ToInt32(Session["UserID"]);
                LoadStats(userID);
                LoadEnrolledCourses(userID);
                LoadQuizResults(userID);
            }
        }

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
        }

        private void LoadEnrolledCourses(int userID)
        {
            string sql = @"
                SELECT e.CourseID, c.Title, c.Category, e.Progress, e.IsCompleted
                FROM   Enrollments e
                JOIN   Courses c ON e.CourseID = c.CourseID
                WHERE  e.UserID = @uid
                ORDER  BY e.EnrollDate DESC";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@uid", userID) });

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

        private void LoadQuizResults(int userID)
        {
            string sql = @"
                SELECT TOP 5 qr.Score, qr.TotalQuestions, qr.Percentage, qr.DateTaken,
                       q.Title AS QuizTitle
                FROM   QuizResults qr
                JOIN   Quizzes q ON qr.QuizID = q.QuizID
                WHERE  qr.UserID = @uid
                ORDER  BY qr.DateTaken DESC";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 0)
            {
                pnlNoQuizzes.Visible      = true;
                rptQuizResults.Visible    = false;
            }
            else
            {
                pnlNoQuizzes.Visible      = false;
                rptQuizResults.DataSource = dt;
                rptQuizResults.DataBind();
            }
        }

        protected string GetCatClass(string category)
        {
            switch (category?.ToLower())
            {
                case "stress management": return "stress";
                case "mindfulness":       return "mindfulness";
                case "anxiety":           return "anxiety";
                case "sleep hygiene":     return "sleep";
                case "resilience":        return "resilience";
                default:                  return "mindfulness";
            }
        }
    }
}
