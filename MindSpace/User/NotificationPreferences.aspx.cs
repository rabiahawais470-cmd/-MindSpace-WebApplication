using System;
using System.Web.UI;

namespace MindSpace.User
{
    public partial class NotificationPreferences : Page
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
                // Restore prior session-saved choices.
                if (Session["pref_courseUpdates"] != null)
                    chkCourseUpdates.Checked = (bool)Session["pref_courseUpdates"];
                if (Session["pref_discussionReplies"] != null)
                    chkDiscussionReplies.Checked = (bool)Session["pref_discussionReplies"];
                if (Session["pref_weeklyDigest"] != null)
                    chkWeeklyDigest.Checked = (bool)Session["pref_weeklyDigest"];
                if (Session["pref_quizReminders"] != null)
                    chkQuizReminders.Checked = (bool)Session["pref_quizReminders"];
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Session["pref_courseUpdates"]     = chkCourseUpdates.Checked;
            Session["pref_discussionReplies"] = chkDiscussionReplies.Checked;
            Session["pref_weeklyDigest"]      = chkWeeklyDigest.Checked;
            Session["pref_quizReminders"]     = chkQuizReminders.Checked;
            pnlSaved.Visible = true;
        }
    }
}
