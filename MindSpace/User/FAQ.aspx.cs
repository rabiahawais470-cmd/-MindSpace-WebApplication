using System;
using System.Web.UI;

namespace MindSpace.User
{
    public partial class FAQ : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }
    }
}
