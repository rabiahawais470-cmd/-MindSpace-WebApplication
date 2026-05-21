using System;
using System.Data;
using System.Web.UI;

namespace MindSpace
{
    public partial class AdminHome : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RequireAdmin();
            if (!IsPostBack)
            {
                litAdminName.Text = Session["FullName"]?.ToString() ?? "Administrator";
                LoadStats();
                LoadRecentUsers();
                LoadCourses();
            }
        }

        private void RequireAdmin()
        {
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "admin")
                Response.Redirect("~/Login.aspx");
        }

        private void LoadStats()
        {
            litTotalUsers.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Users WHERE Role='learner' AND IsActive=1").ToString();

            litTotalCourses.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Courses WHERE IsActive=1").ToString();

            litTotalEnrollments.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Enrollments").ToString();

            litTotalPosts.Text = DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM ForumPosts WHERE IsActive=1").ToString();
        }

        private void LoadRecentUsers()
        {
            string sql = @"
                SELECT TOP 6 FullName, Username, Role, DateRegistered
                FROM   Users
                ORDER  BY DateRegistered DESC";

            gvRecentUsers.DataSource = DatabaseHelper.ExecuteQuery(sql);
            gvRecentUsers.DataBind();
        }

        private void LoadCourses()
        {
            string sql = @"
                SELECT TOP 6 c.CourseID, c.Title, c.Category, c.IsActive,
                       (SELECT COUNT(*) FROM Enrollments WHERE CourseID=c.CourseID) AS EnrollmentCount
                FROM   Courses c
                ORDER  BY c.DateCreated DESC";

            gvCourses.DataSource = DatabaseHelper.ExecuteQuery(sql);
            gvCourses.DataBind();
        }
    }
}
