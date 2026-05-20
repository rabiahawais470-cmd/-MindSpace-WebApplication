using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace.User
{
    public partial class Bookmarks : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (!IsPostBack)
                LoadBookmarks();
        }

        private void LoadBookmarks()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT c.CourseID, c.Title, c.Description, c.Category, c.DifficultyLevel, c.Duration,
                       b.DateBookmarked
                FROM   Bookmarks b
                JOIN   Courses   c ON b.CourseID = c.CourseID
                WHERE  b.UserID = @uid AND c.IsActive = 1
                ORDER  BY b.DateBookmarked DESC",
                new[] { new SqlParameter("@uid", userID) });

            litCount.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count == 0)
            {
                pnlEmpty.Visible = true;
                rptBookmarks.Visible = false;
            }
            else
            {
                pnlEmpty.Visible = false;
                rptBookmarks.DataSource = dt;
                rptBookmarks.DataBind();
            }
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
    }
}
