using System;
using System.Web.UI;

namespace MindSpace
{
    public partial class SiteMaster : MasterPage
    {
        protected bool HideSearch { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            HideSearch = ShouldHideSearch();

            if (Session["UserID"] != null)
            {
                string role = Session["Role"]?.ToString() ?? "learner";
                pnlGuestNav.Visible = false;

                if (role == "admin")
                {
                    pnlAdminNav.Visible = true;
                    pnlUserNav.Visible  = false;
                }
                else
                {
                    pnlUserNav.Visible  = true;
                    pnlAdminNav.Visible = false;
                    lblNavName.Text     = Session["FullName"]?.ToString() ?? Session["Username"]?.ToString();
                }
            }

            else
            {
                pnlGuestNav.Visible = true;
                pnlUserNav.Visible  = false;
                pnlAdminNav.Visible = false;
            }
        }

        private bool ShouldHideSearch()
        {
            string path = (Request?.AppRelativeCurrentExecutionFilePath ?? string.Empty).ToLowerInvariant();
            return path.EndsWith("/user/reportbug.aspx", StringComparison.OrdinalIgnoreCase)
                || path.EndsWith("/user/notificationspreferences.aspx", StringComparison.OrdinalIgnoreCase)
                || path.EndsWith("/user/privacysettings.aspx", StringComparison.OrdinalIgnoreCase)
                || path.EndsWith("/user/faq.aspx", StringComparison.OrdinalIgnoreCase)
                || path.EndsWith("/changepassword.aspx", StringComparison.OrdinalIgnoreCase);
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
