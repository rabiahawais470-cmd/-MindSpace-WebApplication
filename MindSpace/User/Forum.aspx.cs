using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MindSpace
{
    public partial class ForumPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    pnlCreatePost.Visible  = false;
                    pnlGuestPrompt.Visible = true;
                    pnlAddComment.Visible  = false;
                }
                LoadPosts();
            }
        }

        private void LoadPosts(string search = "")
        {
            string sql = @"
                SELECT fp.PostID, fp.Title, fp.Content, fp.DatePosted, fp.ViewCount,
                       u.FullName,
                       (SELECT COUNT(*) FROM ForumComments fc WHERE fc.PostID=fp.PostID AND fc.IsActive=1) AS CommentCount
                FROM   ForumPosts fp
                JOIN   Users u ON fp.UserID = u.UserID
                WHERE  fp.IsActive = 1
                  AND  (@search='' OR fp.Title LIKE @searchLike OR fp.Content LIKE @searchLike)
                ORDER  BY fp.DatePosted DESC";

            SqlParameter[] prms = {
                new SqlParameter("@search",     search),
                new SqlParameter("@searchLike", "%" + search + "%")
            };

            rptPosts.DataSource = DatabaseHelper.ExecuteQuery(sql, prms);
            rptPosts.DataBind();
            pnlPostsList.Visible  = true;
            pnlPostDetail.Visible = false;
        }

        private void LoadPostDetail(int postID)
        {
            // Increment view count
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET ViewCount=ViewCount+1 WHERE PostID=@id",
                new[] { new SqlParameter("@id", postID) });

            // Load post
            string sql = @"
                SELECT fp.PostID, fp.Title, fp.Content, fp.DatePosted, u.FullName
                FROM   ForumPosts fp
                JOIN   Users u ON fp.UserID=u.UserID
                WHERE  fp.PostID=@id";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", postID) });
            if (dt.Rows.Count == 0) return;

            DataRow row = dt.Rows[0];
            litPostTitle.Text   = row["Title"].ToString();
            litPostAuthor.Text  = row["FullName"].ToString();
            litPostDate.Text    = Convert.ToDateTime(row["DatePosted"]).ToString("dd MMMM yyyy, HH:mm");
            litPostContent.Text = row["Content"].ToString().Replace("\n", "<br/>");

            // Load comments
            string cmtSql = @"
                SELECT fc.CommentID, fc.Content, fc.DatePosted, u.FullName
                FROM   ForumComments fc
                JOIN   Users u ON fc.UserID=u.UserID
                WHERE  fc.PostID=@id AND fc.IsActive=1
                ORDER  BY fc.DatePosted ASC";

            DataTable cmts = DatabaseHelper.ExecuteQuery(cmtSql, new[] { new SqlParameter("@id", postID) });
            rptComments.DataSource = cmts;
            rptComments.DataBind();
            litCommentCount.Text = cmts.Rows.Count.ToString();

            hdnPostID.Value = postID.ToString();
            pnlPostDetail.Visible = true;
            pnlPostsList.Visible  = false;
        }

        protected void rptPosts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewPost")
            {
                int postID = Convert.ToInt32(e.CommandArgument);
                LoadPostDetail(postID);
            }
        }

        protected void btnCreatePost_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (Session["UserID"] == null) { Response.Redirect("~/Login.aspx"); return; }

            int    userID  = Convert.ToInt32(Session["UserID"]);
            string title   = txtPostTitle.Text.Trim();
            string content = txtPostContent.Text.Trim();

            DatabaseHelper.ExecuteNonQuery(
                "INSERT INTO ForumPosts (UserID,Title,Content) VALUES (@uid,@title,@content)",
                new[] {
                    new SqlParameter("@uid",     userID),
                    new SqlParameter("@title",   title),
                    new SqlParameter("@content", content)
                });

            txtPostTitle.Text   = "";
            txtPostContent.Text = "";
            pnlMsg.Visible      = true;
            litMsg.Text         = "Your discussion has been posted!";
            LoadPosts();
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (Session["UserID"] == null) return;

            int    userID  = Convert.ToInt32(Session["UserID"]);
            int    postID  = Convert.ToInt32(hdnPostID.Value);
            string content = txtComment.Text.Trim();

            DatabaseHelper.ExecuteNonQuery(
                "INSERT INTO ForumComments (PostID,UserID,Content) VALUES (@pid,@uid,@content)",
                new[] {
                    new SqlParameter("@pid",     postID),
                    new SqlParameter("@uid",     userID),
                    new SqlParameter("@content", content)
                });

            txtComment.Text   = "";
            pnlMsg.Visible    = true;
            litMsg.Text       = "Reply posted!";
            LoadPostDetail(postID);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
            => LoadPosts(txtSearch.Text.Trim());

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadPosts();
        }

        protected void btnBackToList_Click(object sender, EventArgs e)
            => LoadPosts();
    }
}
