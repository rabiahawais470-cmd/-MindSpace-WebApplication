using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace
{
    public partial class CourseList : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCourses();
        }

        private void LoadCourses(string search = "", string category = "", string level = "")
        {
            int userID = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;

            string sql = @"
                SELECT c.CourseID, c.Title, c.Description, c.Category, c.DifficultyLevel, c.Duration,
                       (SELECT COUNT(*) FROM Enrollments WHERE CourseID=c.CourseID) AS EnrollmentCount,
                       CASE WHEN EXISTS(SELECT 1 FROM Enrollments WHERE CourseID=c.CourseID AND UserID=@uid)
                            THEN 1 ELSE 0 END AS IsEnrolled,
                       CASE WHEN EXISTS(SELECT 1 FROM Bookmarks   WHERE CourseID=c.CourseID AND UserID=@uid)
                            THEN 1 ELSE 0 END AS IsBookmarked
                FROM   Courses c
                WHERE  c.IsActive = 1
                  AND  (@search='' OR c.Title LIKE @searchLike OR c.Description LIKE @searchLike)
                  AND  (@cat='' OR c.Category=@cat)
                  AND  (@level='' OR c.DifficultyLevel=@level)
                ORDER  BY c.DateCreated DESC";

            SqlParameter[] prms = {
                new SqlParameter("@uid",        userID),
                new SqlParameter("@search",     search),
                new SqlParameter("@searchLike", "%" + search + "%"),
                new SqlParameter("@cat",         category),
                new SqlParameter("@level",       level)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);
            litCount.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count == 0)
            {
                rptCourses.Visible = false;
                pnlEmpty.Visible   = true;
            }
            else
            {
                pnlEmpty.Visible   = false;
                rptCourses.Visible = true;
                rptCourses.DataSource = dt;
                rptCourses.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
            => LoadCourses(txtSearch.Text.Trim(), ddlCategory.SelectedValue, ddlLevel.SelectedValue);

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text             = "";
            ddlCategory.SelectedValue  = "";
            ddlLevel.SelectedValue     = "";
            LoadCourses();
        }

        protected string GetCatClass(string cat)
        {
            switch (cat?.ToLower())
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

        protected string GetCourseIcon(string cat)
        {
            switch (cat?.ToLower())
            {
                case "stress management": return "🧘";
                case "mindfulness":       return "🌿";
                case "anxiety":           return "💙";
                case "sleep hygiene":     return "🌙";
                case "resilience":        return "💪";
                case "self-care":         return "🌸";
                default:                  return "📚";
            }
        }
    }
}
