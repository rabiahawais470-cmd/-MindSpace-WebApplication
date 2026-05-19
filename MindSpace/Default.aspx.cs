using System;
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
            }
        }
    }
}
