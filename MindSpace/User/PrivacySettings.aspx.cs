using System;
using System.Web.UI;

namespace MindSpace.User
{
    public partial class PrivacySettings : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                if (Session["priv_publicProfile"]     != null) chkPublicProfile.Checked     = (bool)Session["priv_publicProfile"];
                if (Session["priv_showProgress"]      != null) chkShowProgress.Checked      = (bool)Session["priv_showProgress"];
                if (Session["priv_showForumActivity"] != null) chkShowForumActivity.Checked = (bool)Session["priv_showForumActivity"];
                if (Session["priv_analytics"]         != null) chkAnalytics.Checked         = (bool)Session["priv_analytics"];
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Session["priv_publicProfile"]     = chkPublicProfile.Checked;
            Session["priv_showProgress"]      = chkShowProgress.Checked;
            Session["priv_showForumActivity"] = chkShowForumActivity.Checked;
            Session["priv_analytics"]         = chkAnalytics.Checked;
            pnlSaved.Visible = true;
        }
    }
}
