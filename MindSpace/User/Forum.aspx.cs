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
                bool loggedIn = Session["UserID"] != null;
                pnlCreatePost.Visible  = loggedIn;
                pnlGuestPrompt.Visible = !loggedIn;
                pnlProfile.Visible     = loggedIn;
                if (loggedIn) LoadProfile();
                LoadPosts();
            }
        }

        private void LoadProfile()
        {
            int uid = Convert.ToInt32(Session["UserID"]);
            litProfileName.Text     = System.Web.HttpUtility.HtmlEncode(Session["FullName"]?.ToString() ?? "");
            litProfileUsername.Text = System.Web.HttpUtility.HtmlEncode(Session["Username"]?.ToString()  ?? "");
            object pc = DatabaseHelper.ExecuteScalar(
                @"SELECT (SELECT COUNT(*) FROM ForumPosts WHERE UserID=@uid AND IsActive=1) +
                         (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", uid) });
            litProfilePostCount.Text = pc?.ToString() ?? "0";
            object jd = DatabaseHelper.ExecuteScalar("SELECT DateRegistered FROM Users WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", uid) });
            litProfileJoinDate.Text = (jd != null && jd != DBNull.Value)
                ? Convert.ToDateTime(jd).ToString("MMM yyyy") : "";
        }

        private void LoadPosts(string search = "")
        {
            string sort    = hdnSort.Value ?? "newest";
            string orderBy = sort == "replies" ? "CommentCount DESC, fp.DatePosted DESC"
                           : sort == "views"   ? "fp.ViewCount DESC, fp.DatePosted DESC"
                                               : "fp.DatePosted DESC";

            string sql = $@"
                SELECT fp.PostID, fp.Title, fp.Content, fp.DatePosted, fp.ViewCount, fp.IsResolved,
                       u.FullName,
                       (SELECT COUNT(*) FROM ForumComments fc WHERE fc.PostID=fp.PostID AND fc.IsActive=1) AS CommentCount
                FROM   ForumPosts fp
                JOIN   Users u ON fp.UserID = u.UserID
                WHERE  fp.IsActive = 1
                  AND  (@search='' OR fp.Title LIKE @searchLike OR fp.Content LIKE @searchLike)
                ORDER  BY {orderBy}";

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
            int uid = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;

            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET ViewCount=ViewCount+1 WHERE PostID=@id",
                new[] { new SqlParameter("@id", postID) });

            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT fp.PostID, fp.Title, fp.Content, fp.DatePosted,
                       fp.IsResolved, fp.UserID, u.FullName
                FROM   ForumPosts fp
                JOIN   Users u ON fp.UserID=u.UserID
                WHERE  fp.PostID=@id AND fp.IsActive=1",
                new[] { new SqlParameter("@id", postID) });

            if (dt.Rows.Count == 0) return;
            DataRow row     = dt.Rows[0];
            bool isResolved = Convert.ToBoolean(row["IsResolved"]);
            int  ownerID    = Convert.ToInt32(row["UserID"]);

            litPostTitle.Text   = System.Web.HttpUtility.HtmlEncode(row["Title"].ToString());
            litPostAuthor.Text  = System.Web.HttpUtility.HtmlEncode(row["FullName"].ToString());
            litPostDate.Text    = Convert.ToDateTime(row["DatePosted"]).ToString("dd MMMM yyyy, HH:mm");
            litPostContent.Text = System.Web.HttpUtility.HtmlEncode(row["Content"].ToString()).Replace("\n","<br/>");

            litResolvedBadge.Text = isResolved
                ? "<div class=\"alert alert-success py-2 mb-3\"><i class=\"fas fa-check-circle me-2\"></i>This discussion has been marked as <strong>Resolved</strong>.</div>"
                : "";

            bool isOwner = uid > 0 && uid == ownerID;
            pnlPostOwnerActions.Visible = isOwner;
            if (isOwner) btnMarkResolved.Visible = !isResolved;

            pnlAddComment.Visible = uid > 0;

            DataTable cmts = DatabaseHelper.ExecuteQuery(@"
                SELECT fc.CommentID, fc.Content, fc.DatePosted, u.FullName
                FROM   ForumComments fc
                JOIN   Users u ON fc.UserID=u.UserID
                WHERE  fc.PostID=@id AND fc.IsActive=1
                ORDER  BY fc.DatePosted ASC",
                new[] { new SqlParameter("@id", postID) });

            rptComments.DataSource = cmts;
            rptComments.DataBind();
            litCommentCount.Text  = cmts.Rows.Count.ToString();
            hdnPostID.Value       = postID.ToString();
            pnlPostDetail.Visible = true;
            pnlPostsList.Visible  = false;
            pnlEditPost.Visible   = false;
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
        {
            hdnSearch.Value = txtSearch.Text.Trim();
            hdnPage.Value   = "1";
            LoadPosts(hdnSearch.Value);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text  = "";
            hdnSearch.Value = "";
            hdnPage.Value   = "1";
            LoadPosts();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdnSort.Value = ddlSort.SelectedValue;
            hdnPage.Value = "1";
            LoadPosts(hdnSearch.Value);
        }

        protected void btnBackToList_Click(object sender, EventArgs e) => LoadPosts();

        protected void btnEditPost_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) return;
            int postID = Convert.ToInt32(hdnPostID.Value);
            int uid    = Convert.ToInt32(Session["UserID"]);
            var dt = DatabaseHelper.ExecuteQuery(
                "SELECT Title, Content FROM ForumPosts WHERE PostID=@id AND UserID=@uid AND IsActive=1",
                new[] { new SqlParameter("@id", postID), new SqlParameter("@uid", uid) });
            if (dt.Rows.Count == 0) return;
            txtEditTitle.Text    = dt.Rows[0]["Title"].ToString();
            txtEditContent.Text  = dt.Rows[0]["Content"].ToString();
            LoadPostDetail(postID);
            pnlEditPost.Visible  = true;
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || Session["UserID"] == null) return;
            int postID = Convert.ToInt32(hdnPostID.Value);
            int uid    = Convert.ToInt32(Session["UserID"]);
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET Title=@t, Content=@c, EditedAt=GETDATE() WHERE PostID=@id AND UserID=@uid",
                new[] {
                    new SqlParameter("@t",   txtEditTitle.Text.Trim()),
                    new SqlParameter("@c",   txtEditContent.Text.Trim()),
                    new SqlParameter("@id",  postID),
                    new SqlParameter("@uid", uid)
                });
            pnlMsg.Visible = true;
            litMsg.Text    = "Discussion updated.";
            LoadPostDetail(postID);
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
            => LoadPostDetail(Convert.ToInt32(hdnPostID.Value));

        protected void btnDeletePost_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) return;
            int postID = Convert.ToInt32(hdnPostID.Value);
            int uid    = Convert.ToInt32(Session["UserID"]);
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET IsActive=0 WHERE PostID=@id AND UserID=@uid",
                new[] { new SqlParameter("@id", postID), new SqlParameter("@uid", uid) });
            pnlMsg.Visible = true;
            litMsg.Text    = "Discussion deleted.";
            LoadPosts();
        }

        protected void btnMarkResolved_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) return;
            int postID = Convert.ToInt32(hdnPostID.Value);
            int uid    = Convert.ToInt32(Session["UserID"]);
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET IsResolved=1 WHERE PostID=@id AND UserID=@uid",
                new[] { new SqlParameter("@id", postID), new SqlParameter("@uid", uid) });
            LoadPostDetail(postID);
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            int p = int.TryParse(hdnPage.Value, out int pv) ? Math.Max(1, pv - 1) : 1;
            hdnPage.Value = p.ToString();
            LoadPosts(hdnSearch.Value);
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            int p = int.TryParse(hdnPage.Value, out int pv) ? pv + 1 : 2;
            hdnPage.Value = p.ToString();
            LoadPosts(hdnSearch.Value);
        }
    }
}
