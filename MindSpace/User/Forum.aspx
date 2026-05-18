<%@ Page Title="Discussion Forum" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forum.aspx.cs" Inherits="MindSpace.ForumPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="mb-4">
        <h3 style="font-family: var(--font-heading); font-weight: 700;">Community Forum</h3>
        <p class="text-muted mb-0" style="font-size: var(--text-sm);">Share experiences, ask questions, and support each other&rsquo;s wellness journey.</p>
    </div>

    <asp:Panel ID="pnlMsg" runat="server" Visible="false">
        <div class="alert-ms-success mb-3">
            <i class="fa-solid fa-circle-check me-2"></i>
            <asp:Literal ID="litMsg" runat="server" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlError" runat="server" Visible="false">
        <div class="alert-ms-error mb-3">
            <i class="fa-solid fa-circle-exclamation me-2"></i>
            <asp:Literal ID="litError" runat="server" />
        </div>
    </asp:Panel>

    <div class="row g-4">

        <!-- POSTS COLUMN -->
        <div class="col-lg-8">

            <!-- Search, Sort -->
            <div class="card p-3 mb-3">
                <div class="d-flex gap-2 flex-wrap align-items-center">
                    <div class="input-group" style="flex: 1; min-width: 200px;">
                        <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0" placeholder="Search discussions..." />
                    </div>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary"
                        CausesValidation="false" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                        CausesValidation="false" OnClick="btnClear_Click" />
                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-select" style="width: auto;"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                        <asp:ListItem Value="newest" Text="Newest First" />
                        <asp:ListItem Value="replies" Text="Most Replies" />
                        <asp:ListItem Value="views" Text="Most Views" />
                    </asp:DropDownList>
                </div>
            </div>

            <asp:HiddenField ID="hdnPage" runat="server" Value="1" />
            <asp:HiddenField ID="hdnSort" runat="server" Value="newest" />
            <asp:HiddenField ID="hdnSearch" runat="server" Value="" />
            <asp:HiddenField ID="hdnPostID" runat="server" />
            <asp:HiddenField ID="hdnEditPostID" runat="server" />

            <!-- ============ POST DETAIL VIEW ============ -->
            <asp:Panel ID="pnlPostDetail" runat="server" Visible="false">
                <div class="card p-4 mb-3">
                    <asp:Button ID="btnBackToList" runat="server" Text="&larr; Back to Discussions"
                        CssClass="btn btn-sm btn-outline-secondary mb-3"
                        CausesValidation="false" OnClick="btnBackToList_Click" />

                    <asp:Literal ID="litResolvedBadge" runat="server" />

                    <h4 class="fw-bold" style="font-family: var(--font-heading);">
                        <asp:Literal ID="litPostTitle" runat="server" />
                    </h4>
                    <div class="d-flex gap-3 text-muted small mb-3 flex-wrap" style="font-size: 0.75rem;">
                        <span><i class="fa-regular fa-user me-1"></i><asp:Literal ID="litPostAuthor" runat="server" /></span>
                        <span><i class="fa-regular fa-calendar me-1"></i><asp:Literal ID="litPostDate" runat="server" /></span>
                    </div>

                    <div style="line-height: 1.8;" class="mb-3">
                        <asp:Literal ID="litPostContent" runat="server" />
                    </div>

                    <asp:Panel ID="pnlPostOwnerActions" runat="server" Visible="false">
                        <div class="d-flex gap-2 mb-3 flex-wrap">
                            <asp:Button ID="btnEditPost" runat="server" Text="Edit"
                                CssClass="btn btn-sm btn-outline-primary"
                                CausesValidation="false" OnClick="btnEditPost_Click" />
                            <asp:Button ID="btnDeletePost" runat="server" Text="Delete"
                                CssClass="btn btn-sm btn-outline-danger"
                                CausesValidation="false" OnClick="btnDeletePost_Click"
                                OnClientClick="return confirm('Delete this discussion?');" />
                            <asp:Button ID="btnMarkResolved" runat="server" Text="Mark Resolved"
                                CssClass="btn btn-sm btn-success"
                                CausesValidation="false" OnClick="btnMarkResolved_Click" />
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlEditPost" runat="server" Visible="false">
                        <div class="p-3 mb-3" style="background: var(--color-primary-light); border-radius: var(--radius-md);">
                            <h6 class="fw-semibold mb-2">Edit Discussion</h6>
                            <div class="mb-2">
                                <label class="form-label">Title</label>
                                <asp:TextBox ID="txtEditTitle" runat="server" CssClass="form-control" MaxLength="200" />
                                <asp:RequiredFieldValidator ID="rfvEditTitle" runat="server"
                                    ControlToValidate="txtEditTitle" ErrorMessage="Title is required."
                                    CssClass="validation-error" Display="Dynamic" ValidationGroup="EditPost" />
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Message</label>
                                <asp:TextBox ID="txtEditContent" runat="server" TextMode="MultiLine" Rows="5"
                                    CssClass="form-control" MaxLength="2000" />
                                <asp:RequiredFieldValidator ID="rfvEditContent" runat="server"
                                    ControlToValidate="txtEditContent" ErrorMessage="Message is required."
                                    CssClass="validation-error" Display="Dynamic" ValidationGroup="EditPost" />
                            </div>
                            <div class="d-flex gap-2">
                                <asp:Button ID="btnSaveEdit" runat="server" Text="Save Changes"
                                    CssClass="btn btn-primary btn-sm" ValidationGroup="EditPost"
                                    OnClick="btnSaveEdit_Click" />
                                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel"
                                    CssClass="btn btn-outline-secondary btn-sm"
                                    CausesValidation="false" OnClick="btnCancelEdit_Click" />
                            </div>
                        </div>
                    </asp:Panel>

                    <h6 class="fw-bold pt-3 mb-3" style="border-top: 1px solid var(--color-card-border);">
                        <i class="fa-solid fa-reply me-2"></i>Replies
                        (<asp:Literal ID="litCommentCount" runat="server">0</asp:Literal>)
                    </h6>

                    <asp:Repeater ID="rptComments" runat="server">
                        <ItemTemplate>
                            <div class="comment-item">
                                <div class="d-flex justify-content-between mb-1 flex-wrap gap-2">
                                    <span class="fw-semibold small">
                                        <i class="fa-solid fa-user-circle me-1" style="color: var(--color-primary);"></i>
                                        <%# Eval("FullName") %>
                                    </span>
                                    <span class="text-muted" style="font-size: 0.72rem;">
                                        <%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy, HH:mm") %>
                                    </span>
                                </div>
                                <p class="comment-content mb-0"><%# System.Web.HttpUtility.HtmlEncode(Eval("Content").ToString()) %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlAddComment" runat="server">
                        <div class="mt-3 p-3" style="background: var(--color-primary-light); border-radius: var(--radius-md);">
                            <h6 class="fw-semibold mb-2"><i class="fa-regular fa-comment me-2"></i>Add a Reply</h6>
                            <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="3"
                                CssClass="form-control mb-2"
                                placeholder="Share your thoughts, support, or advice..." MaxLength="1000" />
                            <asp:RequiredFieldValidator ID="rfvComment" runat="server"
                                ControlToValidate="txtComment" ErrorMessage="Please enter a reply."
                                CssClass="validation-error" Display="Dynamic" ValidationGroup="Comment" />
                            <asp:Button ID="btnAddComment" runat="server" Text="Post Reply"
                                CssClass="btn btn-primary btn-sm" ValidationGroup="Comment"
                                OnClick="btnAddComment_Click" />
                        </div>
                    </asp:Panel>
                </div>
            </asp:Panel>

            <!-- ============ POSTS LIST VIEW ============ -->
            <asp:Panel ID="pnlPostsList" runat="server">
                <asp:Repeater ID="rptPosts" runat="server" OnItemCommand="rptPosts_ItemCommand">
                    <ItemTemplate>
                        <div class="forum-post-item">
                            <div class="d-flex justify-content-between align-items-start gap-2">
                                <div style="flex: 1; min-width: 0;">
                                    <h6 class="forum-post-title mb-1">
                                        <asp:LinkButton ID="lbtnView" runat="server" CommandName="ViewPost"
                                            CommandArgument='<%# Eval("PostID") %>'>
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                        </asp:LinkButton>
                                    </h6>
                                    <p class="small text-muted mb-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Content").ToString()) %>
                                    </p>
                                    <div class="forum-post-meta">
                                        <span><i class="fa-regular fa-user me-1"></i><%# System.Web.HttpUtility.HtmlEncode(Eval("FullName").ToString()) %></span>
                                        <span><i class="fa-regular fa-calendar me-1"></i><%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %></span>
                                        <span><i class="fa-regular fa-comment me-1"></i><%# Eval("CommentCount") %> replies</span>
                                        <span><i class="fa-regular fa-eye me-1"></i><%# Eval("ViewCount") %> views</span>
                                    </div>
                                </div>
                                <%# (bool)Eval("IsResolved") ? "<span class='badge bg-success'><i class='fa-solid fa-check me-1'></i>Resolved</span>" : "" %>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Panel ID="pnlEmpty" runat="server" Visible='<%# rptPosts.Items.Count == 0 %>'>
                            <div class="card p-5 text-center text-muted">
                                <i class="fa-regular fa-comments fa-3x mb-3" style="color: #E5E7EB;"></i>
                                <p>No discussions yet. Be the first to start one!</p>
                            </div>
                        </asp:Panel>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlPagination" runat="server" Visible="false">
                    <div class="d-flex justify-content-between align-items-center mt-3">
                        <asp:Button ID="btnPrevPage" runat="server" Text="&laquo; Previous"
                            CssClass="btn btn-outline-secondary btn-sm"
                            CausesValidation="false" OnClick="btnPrevPage_Click" />
                        <span class="small text-muted">
                            Page <asp:Literal ID="litCurrentPage" runat="server" /> of <asp:Literal ID="litTotalPages" runat="server" />
                        </span>
                        <asp:Button ID="btnNextPage" runat="server" Text="Next &raquo;"
                            CssClass="btn btn-outline-secondary btn-sm"
                            CausesValidation="false" OnClick="btnNextPage_Click" />
                    </div>
                </asp:Panel>
            </asp:Panel>
        </div>

        <!-- SIDEBAR -->
        <div class="col-lg-4">

            <asp:Panel ID="pnlProfile" runat="server" Visible="false">
                <div class="card p-4 mb-3 text-center">
                    <div class="avatar-lg" style="width: 60px; height: 60px; font-size: 1.4rem;">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <div class="fw-bold"><asp:Literal ID="litProfileName" runat="server" /></div>
                    <div class="text-muted small mb-3">@<asp:Literal ID="litProfileUsername" runat="server" /></div>
                    <div class="row text-center g-0">
                        <div class="col-6" style="border-right: 1px solid var(--color-card-border);">
                            <div class="fw-bold" style="color: var(--color-primary); font-size: 1.25rem;"><asp:Literal ID="litProfilePostCount" runat="server" /></div>
                            <div class="small text-muted">Posts</div>
                        </div>
                        <div class="col-6">
                            <div class="fw-bold" style="color: var(--color-primary); font-size: 0.85rem;"><asp:Literal ID="litProfileJoinDate" runat="server" /></div>
                            <div class="small text-muted">Joined</div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlCreatePost" runat="server">
                <div class="card p-4 mb-3">
                    <h6 class="fw-bold mb-3"><i class="fa-solid fa-pen me-2" style="color: var(--color-primary);"></i>Start a Discussion</h6>
                    <div class="mb-2">
                        <label class="form-label">Title <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control"
                            placeholder="What&rsquo;s on your mind?" MaxLength="200" />
                        <asp:RequiredFieldValidator ID="rfvPostTitle" runat="server"
                            ControlToValidate="txtPostTitle" ErrorMessage="Title is required."
                            CssClass="validation-error" Display="Dynamic" ValidationGroup="NewPost" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Message <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtPostContent" runat="server" TextMode="MultiLine" Rows="4"
                            CssClass="form-control"
                            placeholder="Share your experience, ask a question, or offer advice..." MaxLength="2000" />
                        <asp:RequiredFieldValidator ID="rfvPostContent" runat="server"
                            ControlToValidate="txtPostContent" ErrorMessage="Message is required."
                            CssClass="validation-error" Display="Dynamic" ValidationGroup="NewPost" />
                    </div>
                    <asp:Button ID="btnCreatePost" runat="server" Text="Post Discussion"
                        CssClass="btn btn-primary btn-full" ValidationGroup="NewPost"
                        OnClick="btnCreatePost_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlGuestPrompt" runat="server" Visible="false">
                <div class="card p-4 mb-3 text-center">
                    <i class="fa-solid fa-lock fa-2x mb-2 text-muted"></i>
                    <p class="small text-muted mb-2">Login to post discussions and join the community.</p>
                    <a href="../Login.aspx" class="btn btn-primary btn-sm">Login to Participate</a>
                </div>
            </asp:Panel>

            <div class="card p-4">
                <h6 class="fw-bold mb-2"><i class="fa-solid fa-heart me-2" style="color: var(--color-danger);"></i>Community Guidelines</h6>
                <ul class="small text-muted mb-0" style="padding-left: 20px;">
                    <li>Be kind and supportive to fellow members</li>
                    <li>Share evidence-based information when possible</li>
                    <li>Respect privacy and confidentiality</li>
                    <li>Avoid giving medical diagnoses</li>
                    <li>In crisis? Contact a mental health professional</li>
                </ul>
            </div>

        </div>
    </div>

</asp:Content>
