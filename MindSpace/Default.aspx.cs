using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace
{
    public partial class DefaultPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    pnlCTAGuest.Visible = false;
                    pnlCTAUser.Visible  = true;
                }
                LoadFeaturedCourses();
            }
        }

        private void LoadFeaturedCourses()
        {
            string sql = @"
                SELECT TOP 3 c.CourseID, c.Title, c.Description, c.Category, c.DifficultyLevel, c.Duration,
                       (SELECT COUNT(*) FROM Enrollments WHERE CourseID = c.CourseID) AS EnrollmentCount
                FROM Courses c
                WHERE c.IsActive = 1
                ORDER BY c.DateCreated DESC";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql);
            rptCourses.DataSource = dt;
            rptCourses.DataBind();
        }

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

        protected string GetCourseIcon(string category)
        {
            switch (category?.ToLower())
            {
                case "stress management": return "🧘";
                case "mindfulness":       return "🌿";
                case "anxiety":           return "💙";
                case "sleep hygiene":     return "🌙";
                case "resilience":        return "💪";
                default:                  return "📚";
            }
        }
    }
}
