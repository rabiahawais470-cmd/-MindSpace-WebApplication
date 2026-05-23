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
                LoadUsers();
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
            LoadUsers(txtSearch.Text.Trim(), ddlRoleFilter.SelectedValue);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email    = txtEmail.Text.Trim().ToLower();
            string role     = ddlRole.SelectedValue;
            bool   isActive = ddlStatus.SelectedValue == "1";
            int    editID   = Convert.ToInt32(hdnEditUserID.Value);

            try
            {
                if (editID == 0)
                {
                    // ADD NEW USER
                    string password = txtPassword.Text;
                    if (string.IsNullOrEmpty(password)) { ShowError("Password is required."); return; }

                    // Check uniqueness
                    int uc = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                        "SELECT COUNT(*) FROM Users WHERE Username=@u", new[] { new SqlParameter("@u", username) }));
                    if (uc > 0) { ShowError("Username already exists."); return; }

                    int ec = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                        "SELECT COUNT(*) FROM Users WHERE Email=@e", new[] { new SqlParameter("@e", email) }));
                    if (ec > 0) { ShowError("Email already registered."); return; }

                    string sql = @"INSERT INTO Users (FullName,Username,Email,PasswordHash,Role,IsActive)
                                   VALUES (@fn,@un,@em,@ph,@role,@active)";
                    DatabaseHelper.ExecuteNonQuery(sql, new[] {
                        new SqlParameter("@fn",     fullName),
                        new SqlParameter("@un",     username),
                        new SqlParameter("@em",     email),
                        new SqlParameter("@ph",     DatabaseHelper.HashPassword(password)),
                        new SqlParameter("@role",   role),
                        new SqlParameter("@active", isActive)
                    });
                    ShowMessage("User created successfully.");
                }
                else
                {
                    // UPDATE USER
                    string sql = @"UPDATE Users SET FullName=@fn,Username=@un,Email=@em,Role=@role,IsActive=@active
                                   WHERE UserID=@id";
                    DatabaseHelper.ExecuteNonQuery(sql, new[] {
                        new SqlParameter("@fn",     fullName),
                        new SqlParameter("@un",     username),
                        new SqlParameter("@em",     email),
                        new SqlParameter("@role",   role),
                        new SqlParameter("@active", isActive),
                        new SqlParameter("@id",     editID)
                    });
                    ShowMessage("User updated successfully.");
                }

                ResetForm();
                LoadUsers();
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int userID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteUser")
            {
                DatabaseHelper.ExecuteNonQuery(
                    "DELETE FROM Users WHERE UserID=@id",
                    new[] { new SqlParameter("@id", userID) });
                BindGrid();
            }
            else if (e.CommandName == "EditUser")
            {
                Response.Redirect("EditUser.aspx?id=" + userID);
            }
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
            ddlRole.SelectedValue    = "learner";
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

        private void ShowError(string msg)
        {
            pnlError.Visible = true;
            litError.Text    = msg;
            pnlMsg.Visible   = false;
        }
    }
}
