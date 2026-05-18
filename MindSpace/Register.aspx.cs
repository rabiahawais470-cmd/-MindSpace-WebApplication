using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MindSpace
{
    public partial class RegisterPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    string role = Session["Role"]?.ToString();
                    Response.Redirect(role == "admin" ? "~/Admin/AdminHome.aspx" : "~/User/UserHome.aspx");
                }
            }
        }

        protected void ValidateUsername(object source, ServerValidateEventArgs e)
        {
            string username = e.Value.Trim();
            var validator = (CustomValidator)source;
            if (string.IsNullOrEmpty(username))
            {
                e.IsValid = false;
                validator.ErrorMessage = "Username is required.";
                validator.Style["visibility"] = "visible";
                return;
            }
            if (!Regex.IsMatch(username, @"^[A-Za-z0-9_]{3,50}$"))
            {
                e.IsValid = false;
                validator.ErrorMessage = "Username must be 3-50 characters: letters, numbers, or underscore.";
                validator.Style["visibility"] = "visible";
                return;
            }
            e.IsValid = true;
        }

        protected void ValidateEmail(object source, ServerValidateEventArgs e)
        {
            string email = e.Value.Trim();
            var validator = (CustomValidator)source;
            if (string.IsNullOrEmpty(email))
            {
                e.IsValid = false;
                validator.ErrorMessage = "Email is required.";
                validator.Style["visibility"] = "visible";
                return;
            }
            if (!Regex.IsMatch(email, @"^[^\s@]+@[^\s@]+\.[^\s@]+$"))
            {
                e.IsValid = false;
                validator.ErrorMessage = "Please enter a valid email address.";
                validator.Style["visibility"] = "visible";
                return;
            }
            e.IsValid = true;
        }

        protected void ValidatePassword(object source, ServerValidateEventArgs e)
        {
            string password = e.Value;
            var validator = (CustomValidator)source;
            if (string.IsNullOrEmpty(password))
            {
                e.IsValid = false;
                validator.ErrorMessage = "Password is required.";
                validator.Style["visibility"] = "visible";
                return;
            }
            if (password.Length < 8)
            {
                e.IsValid = false;
                validator.ErrorMessage = "Password must be at least 8 characters.";
                validator.Style["visibility"] = "visible";
                return;
            }
            e.IsValid = true;
        }

        protected void ValidateConfirmPassword(object source, ServerValidateEventArgs e)
        {
            string password = txtPassword.Text;
            string confirm = e.Value;
            var validator = (CustomValidator)source;
            if (string.IsNullOrEmpty(confirm))
            {
                e.IsValid = false;
                validator.ErrorMessage = "Please confirm your password.";
                validator.Style["visibility"] = "visible";
                return;
            }
            if (password != confirm)
            {
                e.IsValid = false;
                validator.ErrorMessage = "Passwords do not match.";
                validator.Style["visibility"] = "visible";
                return;
            }
            e.IsValid = true;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName  = txtFullName.Text.Trim();
            string username  = txtUsername.Text.Trim();
            string email     = txtEmail.Text.Trim().ToLower();
            string password  = txtPassword.Text;
            string confirm   = txtConfirmPassword.Text;

            // Server-side confirm check
            if (password != confirm)
            {
                ShowError("Passwords do not match.");
                return;
            }

            // Check username uniqueness
            string checkUser = "SELECT COUNT(*) FROM Users WHERE Username = @username";
            int userCount = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkUser, new[] {
                new SqlParameter("@username", username)
            }));

            if (userCount > 0)
            {
                ShowError("That username is already taken. Please choose a different one.");
                return;
            }

            // Check email uniqueness
            string checkEmail = "SELECT COUNT(*) FROM Users WHERE Email = @email";
            int emailCount = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkEmail, new[] {
                new SqlParameter("@email", email)
            }));

            if (emailCount > 0)
            {
                ShowError("An account with that email already exists. Please login or use a different email.");
                return;
            }

            // Insert new user
            string passwordHash = DatabaseHelper.HashPassword(password);
            string sql = @"
                INSERT INTO Users (FullName, Username, Email, PasswordHash, Role)
                VALUES (@fullName, @username, @email, @hash, 'learner');
                SELECT SCOPE_IDENTITY();";

            SqlParameter[] prms = {
                new SqlParameter("@fullName", fullName),
                new SqlParameter("@username", username),
                new SqlParameter("@email",    email),
                new SqlParameter("@hash",     passwordHash)
            };

            bool registered = false;
            try
            {
                object result = DatabaseHelper.ExecuteScalar(sql, prms);

                if (result != null)
                    registered = true;
                else
                    ShowError("An error occurred during registration. Please try again.");
            }
            catch (Exception ex)
            {
                ShowError("Registration failed: " + ex.Message);
            }

            if (registered)
                Response.Redirect("~/Login.aspx?registered=1");
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            litError.Text    = message;
        }
    }
}
