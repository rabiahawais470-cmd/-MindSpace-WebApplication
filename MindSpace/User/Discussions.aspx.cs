using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MindSpace
{
    public partial class DiscussionsPage : Page
    {
        private const int PageSize = 10;

        // ---- State helpers (hidden fields) ----
        private int CurrentPage
        {
            get { return int.TryParse(hdnPage.Value, out int p) ? Math.Max(1, p) : 1; }
            set { hdnPage.Value = value.ToString(); }
        }
        private string SortOrder
        {
            get { return hdnSort.Value ?? "newest"; }
            set { hdnSort.Value = value; }
        }
        private string SearchTerm
        {
            get { return hdnSearch.Value ?? ""; }
            set { hdnSearch.Value = value; }
        }

        private int  CurrentUserID => Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;
        private bool IsLoggedIn    => Session["UserID"] != null;

        // ============================================================
        // PAGE LOAD
        // ============================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bool loggedIn = IsLoggedIn;
                pnlCreatePost.Visible  = loggedIn;
                pnlGuestPrompt.Visible = !loggedIn;
                pnlProfile.Visible     = loggedIn;

                if (loggedIn)
                    LoadUserProfile();

                // Sync sort dropdown with stored state
                ddlSort.SelectedValue = SortOrder;

                LoadPosts();
            }
        }

        // ============================================================
        // PROFILE CARD
        // ============================================================
        private void LoadUserProfile()
        {
            int uid = CurrentUserID;
            litProfileName.Text     = HttpUtility.HtmlEncode(Session["FullName"]?.ToString() ?? "");
            litProfileUsername.Text = HttpUtility.HtmlEncode(Session["Username"]?.ToString()  ?? "");

            object postCount = DatabaseHelper.ExecuteScalar(
                @"SELECT
                    (SELECT COUNT(*) FROM ForumPosts    WHERE UserID=@uid AND IsActive=1) +
                    (SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND IsActive=1)",
                new[] { new SqlParameter("@uid", uid) });
            litProfilePostCount.Text = postCount?.ToString() ?? "0";

            object joined = DatabaseHelper.ExecuteScalar(
                "SELECT DateRegistered FROM Users WHERE UserID=@uid",
                new[] { new SqlParameter("@uid", uid) });
            litProfileJoinDate.Text = (joined != null && joined != DBNull.Value)
                ? Convert.ToDateTime(joined).ToString("MMM yyyy")
                : "";
        }

        // ============================================================
        // POSTS LIST
        // ============================================================
        private void LoadPosts()
        {
            string search = SearchTerm;
            int    page   = CurrentPage;
            string sort   = SortOrder;

            // Sync dropdown to current state
            if (ddlSort.Items.FindByValue(sort) != null)
                ddlSort.SelectedValue = sort;

            // Total count for pagination
            int total = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                @"SELECT COUNT(*) FROM ForumPosts fp
                  WHERE fp.IsActive=1
                    AND (@s='' OR fp.Title LIKE @sl OR fp.Content LIKE @sl)",
                new[] {
                    new SqlParameter("@s",  search),
                    new SqlParameter("@sl", "%" + search + "%")
                }));

            int totalPages = Math.Max(1, (int)Math.Ceiling(total / (double)PageSize));
            if (page > totalPages) { page = totalPages; CurrentPage = page; }
            int offset = (page - 1) * PageSize;

            string orderBy = sort == "replies" ? "CommentCount DESC, fp.DatePosted DESC"
                           : sort == "views"   ? "fp.ViewCount DESC, fp.DatePosted DESC"
                                               : "fp.DatePosted DESC";

            // Use string interpolation only for the ORDER BY clause (no user input)
            string sql = $@"
                SELECT fp.PostID, fp.Title, fp.Content, fp.DatePosted,
                       fp.ViewCount, fp.IsResolved, u.FullName,
                       (SELECT COUNT(*) FROM ForumComments fc
                        WHERE fc.PostID=fp.PostID AND fc.IsActive=1) AS CommentCount
                FROM   ForumPosts fp
                JOIN   Users u ON fp.UserID = u.UserID
                WHERE  fp.IsActive = 1
                  AND  (@s='' OR fp.Title LIKE @sl OR fp.Content LIKE @sl)
                ORDER  BY {orderBy}
                OFFSET @off ROWS FETCH NEXT @ps ROWS ONLY";

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] {
                new SqlParameter("@s",  search),
                new SqlParameter("@sl", "%" + search + "%"),
                new SqlParameter("@off", offset),
                new SqlParameter("@ps",  PageSize)
            });

            // Add a plain-text excerpt column (stripped of HTML)
            dt.Columns.Add("PlainContent", typeof(string));
            foreach (DataRow row in dt.Rows)
                row["PlainContent"] = StripHtml(row["Content"].ToString());

            rptPosts.DataSource = dt;
            rptPosts.DataBind();

            // Pagination controls
            if (totalPages > 1)
            {
                pnlPagination.Visible  = true;
                litCurrentPage.Text    = page.ToString();
                litTotalPages.Text     = totalPages.ToString();
                btnPrevPage.Enabled    = page > 1;
                btnNextPage.Enabled    = page < totalPages;
            }
            else
            {
                pnlPagination.Visible = false;
            }

            pnlPostsList.Visible  = true;
            pnlPostDetail.Visible = false;
            pnlMsg.Visible        = false;
            pnlError.Visible      = false;
        }

        // ============================================================
        // POST DETAIL
        // ============================================================
        private void LoadPostDetail(int postID)
        {
            // Increment view count (skip for the post owner)
            if (!IsLoggedIn || CurrentUserID != GetPostOwnerID(postID))
            {
                DatabaseHelper.ExecuteNonQuery(
                    "UPDATE ForumPosts SET ViewCount=ViewCount+1 WHERE PostID=@id",
                    new[] { new SqlParameter("@id", postID) });
            }

            // Load post
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT fp.PostID, fp.Title, fp.Content, fp.DatePosted,
                       fp.ViewCount, fp.IsResolved, fp.EditedAt, fp.UserID,
                       u.FullName
                FROM   ForumPosts fp
                JOIN   Users u ON fp.UserID = u.UserID
                WHERE  fp.PostID = @id AND fp.IsActive = 1",
                new[] { new SqlParameter("@id", postID) });

            if (dt.Rows.Count == 0) { LoadPosts(); return; }

            DataRow row      = dt.Rows[0];
            bool isResolved  = Convert.ToBoolean(row["IsResolved"]);
            int  ownerID     = Convert.ToInt32(row["UserID"]);
            bool isOwner     = IsLoggedIn && CurrentUserID == ownerID;

            litPostTitle.Text   = HttpUtility.HtmlEncode(row["Title"].ToString());
            litPostAuthor.Text  = HttpUtility.HtmlEncode(row["FullName"].ToString());
            litPostDate.Text    = Convert.ToDateTime(row["DatePosted"]).ToString("dd MMMM yyyy, HH:mm");
            litPostViews.Text   = row["ViewCount"].ToString();
            litPostContent.Text = SanitizeHtml(row["Content"].ToString()).Replace("\n", "<br/>");

            litEditedLabel.Text = (row["EditedAt"] != DBNull.Value)
                ? $"<span class=\"text-muted\" style=\"font-size:0.78rem;\"><i class=\"fas fa-edit me-1\"></i>Edited {Convert.ToDateTime(row["EditedAt"]).ToString("dd MMM yyyy")}</span>"
                : "";

            litResolvedBadge.Text = isResolved
                ? "<div class=\"alert alert-success py-2 mb-3\"><i class=\"fas fa-check-circle me-2\"></i>This discussion has been marked as <strong>Resolved</strong>.</div>"
                : "";

            pnlPostOwnerActions.Visible = isOwner;
            if (isOwner)
                btnToggleResolved.Text = isResolved ? "&#9747; Reopen" : "&#10003; Mark Resolved";

            // Reply form visibility
            pnlAddComment.Visible    = IsLoggedIn;
            pnlLoginToReply.Visible  = !IsLoggedIn;

            hdnPostID.Value = postID.ToString();
            LoadComments(postID);

            pnlPostDetail.Visible  = true;
            pnlPostsList.Visible   = false;
            pnlEditPost.Visible    = false;
            pnlEditComment.Visible = false;
        }

        private void LoadComments(int postID)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery(@"
                SELECT fc.CommentID, fc.PostID, fc.UserID, fc.Content, fc.DatePosted,
                       u.FullName,
                       CASE WHEN fc.EditedAt IS NOT NULL THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS IsEdited
                FROM   ForumComments fc
                JOIN   Users u ON fc.UserID = u.UserID
                WHERE  fc.PostID = @id AND fc.IsActive = 1
                ORDER  BY fc.DatePosted ASC",
                new[] { new SqlParameter("@id", postID) });

            dt.Columns.Add("IsOwner",    typeof(bool));
            dt.Columns.Add("ContentHtml", typeof(string));

            foreach (DataRow r in dt.Rows)
            {
                r["IsOwner"]     = IsLoggedIn && Convert.ToInt32(r["UserID"]) == CurrentUserID;
                r["ContentHtml"] = SanitizeHtml(r["Content"].ToString()).Replace("\n", "<br/>");
            }

            if (dt.Rows.Count == 0)
            {
                rptComments.Visible = false;
                pnlNoComments.Visible = true;
            }
            else
            {
                pnlNoComments.Visible = false;
                rptComments.Visible = true;
                rptComments.DataSource = dt;
                rptComments.DataBind();
            }
            litCommentCount.Text = dt.Rows.Count.ToString();
        }

        private int GetPostOwnerID(int postID)
        {
            object uid = DatabaseHelper.ExecuteScalar(
                "SELECT UserID FROM ForumPosts WHERE PostID=@id",
                new[] { new SqlParameter("@id", postID) });
            return (uid != null && uid != DBNull.Value) ? Convert.ToInt32(uid) : -1;
        }

        // ============================================================
        // LIST EVENT HANDLERS
        // ============================================================
        protected void rptPosts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewPost")
                LoadPostDetail(Convert.ToInt32(e.CommandArgument));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchTerm  = txtSearch.Text.Trim();
            CurrentPage = 1;
            LoadPosts();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            SearchTerm     = "";
            CurrentPage    = 1;
            LoadPosts();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            SortOrder   = ddlSort.SelectedValue;
            CurrentPage = 1;
            LoadPosts();
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1) CurrentPage--;
            LoadPosts();
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            LoadPosts();
        }

        // ============================================================
        // CREATE POST
        // ============================================================
        protected void btnCreatePost_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (!IsLoggedIn) { Response.Redirect("~/Login.aspx"); return; }

            int    uid     = CurrentUserID;
            string title   = txtPostTitle.Text.Trim();
            string content = txtPostContent.Text.Trim();

            // Duplicate-post prevention (same title within 5 s)
            int dupe = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM ForumPosts WHERE UserID=@uid AND Title=@t AND DATEDIFF(SECOND, DatePosted, GETDATE()) < 5",
                new[] {
                    new SqlParameter("@uid", uid),
                    new SqlParameter("@t",   title)
                }));
            if (dupe > 0)
            {
                ShowError("Duplicate post detected. Please wait a moment before submitting again.");
                LoadPosts();
                return;
            }

            DatabaseHelper.ExecuteNonQuery(
                "INSERT INTO ForumPosts (UserID, Title, Content) VALUES (@uid, @t, @c)",
                new[] {
                    new SqlParameter("@uid", uid),
                    new SqlParameter("@t",   title),
                    new SqlParameter("@c",   content)
                });

            txtPostTitle.Text   = "";
            txtPostContent.Text = "";
            CurrentPage = 1;
            ShowSuccess("Your discussion has been posted!");
            LoadPosts();
        }

        // ============================================================
        // POST DETAIL HANDLERS
        // ============================================================
        protected void btnBackToList_Click(object sender, EventArgs e) => LoadPosts();

        protected void btnEditPost_Click(object sender, EventArgs e)
        {
            int postID = Convert.ToInt32(hdnPostID.Value);
            DataTable dt = DatabaseHelper.ExecuteQuery(
                "SELECT Title, Content FROM ForumPosts WHERE PostID=@id AND UserID=@uid AND IsActive=1",
                new[] {
                    new SqlParameter("@id",  postID),
                    new SqlParameter("@uid", CurrentUserID)
                });

            if (dt.Rows.Count == 0) return;
            txtEditTitle.Text   = dt.Rows[0]["Title"].ToString();
            txtEditContent.Text = dt.Rows[0]["Content"].ToString();

            LoadPostDetail(postID);
            pnlEditPost.Visible = true;
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            int postID = Convert.ToInt32(hdnPostID.Value);

            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET Title=@t, Content=@c, EditedAt=GETDATE() WHERE PostID=@id AND UserID=@uid",
                new[] {
                    new SqlParameter("@t",   txtEditTitle.Text.Trim()),
                    new SqlParameter("@c",   txtEditContent.Text.Trim()),
                    new SqlParameter("@id",  postID),
                    new SqlParameter("@uid", CurrentUserID)
                });

            ShowSuccess("Discussion updated successfully.");
            LoadPostDetail(postID);
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
            => LoadPostDetail(Convert.ToInt32(hdnPostID.Value));

        protected void btnDeletePost_Click(object sender, EventArgs e)
        {
            int postID = Convert.ToInt32(hdnPostID.Value);
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET IsActive=0 WHERE PostID=@id AND UserID=@uid",
                new[] {
                    new SqlParameter("@id",  postID),
                    new SqlParameter("@uid", CurrentUserID)
                });
            ShowSuccess("Discussion deleted.");
            CurrentPage = 1;
            LoadPosts();
        }

        protected void btnToggleResolved_Click(object sender, EventArgs e)
        {
            int postID = Convert.ToInt32(hdnPostID.Value);
            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumPosts SET IsResolved = CASE WHEN IsResolved=1 THEN 0 ELSE 1 END WHERE PostID=@id AND UserID=@uid",
                new[] {
                    new SqlParameter("@id",  postID),
                    new SqlParameter("@uid", CurrentUserID)
                });
            LoadPostDetail(postID);
        }

        // ============================================================
        // COMMENT HANDLERS
        // ============================================================
        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (!IsLoggedIn) return;

            int    uid     = CurrentUserID;
            int    postID  = Convert.ToInt32(hdnPostID.Value);
            string content = txtComment.Text.Trim();

            // Duplicate-reply prevention (same user, same post, within 5 s)
            int dupe = Convert.ToInt32(DatabaseHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM ForumComments WHERE UserID=@uid AND PostID=@pid AND DATEDIFF(SECOND, DatePosted, GETDATE()) < 5",
                new[] {
                    new SqlParameter("@uid", uid),
                    new SqlParameter("@pid", postID)
                }));
            if (dupe > 0)
            {
                ShowError("Duplicate reply detected. Please wait a moment before submitting again.");
                LoadPostDetail(postID);
                return;
            }

            DatabaseHelper.ExecuteNonQuery(
                "INSERT INTO ForumComments (PostID, UserID, Content) VALUES (@pid, @uid, @c)",
                new[] {
                    new SqlParameter("@pid", postID),
                    new SqlParameter("@uid", uid),
                    new SqlParameter("@c",   content)
                });

            txtComment.Text = "";
            ShowSuccess("Reply posted!");
            LoadPostDetail(postID);
        }

        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int commentID = Convert.ToInt32(e.CommandArgument);
            int postID    = Convert.ToInt32(hdnPostID.Value);

            if (e.CommandName == "EditComment")
            {
                DataTable dt = DatabaseHelper.ExecuteQuery(
                    "SELECT Content FROM ForumComments WHERE CommentID=@id AND UserID=@uid AND IsActive=1",
                    new[] {
                        new SqlParameter("@id",  commentID),
                        new SqlParameter("@uid", CurrentUserID)
                    });
                if (dt.Rows.Count == 0) return;

                txtEditComment.Text       = dt.Rows[0]["Content"].ToString();
                hdnEditCommentID.Value    = commentID.ToString();
                LoadPostDetail(postID);
                pnlEditComment.Visible    = true;
            }
            else if (e.CommandName == "DeleteComment")
            {
                DatabaseHelper.ExecuteNonQuery(
                    "UPDATE ForumComments SET IsActive=0 WHERE CommentID=@id AND UserID=@uid",
                    new[] {
                        new SqlParameter("@id",  commentID),
                        new SqlParameter("@uid", CurrentUserID)
                    });
                ShowSuccess("Reply deleted.");
                LoadPostDetail(postID);
            }
        }

        protected void btnSaveEditComment_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            int commentID = Convert.ToInt32(hdnEditCommentID.Value);
            int postID    = Convert.ToInt32(hdnPostID.Value);

            DatabaseHelper.ExecuteNonQuery(
                "UPDATE ForumComments SET Content=@c, EditedAt=GETDATE() WHERE CommentID=@id AND UserID=@uid",
                new[] {
                    new SqlParameter("@c",   txtEditComment.Text.Trim()),
                    new SqlParameter("@id",  commentID),
                    new SqlParameter("@uid", CurrentUserID)
                });

            ShowSuccess("Reply updated.");
            LoadPostDetail(postID);
        }

        protected void btnCancelEditComment_Click(object sender, EventArgs e)
            => LoadPostDetail(Convert.ToInt32(hdnPostID.Value));

        // ============================================================
        // HELPERS (used from ASPX Repeater templates)
        // ============================================================
        protected string GetQuoteBtn(string author, string rawContent)
        {
            if (!IsLoggedIn) return "";
            string safeAuthor  = HttpUtility.JavaScriptStringEncode(HttpUtility.HtmlEncode(author));
            string safeContent = HttpUtility.JavaScriptStringEncode(rawContent);
            return $"<button type=\"button\" class=\"btn btn-xs btn-outline-secondary\" onclick=\"quoteComment('{safeAuthor}','{safeContent}')\">" +
                   "<i class=\"fas fa-quote-right me-1\"></i>Quote</button>";
        }

        // ============================================================
        // MESSAGE HELPERS
        // ============================================================
        private void ShowSuccess(string msg)
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

        // ============================================================
        // CONTENT SANITISATION
        // ============================================================

        // Strip all HTML tags (used for plain-text excerpt display)
        private static string StripHtml(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            return Regex.Replace(input, "<[^>]+>", " ").Trim();
        }

        // Allow only safe tags: <b>, <i>, <a href="https://...">, <blockquote>
        private static string SanitizeHtml(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";

            // HTML-encode everything first
            string s = HttpUtility.HtmlEncode(input);

            // Restore allowed inline tags
            s = Regex.Replace(s, @"&lt;(/?b)&gt;",           "<$1>",              RegexOptions.IgnoreCase);
            s = Regex.Replace(s, @"&lt;(/?i)&gt;",           "<$1>",              RegexOptions.IgnoreCase);
            s = Regex.Replace(s, @"&lt;(/?blockquote)&gt;",  "<$1>",              RegexOptions.IgnoreCase);
            s = Regex.Replace(s, @"&lt;/a&gt;",              "</a>",              RegexOptions.IgnoreCase);

            // Restore <a href="https://..."> only (safe URLs)
            s = Regex.Replace(s,
                @"&lt;a href=&quot;(https?://[^&""<>]{1,500})&quot;&gt;",
                "<a href=\"$1\" target=\"_blank\" rel=\"noopener noreferrer\">",
                RegexOptions.IgnoreCase);

            return s;
        }
    }
}
