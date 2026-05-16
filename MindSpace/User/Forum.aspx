<%@ Page Title="Discussion Forum" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Forum.aspx.cs" Inherits="MindSpace.ForumPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-comments me-2"></i>Community Forum</h1>
            <p>Share experiences, ask questions, and support each other's mental wellness journey</p>
        </div>
    </div>

    <div class="container py-4">

        <asp:Panel ID="pnlMsg" runat="server" Visible="false">
            <div class="alert-ms-success alert-auto-dismiss mb-3">
                <i class="fas fa-check-circle me-2"></i>
                <asp:Literal ID="litMsg" runat="server" />
            </div>
        </asp:Panel>

        <div class="row g-4">

            <!-- POSTS LIST -->
            <div class="col-lg-8">

                <!-- Search & Filter -->
                <div class="d-flex gap-2 mb-3 flex-wrap">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search discussions..." style="flex:1;min-width:200px;" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary"
                        CausesValidation="false" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                        CausesValidation="false" OnClick="btnClear_Click" />
                </div>

                <!-- Post Detail View -->
                <asp:Panel ID="pnlPostDetail" runat="server" Visible="false">
                    <div class="ms-card p-4 mb-3">
                        <asp:Button ID="btnBackToList" runat="server" Text="← Back to Discussions"
                            CssClass="btn btn-sm btn-outline-secondary mb-3"
                            CausesValidation="false" OnClick="btnBackToList_Click" />

                        <div class="mb-3">
                            <h4 class="fw-bold"><asp:Literal ID="litPostTitle" runat="server" /></h4>
                            <div class="d-flex gap-3 text-muted small mb-3">
                                <span><i class="fas fa-user me-1"></i><asp:Literal ID="litPostAuthor" runat="server" /></span>
                                <span><i class="fas fa-calendar me-1"></i><asp:Literal ID="litPostDate" runat="server" /></span>
                            </div>
                            <div style="line-height:1.8;"><asp:Literal ID="litPostContent" runat="server" /></div>
                        </div>

                        <!-- COMMENTS -->
                        <h6 class="fw-bold border-top pt-3 mb-3">
                            <i class="fas fa-reply me-2"></i>Replies
                            (<asp:Literal ID="litCommentCount" runat="server">0</asp:Literal>)
                        </h6>

                        <asp:Repeater ID="rptComments" runat="server">
                            <ItemTemplate>
                                <div class="comment-item">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="fw-semibold small"><%# Eval("FullName") %></span>
                                        <span class="text-muted" style="font-size:0.75rem;">
                                            <%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy, HH:mm") %>
                                        </span>
                                    </div>
                                    <p class="mb-0 small"><%# Eval("Content") %></p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!-- Add Comment (logged in only) -->
                        <asp:Panel ID="pnlAddComment" runat="server">
                            <div class="mt-3 p-3 rounded" style="background:rgba(108,92,231,0.05);border:1px solid var(--ms-border);">
                                <h6 class="fw-semibold mb-2"><i class="fas fa-comment me-2"></i>Add a Reply</h6>
                                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="3"
                                    CssClass="form-control mb-2"
                                    placeholder="Share your thoughts, support, or advice..." MaxLength="1000" />
                                <asp:RequiredFieldValidator ID="rfvComment" runat="server"
                                    ControlToValidate="txtComment" ErrorMessage="Please enter a reply."
                                    CssClass="validation-error" Display="Dynamic" />
                                <asp:HiddenField ID="hdnPostID" runat="server" />
                                <asp:Button ID="btnAddComment" runat="server" Text="Post Reply"
                                    CssClass="btn btn-primary btn-sm" OnClick="btnAddComment_Click" />
                            </div>
                        </asp:Panel>

                    </div>
                </asp:Panel>

                <!-- Posts List View -->
                <asp:Panel ID="pnlPostsList" runat="server">
                    <asp:Repeater ID="rptPosts" runat="server" OnItemCommand="rptPosts_ItemCommand">
                        <ItemTemplate>
                            <div class="forum-post-item">
                                <div class="d-flex justify-content-between">
                                    <h6 class="forum-post-title mb-1">
                                        <asp:LinkButton ID="lbtnView" runat="server" CommandName="ViewPost"
                                            CommandArgument='<%# Eval("PostID") %>'
                                            CssClass="text-decoration-none text-dark">
                                            <%# Eval("Title") %>
                                        </asp:LinkButton>
                                    </h6>
                                </div>
                                <p class="small text-muted mb-2" style="display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;">
                                    <%# Eval("Content") %>
                                </p>
                                <div class="forum-post-meta">
                                    <span><i class="fas fa-user me-1"></i><%# Eval("FullName") %></span>
                                    <span><i class="fas fa-calendar me-1"></i><%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %></span>
                                    <span><i class="fas fa-comment me-1"></i><%# Eval("CommentCount") %> replies</span>
                                    <span><i class="fas fa-eye me-1"></i><%# Eval("ViewCount") %> views</span>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Panel ID="pnlEmpty" runat="server" Visible='<%# rptPosts.Items.Count == 0 %>'>
                                <div class="text-center py-5 text-muted">
                                    <i class="fas fa-comments fa-3x mb-3 d-block" style="color:#ddd;"></i>
                                    <p>No discussions yet. Be the first to start one!</p>
                                </div>
                            </asp:Panel>
                        </FooterTemplate>
                    </asp:Repeater>
                </asp:Panel>

            </div>

            <!-- SIDEBAR: Create Post -->
            <div class="col-lg-4">

                <!-- New Post Form -->
                <asp:Panel ID="pnlCreatePost" runat="server">
                    <div class="ms-card p-4 mb-3">
                        <h6 class="fw-bold mb-3"><i class="fas fa-pen me-2 text-primary"></i>Start a Discussion</h6>
                        <div class="mb-2">
                            <label class="form-label">Title <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control"
                                placeholder="What's on your mind?" MaxLength="200" />
                            <asp:RequiredFieldValidator ID="rfvPostTitle" runat="server"
                                ControlToValidate="txtPostTitle" ErrorMessage="Title is required."
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Message <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtPostContent" runat="server" TextMode="MultiLine" Rows="5"
                                CssClass="form-control"
                                placeholder="Share your experience, ask a question, or offer advice..." MaxLength="2000" />
                            <asp:RequiredFieldValidator ID="rfvPostContent" runat="server"
                                ControlToValidate="txtPostContent" ErrorMessage="Message is required."
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        <asp:Button ID="btnCreatePost" runat="server" Text="Post Discussion"
                            CssClass="btn btn-primary btn-full" OnClick="btnCreatePost_Click" />
                    </div>
                </asp:Panel>

                <!-- Guest prompt -->
                <asp:Panel ID="pnlGuestPrompt" runat="server" Visible="false">
                    <div class="ms-card p-4 mb-3 text-center">
                        <i class="fas fa-lock fa-2x mb-2 text-muted"></i>
                        <p class="small text-muted mb-2">Login to post discussions and join the community.</p>
                        <a href="../Login.aspx" class="btn btn-primary btn-sm">Login to Participate</a>
                    </div>
                </asp:Panel>

                <!-- Forum Guidelines -->
                <div class="ms-card p-4">
                    <h6 class="fw-bold mb-2"><i class="fas fa-heart me-2 text-danger"></i>Community Guidelines</h6>
                    <ul class="small text-muted mb-0">
                        <li class="mb-1">Be kind and supportive to fellow members</li>
                        <li class="mb-1">Share evidence-based information when possible</li>
                        <li class="mb-1">Respect privacy and confidentiality</li>
                        <li class="mb-1">Avoid giving medical diagnoses or prescriptions</li>
                        <li>In crisis? Contact a mental health professional</li>
                    </ul>
                </div>

            </div>
        </div>

    </div>
</asp:Content>
