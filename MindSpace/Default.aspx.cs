using System;
using System.Web.UI;

namespace MindSpace
{
    public partial class DefaultPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Logged-in users should never see the public marketing hero — send them straight
            // to their role-appropriate dashboard so the public content doesn't appear under
            // the authenticated app shell.
            if (Session["UserID"] != null)
            {
                string role = Session["Role"]?.ToString();
                Response.Redirect(role == "admin" ? "~/Admin/AdminHome.aspx" : "~/User/UserHome.aspx");
                return;
            }
        }
    }
}
