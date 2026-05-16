using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MindSpace
{
    public partial class ProfilePage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
                LoadProfile();
        }

        private void LoadProfile()
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string sql = "SELECT FullName, Username, Email, Bio, DateRegistered, Role FROM Users WHERE UserID=@uid";
            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@uid", userID) });

            if (dt.Rows.Count == 1)
            {
                DataRow row = dt.Rows[0];
                string fullName = row["FullName"].ToString();

                txtFullName.Text = fullName;
                txtUsername.Text = row["Username"].ToString();
                txtEmail.Text    = row["Email"].ToString();
                txtBio.Text      = row["Bio"]?.ToString() ?? "";

                litAvatarInitial.Text  = fullName.Length > 0 ? fullName[0].ToString().ToUpper() : "U";
                litDisplayName.Text    = fullName;
                litDisplayUsername.Text = "@" + row["Username"].ToString();
                litJoined.Text         = Convert.ToDateTime(row["DateRegistered"]).ToString("dd MMMM yyyy");
                litRole.Text           = row["Role"].ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int    userID   = Convert.ToInt32(Session["UserID"]);
            string fullName = txtFullName.Text.Trim();
            string email    = txtEmail.Text.Trim().ToLower();
            string bio      = txtBio.Text.Trim();

            // Check email uniqueness (excluding current user)
            int ec = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM Users WHERE Email=@email AND UserID<>@uid",
                new[] { new SqlParameter("@email", email), new SqlParameter("@uid", userID) }));

            if (ec > 0)
            {
                pnlError.Visible = true;
                litError.Text    = "That email is already in use by another account.";
                return;
            }

            string sql = "UPDATE Users SET FullName=@fn, Email=@email, Bio=@bio WHERE UserID=@uid";
            DatabaseHelper.ExecuteNonQuery(sql, new[] {
                new SqlParameter("@fn",    fullName),
                new SqlParameter("@email", email),
                new SqlParameter("@bio",   bio),
                new SqlParameter("@uid",   userID)
            });

            // Update session
            Session["FullName"] = fullName;

            pnlMsg.Visible   = true;
            litMsg.Text      = "Profile updated successfully!";
            pnlError.Visible = false;

            // Refresh display
            litDisplayName.Text   = fullName;
            litAvatarInitial.Text = fullName.Length > 0 ? fullName[0].ToString().ToUpper() : "U";
        }
    }
}
