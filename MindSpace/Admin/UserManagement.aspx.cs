using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MindSpace
{
    public partial class UserManagement : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RequireAdmin();
            if (!IsPostBack)
            {
                BindGrid();
                pnlPasswordField.Visible = true;
            }
        }

        private void RequireAdmin()
        {
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "admin")
                Response.Redirect("~/Login.aspx");
        }

        private void LoadUsers(string search = "", string roleFilter = "")
        {
            string sql = @"
                SELECT UserID, FullName, Username, Email, Role, IsActive, DateRegistered
                FROM   Users
                WHERE  (@search='' OR FullName LIKE @searchLike OR Username LIKE @searchLike OR Email LIKE @searchLike)
                  AND  (@role='' OR Role=@role)
                ORDER  BY DateRegistered DESC";

            SqlParameter[] prms = {
                new SqlParameter("@search",     search),
                new SqlParameter("@searchLike", "%" + search + "%"),
                new SqlParameter("@role",        roleFilter)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
            litCount.Text = dt.Rows.Count.ToString();
        }

        private void BindGrid()
        {
            string search = txtSearch.Text.Trim();
            string roleFilter = ddlRoleFilter.SelectedValue;

            string sql = @"
                SELECT UserID, FullName, Username, Email, Role, IsActive, DateRegistered
                FROM   Users
                WHERE  (@search='' OR FullName LIKE @searchLike OR Username LIKE @searchLike OR Email LIKE @searchLike)
                  AND  (@role='' OR Role=@role)
                ORDER  BY DateRegistered DESC";

            SqlParameter[] prms = {
                new SqlParameter("@search",     search),
                new SqlParameter("@searchLike", "%" + search + "%"),
                new SqlParameter("@role",        roleFilter)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
            litCount.Text = dt.Rows.Count.ToString();
        }

        protected void btnSaveUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;
            string role = ddlRole.SelectedValue;

            try
            {
                if (string.IsNullOrWhiteSpace(fullName) ||
                    string.IsNullOrWhiteSpace(username) ||
                    string.IsNullOrWhiteSpace(email) ||
                    string.IsNullOrWhiteSpace(password) ||
                    string.IsNullOrWhiteSpace(role))
                {
                    ShowError("All required fields must be filled.");
                    return;
                }

                int exists = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                    "SELECT COUNT(*) FROM Users WHERE Username=@username OR Email=@email",
                    new[] {
                        new SqlParameter("@username", username),
                        new SqlParameter("@email", email)
                    }));
                if (exists > 0)
                {
                    ShowError("Email or username already exists");
                    return;
                }

                DatabaseHelper.ExecuteNonQuery(
                    @"INSERT INTO Users (FullName, Username, Email, PasswordHash, Role, IsActive, DateRegistered)
                      VALUES (@name, @username, @email, @hash, @role, 1, GETDATE())",
                    new[] {
                        new SqlParameter("@name", fullName),
                        new SqlParameter("@username", username),
                        new SqlParameter("@email", email),
                        new SqlParameter("@hash", DatabaseHelper.HashPassword(password)),
                        new SqlParameter("@role", role)
                    });

                ResetForm();
                BindGrid();
                ShowToast("User added successfully");
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        protected void btnUpdateUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int userID = Convert.ToInt32(hdnEditUserID.Value);
            if (userID <= 0)
            {
                ShowError("Invalid user selection.");
                return;
            }

            string fullName = txtEditFullName.Text.Trim();
            string username = txtEditUsername.Text.Trim();
            string email = txtEditEmail.Text.Trim().ToLower();
            string role = ddlEditRole.SelectedValue;

            try
            {
                DatabaseHelper.ExecuteNonQuery(
                    "UPDATE Users SET FullName=@name, Username=@username, Email=@email, Role=@role WHERE UserID=@id",
                    new[] {
                        new SqlParameter("@name", fullName),
                        new SqlParameter("@username", username),
                        new SqlParameter("@email", email),
                        new SqlParameter("@role", role),
                        new SqlParameter("@id", userID)
                    });

                hdnEditUserID.Value = "0";
                BindGrid();
                ShowToast("User updated successfully");
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("RowCommand fired: " + e.CommandName + " " + e.CommandArgument);
            int userID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteUser")
            {
                DeleteUser(userID);
            }
            else if (e.CommandName == "EditUser")
            {
                Response.Redirect("EditUser.aspx?id=" + userID);
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hdnDeleteUserID.Value)) return;

            int userID = Convert.ToInt32(hdnDeleteUserID.Value);
            if (userID <= 0) return;

            var parameters = new[] { new SqlParameter("@id", userID) };

            DatabaseHelper.ExecuteNonQuery("DELETE FROM UserProgress WHERE UserID=@id", parameters);
            DatabaseHelper.ExecuteNonQuery("DELETE FROM QuizResults WHERE UserID=@id", parameters);
            DatabaseHelper.ExecuteNonQuery("DELETE FROM Enrollments WHERE UserID=@id", parameters);
            DatabaseHelper.ExecuteNonQuery("DELETE FROM ForumComments WHERE UserID=@id", parameters);
            DatabaseHelper.ExecuteNonQuery("DELETE FROM ForumPosts WHERE UserID=@id", parameters);
            DatabaseHelper.ExecuteNonQuery("DELETE FROM Users WHERE UserID=@id", parameters);

            BindGrid();
            ShowToast("User deleted successfully");
            hdnDeleteUserID.Value = "0";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text          = "";
            ddlRoleFilter.SelectedValue = "";
            BindGrid();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        private void ResetForm()
        {
            hdnEditUserID.Value      = "0";
            txtFullName.Text         = "";
            txtUsername.Text         = "";
            txtEmail.Text            = "";
            txtPassword.Text         = "";
            ddlRole.SelectedValue    = "";
            ddlStatus.SelectedValue  = "1";
            litFormTitle.Text        = "Add New User";
            pnlPasswordField.Visible = true;
            pnlError.Visible         = false;
        }

        private void ShowMessage(string msg)
        {
            pnlMsg.Visible   = true;
            litMsg.Text      = msg;
            pnlError.Visible = false;
        }

        private void ShowToast(string message)
        {
            pnlToast.Visible = true;
            litToastMessage.Text = message;
            ClientScript.RegisterStartupScript(
                GetType(),
                "ShowUserManagementToast",
                "var toastEl = document.getElementById('userManagementToast'); if (toastEl && window.bootstrap) { bootstrap.Toast.getOrCreateInstance(toastEl).show(); }",
                true);
        }

        private void DeleteUser(int userID)
        {
            DatabaseHelper.ExecuteNonQuery(
                "DELETE FROM Users WHERE UserID=@id",
                new[] { new SqlParameter("@id", userID) });
            BindGrid();
            ShowToast("User deleted successfully");
        }

        private void ShowError(string msg)
        {
            pnlError.Visible = true;
            litError.Text    = msg;
            pnlMsg.Visible   = false;
        }
    }
}
