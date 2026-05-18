<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="MindSpace.UserHome" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== GREETING BANNER ===== -->
    <div class="dash-banner">
        <div class="row align-items-center g-3">
            <div class="col d-flex align-items-center gap-3">
                <div class="dash-avatar">
                    <asp:Literal ID="litAvatarInitial" runat="server" />
                </div>
                <div>
                    <h2>Good day, <asp:Literal ID="litWelcome" runat="server" />.</h2>
                    <p>Continue your wellness journey &mdash; member since <asp:Literal ID="litMemberSince" runat="server" />.</p>
                </div>
            </div>
            <div class="col-auto">
                <a href="../Courses/CourseList.aspx" class="btn btn-light">
                    <i class="fa-solid fa-plus me-1"></i>Explore Courses
                </a>
            </div>
        </div>
    </div>

    <!-- ===== QUICK STATS STRIP (4 cards) ===== -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fa-solid fa-book-open"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litEnrolled" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Enrolled</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-icon green"><i class="fa-solid fa-check-circle"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litCompleted" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Completed</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fa-solid fa-clipboard-check"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litQuizzesTaken" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Quizzes</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fa-solid fa-comments"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litForumPosts" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Forum Posts</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <!-- ===== LEFT COLUMN ===== -->
        <div class="col-lg-8">

            <!-- MY COURSES -->
            <div class="section-header">
                <h6 class="fw-bold mb-0">My Courses</h6>
                <a href="../Courses/CourseList.aspx" style="font-size: var(--text-sm); color: var(--color-primary);">View all &rarr;</a>
            </div>

            <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                <div class="card p-4 text-center text-muted">
                    <i class="fa-solid fa-book fa-3x mb-3" style="color: #E5E7EB;"></i>
                    <p class="mb-3">You haven&rsquo;t enrolled in any courses yet.</p>
                    <a href="../Courses/CourseList.aspx" class="btn btn-primary btn-sm">Browse Courses</a>
                </div>
            </asp:Panel>

            <asp:Repeater ID="rptEnrolled" runat="server">
                <ItemTemplate>
                    <div class="enrolled-course-item">
                        <div class="d-flex align-items-center gap-3">
                            <div class="rounded-2 d-flex align-items-center justify-content-center"
                                 style="width: 48px; height: 48px; background: var(--color-primary-light); color: var(--color-primary); font-size: 1.25rem; flex-shrink: 0; border-radius: var(--radius-md);">
                                <i class="fa-solid fa-brain"></i>
                            </div>
                            <div style="flex: 1; min-width: 0;">
                                <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                                    <span class="course-cat-badge cat-<%# Eval("Category").ToString().ToLower() == "self-care" ? "selfcare" : GetCatClass(Eval("Category").ToString()) %>">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                    </span>
                                    <%# Convert.ToBoolean(Eval("IsCompleted"))
                                        ? "<span class='badge bg-success'>Completed</span>"
                                        : "" %>
                                </div>
                                <div class="fw-semibold" style="font-size: var(--text-sm);">
                                    <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" style="color: var(--color-text-primary);">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                    </a>
                                </div>
                                <div class="text-muted mt-1" style="font-size: 0.72rem;">Progress: <%# Eval("Progress") %>%</div>
                                <div class="progress mt-1" style="height: 4px;">
                                    <div class="progress-bar" style="width: <%# Eval("Progress") %>%;"></div>
                                </div>
                            </div>
                            <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>"
                               class="btn btn-sm btn-outline-primary">
                                <%# Convert.ToBoolean(Eval("IsCompleted")) ? "Review" : "Continue" %>
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- CERTIFICATES -->
            <asp:Panel ID="pnlCertificates" runat="server" Visible="false">
                <div class="section-header mt-4">
                    <h6 class="fw-bold mb-0"><i class="fa-solid fa-award me-2" style="color: var(--color-warning);"></i>My Certificates</h6>
                    <span class="text-muted" style="font-size: var(--text-sm);"><asp:Literal ID="litCertCount" runat="server" /> earned</span>
                </div>
                <div class="row g-3">
                    <asp:Repeater ID="rptCertificates" runat="server">
                        <ItemTemplate>
                            <div class="col-md-6">
                                <div class="certificate-card">
                                    <div class="cert-icon">
                                        <i class="fa-solid fa-award"></i>
                                    </div>
                                    <div style="flex: 1; min-width: 0;">
                                        <div class="cert-title">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                        </div>
                                        <div class="cert-category">
                                            <span class="course-cat-badge cat-<%# Eval("Category").ToString().ToLower() == "self-care" ? "selfcare" : GetCatClass(Eval("Category").ToString()) %>" style="font-size: 0.65rem;">
                                                <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                            </span>
                                        </div>
                                        <div class="cert-date">
                                            <i class="fa-regular fa-calendar-check me-1"></i>
                                            <%# Convert.ToDateTime(Eval("EnrollDate")).ToString("dd MMM yyyy") %>
                                        </div>
                                        <div class="cert-number">CERT-<%# Eval("UserID") %>-<%# Eval("CourseID") %></div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </asp:Panel>

            <!-- DISCUSSION ACTIVITY -->
            <div class="section-header mt-4">
                <h6 class="fw-bold mb-0">Discussion Activity</h6>
                <a href="Discussions.aspx" style="font-size: var(--text-sm); color: var(--color-primary);">Visit forum &rarr;</a>
            </div>

            <div class="card p-3">
                <asp:Panel ID="pnlNoActivity" runat="server" Visible="false">
                    <div class="text-center py-3 text-muted small">
                        <i class="fa-regular fa-comment fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                        You haven&rsquo;t posted in the forum yet.
                        <a href="Discussions.aspx" class="d-block mt-1" style="color: var(--color-primary);">Join the discussion &rarr;</a>
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptActivity" runat="server">
                    <ItemTemplate>
                        <div class="activity-item">
                            <div class="activity-type-icon <%# Eval("ActivityType").ToString() %>">
                                <i class='fa-solid <%# Eval("ActivityType").ToString() == "post" ? "fa-pen" : "fa-reply" %>'></i>
                            </div>
                            <div class="activity-label">
                                <div class="activity-title">
                                    <a href="Discussions.aspx" style="color: var(--color-text-primary);">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Label").ToString()) %>
                                    </a>
                                </div>
                                <div class="activity-meta">
                                    <%# Eval("ActivityType").ToString() == "post"
                                        ? "<i class='fa-solid fa-pen me-1'></i>New discussion"
                                        : "<i class='fa-solid fa-reply me-1'></i>Reply in: " + System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("Context"))) %>
                                    &middot; <%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </div>

        <!-- ===== RIGHT COLUMN ===== -->
        <div class="col-lg-4">

            <!-- PROFILE CARD -->
            <div class="card p-4 mb-3 text-center">
                <div class="avatar-lg">
                    <asp:Literal ID="litProfileInitial" runat="server" />
                </div>
                <div class="fw-bold" style="font-size: var(--text-base);">
                    <asp:Literal ID="litProfileName" runat="server" />
                </div>
                <div class="text-muted small mb-2">@<asp:Literal ID="litProfileUsername" runat="server" /></div>
                <asp:Panel ID="pnlBio" runat="server" Visible="false">
                    <p class="profile-bio-preview mb-3">
                        <asp:Literal ID="litProfileBio" runat="server" />
                    </p>
                </asp:Panel>
                <div class="d-flex gap-2 justify-content-center">
                    <a href="Profile.aspx" class="btn btn-outline-primary btn-sm">
                        <i class="fa-solid fa-user-pen me-1"></i>Edit
                    </a>
                    <a href="../ChangePassword.aspx" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-key me-1"></i>Password
                    </a>
                </div>
            </div>

            <!-- ACHIEVEMENTS -->
            <div class="card p-4 mb-3">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-trophy me-2" style="color: var(--color-warning);"></i>Achievements</h6>
                <asp:Literal ID="litAchievements" runat="server" />
            </div>

            <!-- RECENT QUIZ RESULTS -->
            <div class="card p-3 mb-3">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-clipboard-check me-2" style="color: var(--color-primary);"></i>Recent Quiz Results</h6>

                <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false">
                    <div class="text-center py-3 text-muted small">
                        <i class="fa-solid fa-clipboard fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                        No quiz results yet.
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptQuizResults" runat="server">
                    <ItemTemplate>
                        <div class="d-flex justify-content-between align-items-center py-2" style="border-bottom: 1px solid var(--color-card-border);">
                            <div style="flex: 1; min-width: 0;">
                                <div class="fw-semibold small text-truncate">
                                    <%# System.Web.HttpUtility.HtmlEncode(Eval("QuizTitle").ToString()) %>
                                </div>
                                <div class="text-muted" style="font-size: 0.7rem;">
                                    <%# Convert.ToDateTime(Eval("DateTaken")).ToString("dd MMM yyyy") %>
                                </div>
                            </div>
                            <div class="text-end">
                                <div class="fw-bold small <%# Convert.ToDecimal(Eval("Percentage")) >= 70 ? "text-success" : "text-danger" %>">
                                    <%# Eval("Score") %>/<%# Eval("TotalQuestions") %>
                                </div>
                                <small class="<%# Convert.ToDecimal(Eval("Percentage")) >= 70 ? "text-success" : "text-danger" %>" style="font-size: 0.7rem;">
                                    <%# string.Format("{0:0}%", Eval("Percentage")) %>
                                </small>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- QUICK ACTIONS -->
            <div class="card p-3">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-bolt me-2" style="color: var(--color-warning);"></i>Quick Actions</h6>
                <div class="d-grid gap-2">
                    <a href="ProgressTracking.aspx" class="btn btn-primary btn-sm text-start">
                        <i class="fa-solid fa-chart-line me-2"></i>My Progress
                    </a>
                    <a href="../Courses/CourseList.aspx" class="btn btn-outline-primary btn-sm text-start">
                        <i class="fa-solid fa-book-open me-2"></i>Browse Courses
                    </a>
                    <a href="Discussions.aspx" class="btn btn-outline-primary btn-sm text-start">
                        <i class="fa-regular fa-comments me-2"></i>Discussions
                    </a>
                    <a href="Profile.aspx" class="btn btn-outline-secondary btn-sm text-start">
                        <i class="fa-solid fa-user-pen me-2"></i>Edit Profile
                    </a>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
