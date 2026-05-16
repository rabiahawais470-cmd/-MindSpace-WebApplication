using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace
{
    public partial class LoginPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Redirect already-logged-in users
                if (Session["UserID"] != null)
                {
                    string role = Session["Role"]?.ToString();
                    Response.Redirect(role == "admin" ? "~/Admin/AdminHome.aspx" : "~/User/UserHome.aspx");
                    return;
                }

                // Show success message passed from registration
                if (Request.QueryString["registered"] == "1")
                {
                    pnlSuccess.Visible = true;
                    litSuccess.Text    = "Account created successfully! Please log in.";
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string credential = txtCredential.Text.Trim();
            string password   = txtPassword.Text;

            if (string.IsNullOrEmpty(credential) || string.IsNullOrEmpty(password))
            {
                ShowError("Please enter your username/email and password.");
                return;
            }

            string passwordHash = DatabaseHelper.HashPassword(password);

            string sql = @"
                SELECT UserID, FullName, Username, Email, Role
                FROM   Users
                WHERE  (Username = @credential OR Email = @credential)
                  AND  PasswordHash = @hash
                  AND  IsActive = 1";

            SqlParameter[] prms = {
                new SqlParameter("@credential", credential),
                new SqlParameter("@hash",       passwordHash)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);

            if (dt.Rows.Count == 1)
            {
                DataRow row = dt.Rows[0];
                Session["UserID"]   = Convert.ToInt32(row["UserID"]);
                Session["FullName"] = row["FullName"].ToString();
                Session["Username"] = row["Username"].ToString();
                Session["Role"]     = row["Role"].ToString();

                string role = row["Role"].ToString();
                Response.Redirect(role == "admin" ? "~/Admin/AdminHome.aspx" : "~/User/UserHome.aspx");
            }
            else
            {
                ShowError("Invalid username/email or password. Please try again.");
            }
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            litError.Text    = message;
        }
    }
}
