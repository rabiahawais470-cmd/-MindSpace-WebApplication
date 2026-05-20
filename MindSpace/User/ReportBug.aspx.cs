using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace.User
{
    public partial class ReportBug : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string reportText = (txtReport.Text ?? string.Empty).Trim();
            if (reportText.Length == 0) return;

            int? userID = Session["UserID"] != null ? (int?)Convert.ToInt32(Session["UserID"]) : null;
            string ua = Request.UserAgent ?? string.Empty;
            if (ua.Length > 500) ua = ua.Substring(0, 500);

            DatabaseHelper.ExecuteNonQuery(
                "INSERT INTO BugReports (UserID, ReportText, UserAgent) VALUES (@uid, @txt, @ua)",
                new[] {
                    new SqlParameter("@uid", (object)userID ?? DBNull.Value),
                    new SqlParameter("@txt", reportText),
                    new SqlParameter("@ua",  ua)
                });

            txtReport.Text = string.Empty;
            pnlSuccess.Visible = true;
        }
    }
}
