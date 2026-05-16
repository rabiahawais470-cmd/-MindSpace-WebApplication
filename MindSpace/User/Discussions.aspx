<%@ Page Title="Discussions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Discussions.aspx.cs" Inherits="MindSpace.DiscussionsPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-comments me-2"></i>Community Discussions</h1>
            <p>Share experiences, ask questions, and support each other's mental wellness journey</p>
        </div>
    </div>

    <div class="container py-4">

        <asp:Panel ID="pnlMsg" runat="server" Visible="false">
            <div class="alert alert-success alert-auto-dismiss mb-3">
                <i class="fas fa-check-circle me-2"></i>
                <asp:Literal ID="litMsg" runat="server" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div class="alert alert-danger mb-3">
                <i class="fas fa-exclamation-circle me-2"></i>
                <asp:Literal ID="litError" runat="server" />
            </div>
        </asp:Panel>

        <div class="row g-4">

            <!-- ============================== LEFT COLUMN ============================== -->
            <div class="col-lg-8">

                <!-- Search & Sort bar -->
                <div class="ms-card p-3 mb-3">
                    <div class="d-flex gap-2 flex-wrap align-items-center">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                            placeholder="Search discussions by title or content..." style="flex:1;min-width:180px;" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search"
                            CssClass="btn btn-outline-primary" CausesValidation="false"
                            OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn btn-outline-secondary" CausesValidation="false"
                            OnClick="btnClear_Click" />
                        <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-select"
                            style="width:auto;" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                            <asp:ListItem Value="newest"  Text="Newest First" />
                            <asp:ListItem Value="replies" Text="Most Replies" />
                            <asp:ListItem Value="views"   Text="Most Views" />
                        </asp:DropDownList>
                    </div>
                </div>

                <!-- Hidden state -->
                <asp:HiddenField ID="hdnPage"          runat="server" Value="1" />
                <asp:HiddenField ID="hdnSort"          runat="server" Value="newest" />
                <asp:HiddenField ID="hdnSearch"        runat="server" Value="" />
                <asp:HiddenField ID="hdnPostID"        runat="server" Value="0" />
                <asp:HiddenField ID="hdnEditCommentID" runat="server" Value="0" />

                <!-- ======================== POST DETAIL VIEW ======================== -->
                <asp:Panel ID="pnlPostDetail" runat="server" Visible="false">
                    <div class="ms-card p-4 mb-3">

                        <asp:Button ID="btnBackToList" runat="server"
                            Text="&#8592; Back to Discussions"
                            CssClass="btn btn-sm btn-outline-secondary mb-3"
                            CausesValidation="false" OnClick="btnBackToList_Click" />

                        <!-- Resolved / Closed banner -->
                        <asp:Literal ID="litResolvedBadge" runat="server" />

                        <!-- Post title & meta -->
                        <h4 class="fw-bold mb-1"><asp:Literal ID="litPostTitle" runat="server" /></h4>
                        <div class="d-flex gap-3 text-muted small mb-3 flex-wrap">
                            <span><i class="fas fa-user me-1"></i><asp:Literal ID="litPostAuthor" runat="server" /></span>
                            <span><i class="fas fa-calendar me-1"></i><asp:Literal ID="litPostDate" runat="server" /></span>
                            <span><i class="fas fa-eye me-1"></i><asp:Literal ID="litPostViews" runat="server" /> views</span>
                            <asp:Literal ID="litEditedLabel" runat="server" />
                        </div>

                        <div class="post-content mb-4">
                            <asp:Literal ID="litPostContent" runat="server" />
                        </div>

                        <!-- Post owner actions -->
                        <asp:Panel ID="pnlPostOwnerActions" runat="server" Visible="false">
                            <div class="d-flex gap-2 mb-3 flex-wrap">
                                <asp:Button ID="btnEditPost" runat="server" Text="&#9998; Edit Post"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CausesValidation="false" OnClick="btnEditPost_Click" />
                                <asp:Button ID="btnDeletePost" runat="server" Text="&#128465; Delete Post"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CausesValidation="false" OnClick="btnDeletePost_Click"
                                    OnClientClick="return confirm('Delete this discussion? This cannot be undone.');" />
                                <asp:Button ID="btnToggleResolved" runat="server"
                                    CssClass="btn btn-sm btn-outline-success"
                                    CausesValidation="false" OnClick="btnToggleResolved_Click" />
                            </div>
                        </asp:Panel>

                        <!-- Edit post inline form -->
                        <asp:Panel ID="pnlEditPost" runat="server" Visible="false">
                            <div class="p-3 mb-4 rounded" style="background:rgba(108,92,231,0.05);border:1px solid var(--ms-border);">
                                <h6 class="fw-semibold mb-3">&#9998; Edit Discussion</h6>
                                <div class="mb-2">
                                    <label class="form-label small fw-semibold">Title <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtEditTitle" runat="server" CssClass="form-control" MaxLength="200" />
                                    <asp:RequiredFieldValidator ID="rfvEditTitle" runat="server"
                                        ControlToValidate="txtEditTitle" ErrorMessage="Title is required."
                                        CssClass="validation-error" Display="Dynamic" ValidationGroup="EditPost" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-semibold">Content <span class="text-danger">*</span></label>
                                    <div class="rich-toolbar mb-1">
                                        <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtEditContent" data-fmt="bold" title="Bold"><b>B</b></button>
                                        <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtEditContent" data-fmt="italic" title="Italic"><i>I</i></button>
                                        <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtEditContent" data-fmt="link" title="Link">&#128279; Link</button>
                                    </div>
                                    <asp:TextBox ID="txtEditContent" runat="server" TextMode="MultiLine" Rows="5"
                                        CssClass="form-control" MaxLength="3000" />
                                    <asp:RequiredFieldValidator ID="rfvEditContent" runat="server"
                                        ControlToValidate="txtEditContent" ErrorMessage="Content is required."
                                        CssClass="validation-error" Display="Dynamic" ValidationGroup="EditPost" />
                                </div>
                                <div class="d-flex gap-2">
                                    <asp:Button ID="btnSaveEdit" runat="server" Text="Save Changes"
                                        CssClass="btn btn-primary btn-sm" ValidationGroup="EditPost"
                                        OnClick="btnSaveEdit_Click" />
                                    <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel"
                                        CssClass="btn btn-secondary btn-sm"
                                        CausesValidation="false" OnClick="btnCancelEdit_Click" />
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- Comments / Replies -->
                        <h6 class="fw-bold border-top pt-3 mb-3">
                            <i class="fas fa-reply me-2"></i>Replies
                            (<asp:Literal ID="litCommentCount" runat="server">0</asp:Literal>)
                        </h6>

                        <asp:Repeater ID="rptComments" runat="server" OnItemCommand="rptComments_ItemCommand">
                            <ItemTemplate>
                                <div class="comment-item">
                                    <div class="d-flex justify-content-between align-items-start mb-1 flex-wrap gap-1">
                                        <span class="fw-semibold small">
                                            <i class="fas fa-user-circle me-1 text-primary"></i><%# System.Web.HttpUtility.HtmlEncode(Eval("FullName").ToString()) %>
                                        </span>
                                        <div class="d-flex align-items-center gap-2">
                                            <span class="text-muted" style="font-size:0.72rem;">
                                                <%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy, HH:mm") %>
                                            </span>
                                            <%# (bool)Eval("IsEdited") ? "<span class=\"badge bg-light text-muted border\" style=\"font-size:0.65rem;\">edited</span>" : "" %>
                                        </div>
                                    </div>
                                    <div class="comment-content mb-2"><%# Eval("ContentHtml") %></div>
                                    <div class="d-flex gap-2 flex-wrap">
                                        <asp:Literal ID="litQuoteBtn" runat="server"
                                            Text='<%# GetQuoteBtn(Eval("FullName").ToString(), Eval("Content").ToString()) %>' />
                                        <asp:Panel ID="pnlCommentOwner" runat="server"
                                            Visible='<%# (bool)Eval("IsOwner") %>'>
                                            <asp:LinkButton ID="lbtnEditComment" runat="server"
                                                CommandName="EditComment"
                                                CommandArgument='<%# Eval("CommentID") %>'
                                                CssClass="btn btn-xs btn-outline-primary"
                                                CausesValidation="false">&#9998; Edit</asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDeleteComment" runat="server"
                                                CommandName="DeleteComment"
                                                CommandArgument='<%# Eval("CommentID") %>'
                                                CssClass="btn btn-xs btn-outline-danger ms-1"
                                                CausesValidation="false"
                                                OnClientClick="return confirm('Delete this reply?');">&#128465; Delete</asp:LinkButton>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!-- Edit comment inline form -->
                        <asp:Panel ID="pnlEditComment" runat="server" Visible="false">
                            <div class="p-3 mb-3 rounded" style="background:rgba(0,184,148,0.06);border:1px solid #b2dfdb;">
                                <h6 class="fw-semibold mb-2">&#9998; Edit Reply</h6>
                                <div class="rich-toolbar mb-1">
                                    <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtEditComment" data-fmt="bold"><b>B</b></button>
                                    <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtEditComment" data-fmt="italic"><i>I</i></button>
                                    <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtEditComment" data-fmt="link">&#128279; Link</button>
                                </div>
                                <asp:TextBox ID="txtEditComment" runat="server" TextMode="MultiLine" Rows="3"
                                    CssClass="form-control mb-2" MaxLength="2000" />
                                <asp:RequiredFieldValidator ID="rfvEditComment" runat="server"
                                    ControlToValidate="txtEditComment" ErrorMessage="Reply cannot be empty."
                                    CssClass="validation-error" Display="Dynamic" ValidationGroup="EditComment" />
                                <div class="d-flex gap-2">
                                    <asp:Button ID="btnSaveEditComment" runat="server" Text="Save Reply"
                                        CssClass="btn btn-primary btn-sm" ValidationGroup="EditComment"
                                        OnClick="btnSaveEditComment_Click" />
                                    <asp:Button ID="btnCancelEditComment" runat="server" Text="Cancel"
                                        CssClass="btn btn-secondary btn-sm"
                                        CausesValidation="false" OnClick="btnCancelEditComment_Click" />
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- Add Reply -->
                        <asp:Panel ID="pnlAddComment" runat="server" Visible="false">
                            <div class="mt-3 p-3 rounded" style="background:rgba(108,92,231,0.05);border:1px solid var(--ms-border);">
                                <h6 class="fw-semibold mb-2"><i class="fas fa-comment me-2"></i>Add a Reply</h6>
                                <div class="rich-toolbar mb-1">
                                    <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtComment" data-fmt="bold"><b>B</b></button>
                                    <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtComment" data-fmt="italic"><i>I</i></button>
                                    <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtComment" data-fmt="link">&#128279; Link</button>
                                </div>
                                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="3"
                                    CssClass="form-control mb-2"
                                    placeholder="Share your thoughts, support, or advice..." MaxLength="2000" />
                                <asp:RequiredFieldValidator ID="rfvComment" runat="server"
                                    ControlToValidate="txtComment" ErrorMessage="Please enter a reply."
                                    CssClass="validation-error" Display="Dynamic" ValidationGroup="Comment" />
                                <asp:Button ID="btnAddComment" runat="server" Text="Post Reply"
                                    CssClass="btn btn-primary btn-sm" ValidationGroup="Comment"
                                    OnClick="btnAddComment_Click" />
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlLoginToReply" runat="server" Visible="false">
                            <div class="mt-3 p-3 rounded text-center" style="background:rgba(108,92,231,0.05);border:1px solid var(--ms-border);">
                                <i class="fas fa-lock me-1 text-muted"></i>
                                <a href="../Login.aspx" class="text-primary fw-semibold">Log in</a> to post a reply.
                            </div>
                        </asp:Panel>

                    </div>
                </asp:Panel>

                <!-- ======================== POSTS LIST VIEW ======================== -->
                <asp:Panel ID="pnlPostsList" runat="server">

                    <asp:Repeater ID="rptPosts" runat="server" OnItemCommand="rptPosts_ItemCommand">
                        <ItemTemplate>
                            <div class="forum-post-item">
                                <div class="d-flex justify-content-between align-items-start gap-2">
                                    <h6 class="forum-post-title mb-1" style="flex:1;">
                                        <asp:LinkButton ID="lbtnView" runat="server"
                                            CommandName="ViewPost"
                                            CommandArgument='<%# Eval("PostID") %>'
                                            CssClass="text-decoration-none"
                                            style="color:var(--ms-text);">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                        </asp:LinkButton>
                                    </h6>
                                    <%# (bool)Eval("IsResolved") ? "<span class=\"badge bg-success\"><i class=\"fas fa-check-circle me-1\"></i>Resolved</span>" : "" %>
                                </div>
                                <p class="small text-muted mb-2 post-excerpt">
                                    <%# System.Web.HttpUtility.HtmlEncode(Eval("PlainContent").ToString()) %>
                                </p>
                                <div class="forum-post-meta">
                                    <span><i class="fas fa-user me-1"></i><%# System.Web.HttpUtility.HtmlEncode(Eval("FullName").ToString()) %></span>
                                    <span><i class="fas fa-calendar me-1"></i><%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %></span>
                                    <span><i class="fas fa-comment me-1"></i><%# Eval("CommentCount") %> replies</span>
                                    <span><i class="fas fa-eye me-1"></i><%# Eval("ViewCount") %> views</span>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Panel ID="pnlEmpty" runat="server"
                                Visible='<%# rptPosts.Items.Count == 0 %>'>
                                <div class="text-center py-5 text-muted">
                                    <i class="fas fa-comments fa-3x mb-3 d-block" style="color:#ddd;"></i>
                                    <p class="mb-0">No discussions found. Be the first to start one!</p>
                                </div>
                            </asp:Panel>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- Pagination -->
                    <asp:Panel ID="pnlPagination" runat="server" Visible="false">
                        <div class="d-flex justify-content-between align-items-center mt-3 px-1">
                            <asp:Button ID="btnPrevPage" runat="server" Text="&#171; Previous"
                                CssClass="btn btn-outline-secondary btn-sm"
                                CausesValidation="false" OnClick="btnPrevPage_Click" />
                            <span class="small text-muted">
                                Page <strong><asp:Literal ID="litCurrentPage" runat="server" /></strong>
                                of <asp:Literal ID="litTotalPages" runat="server" />
                            </span>
                            <asp:Button ID="btnNextPage" runat="server" Text="Next &#187;"
                                CssClass="btn btn-outline-secondary btn-sm"
                                CausesValidation="false" OnClick="btnNextPage_Click" />
                        </div>
                    </asp:Panel>

                </asp:Panel>

            </div>

            <!-- ============================== RIGHT SIDEBAR ============================== -->
            <div class="col-lg-4">

                <!-- User profile card (logged in only) -->
                <asp:Panel ID="pnlProfile" runat="server" Visible="false">
                    <div class="ms-card p-4 mb-3 text-center">
                        <div class="rounded-circle mx-auto mb-2 d-flex align-items-center justify-content-center"
                             style="width:56px;height:56px;background:linear-gradient(135deg,#6C5CE7,#a29bfe);color:#fff;font-size:1.4rem;">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="fw-bold fs-6"><asp:Literal ID="litProfileName" runat="server" /></div>
                        <div class="text-muted small mb-3">@<asp:Literal ID="litProfileUsername" runat="server" /></div>
                        <div class="row text-center g-0">
                            <div class="col-6 border-end">
                                <div class="fw-bold text-primary fs-5"><asp:Literal ID="litProfilePostCount" runat="server" /></div>
                                <div class="small text-muted">Posts</div>
                            </div>
                            <div class="col-6">
                                <div class="fw-bold text-primary" style="font-size:0.85rem;"><asp:Literal ID="litProfileJoinDate" runat="server" /></div>
                                <div class="small text-muted">Joined</div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>

                <!-- Create discussion form (logged in only) -->
                <asp:Panel ID="pnlCreatePost" runat="server" Visible="false">
                    <div class="ms-card p-4 mb-3">
                        <h6 class="fw-bold mb-3">
                            <i class="fas fa-pen me-2 text-primary"></i>Start a Discussion
                        </h6>
                        <div class="mb-2">
                            <label class="form-label">Title <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control"
                                placeholder="What's on your mind?" MaxLength="200" />
                            <asp:RequiredFieldValidator ID="rfvPostTitle" runat="server"
                                ControlToValidate="txtPostTitle" ErrorMessage="Title is required."
                                CssClass="validation-error" Display="Dynamic" ValidationGroup="NewPost" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Message <span class="text-danger">*</span></label>
                            <div class="rich-toolbar mb-1">
                                <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtPostContent" data-fmt="bold" title="Bold"><b>B</b></button>
                                <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtPostContent" data-fmt="italic" title="Italic"><i>I</i></button>
                                <button type="button" class="btn btn-xs btn-outline-secondary" data-target="txtPostContent" data-fmt="link" title="Link">&#128279; Link</button>
                            </div>
                            <asp:TextBox ID="txtPostContent" runat="server" TextMode="MultiLine" Rows="5"
                                CssClass="form-control"
                                placeholder="Share your experience, ask a question, or offer advice..."
                                MaxLength="3000" />
                            <asp:RequiredFieldValidator ID="rfvPostContent" runat="server"
                                ControlToValidate="txtPostContent" ErrorMessage="Message is required."
                                CssClass="validation-error" Display="Dynamic" ValidationGroup="NewPost" />
                        </div>
                        <asp:Button ID="btnCreatePost" runat="server" Text="Post Discussion"
                            CssClass="btn btn-primary btn-full" ValidationGroup="NewPost"
                            OnClick="btnCreatePost_Click" />
                    </div>
                </asp:Panel>

                <!-- Guest prompt -->
                <asp:Panel ID="pnlGuestPrompt" runat="server" Visible="false">
                    <div class="ms-card p-4 mb-3 text-center">
                        <i class="fas fa-lock fa-2x mb-2 text-muted d-block"></i>
                        <p class="small text-muted mb-2">Log in to post discussions and join the community.</p>
                        <a href="../Login.aspx" class="btn btn-primary btn-sm">Login to Participate</a>
                    </div>
                </asp:Panel>

                <!-- Guidelines -->
                <div class="ms-card p-4">
                    <h6 class="fw-bold mb-2">
                        <i class="fas fa-heart me-2 text-danger"></i>Community Guidelines
                    </h6>
                    <ul class="small text-muted mb-0 ps-3">
                        <li class="mb-1">Be kind and supportive to fellow members</li>
                        <li class="mb-1">Share evidence-based information when possible</li>
                        <li class="mb-1">Respect privacy and confidentiality</li>
                        <li class="mb-1">Avoid giving medical diagnoses</li>
                        <li>In crisis? Contact a mental health professional</li>
                    </ul>
                </div>

            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
(function () {
    // Find a textarea by its control-name suffix (handles ASP.NET naming containers)
    function findTextarea(name) {
        return document.getElementById(name)
            || document.querySelector('[id$="' + name + '"]');
    }

    function applyFmt(ta, fmt) {
        if (!ta) return;
        var s = ta.selectionStart, e = ta.selectionEnd;
        var sel = ta.value.substring(s, e);
        var tag = fmt === 'bold' ? 'b' : 'i';
        var result = '<' + tag + '>' + sel + '</' + tag + '>';
        ta.value = ta.value.substring(0, s) + result + ta.value.substring(e);
        ta.focus();
        ta.selectionStart = ta.selectionEnd = s + result.length;
    }

    function applyLink(ta) {
        if (!ta) return;
        var url = prompt('Enter URL (must start with https:// or http://):');
        if (!url || !/^https?:\/\//i.test(url)) return;
        var s = ta.selectionStart, e = ta.selectionEnd;
        var label = ta.value.substring(s, e) || url;
        var result = '<a href="' + url + '">' + label + '</a>';
        ta.value = ta.value.substring(0, s) + result + ta.value.substring(e);
        ta.focus();
    }

    document.addEventListener('click', function (ev) {
        var btn = ev.target.closest('[data-fmt]');
        if (!btn) return;
        ev.preventDefault();
        var target = btn.getAttribute('data-target');
        var fmt    = btn.getAttribute('data-fmt');
        var ta     = findTextarea(target);
        if (!ta) return;
        if (fmt === 'link') applyLink(ta);
        else applyFmt(ta, fmt);
    });

    // Quote a comment into the reply textarea
    window.quoteComment = function (author, rawContent) {
        var ta = findTextarea('txtComment');
        if (!ta) return;
        // strip HTML for clean quote text
        var tmp = document.createElement('div');
        tmp.innerHTML = rawContent;
        var plain = (tmp.textContent || tmp.innerText || '').trim();
        var quote = '<blockquote><strong>' + author + '</strong>: ' + plain + '</blockquote>\n';
        ta.value = quote + ta.value;
        ta.focus();
        ta.scrollIntoView({ behavior: 'smooth', block: 'center' });
    };
}());
</script>
</asp:Content>
