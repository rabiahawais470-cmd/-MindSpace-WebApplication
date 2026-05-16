using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace
{
    public partial class ChangePasswordPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int    userID      = Convert.ToInt32(Session["UserID"]);
            string currentPwd  = txtCurrentPassword.Text;
            string newPwd      = txtNewPassword.Text;
            string confirmPwd  = txtConfirmPassword.Text;

            if (newPwd != confirmPwd)
            {
                ShowError("New passwords do not match.");
                return;
            }

            // Verify current password
            string currentHash = DatabaseHelper.HashPassword(currentPwd);
            string checkSql    = "SELECT COUNT(*) FROM Users WHERE UserID = @uid AND PasswordHash = @hash";
            int count = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkSql, new[] {
                new SqlParameter("@uid",  userID),
                new SqlParameter("@hash", currentHash)
            }));

            if (count == 0)
            {
                ShowError("Your current password is incorrect.");
                return;
            }

            // Update password
            string newHash  = DatabaseHelper.HashPassword(newPwd);
            string updateSql = "UPDATE Users SET PasswordHash = @newHash WHERE UserID = @uid";
            DatabaseHelper.ExecuteNonQuery(updateSql, new[] {
                new SqlParameter("@newHash", newHash),
                new SqlParameter("@uid",     userID)
            });

            // Clear inputs
            txtCurrentPassword.Text = "";
            txtNewPassword.Text     = "";
            txtConfirmPassword.Text = "";

            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            string role = Session["Role"]?.ToString();
            Response.Redirect(role == "admin" ? "~/Admin/AdminHome.aspx" : "~/User/UserHome.aspx");
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            litError.Text    = message;
            pnlSuccess.Visible = false;
        }
    }
}
