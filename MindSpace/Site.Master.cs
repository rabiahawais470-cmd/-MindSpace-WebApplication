using System;
using System.Web.UI;

namespace MindSpace
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
