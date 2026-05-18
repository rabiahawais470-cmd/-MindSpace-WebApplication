<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="MindSpace.UserHome" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== WELCOME BANNER ===== -->
    <div class="dash-banner">
        <div class="container position-relative" style="z-index:2;">
            <div class="row align-items-center g-3">
                <div class="col d-flex align-items-center gap-3">
                    <div class="dash-avatar">
                        <asp:Literal ID="litAvatarInitial" runat="server" />
                    </div>
                    <div>
                        <div class="hero-eyebrow mb-2" style="margin-bottom:0.5rem !important;">
                            <span class="pulse"></span><span>Active Learner</span>
                        </div>
                        <h2 class="fw-bold mb-1" style="font-family:var(--font-display);font-size:1.75rem;letter-spacing:-0.03em;background:linear-gradient(135deg,#fff,#C7D2FE);-webkit-background-clip:text;background-clip:text;color:transparent;">
                            Welcome back, <asp:Literal ID="litWelcome" runat="server" />
                        </h2>
                        <p class="mb-0" style="color:rgba(255,255,255,0.65);font-size:0.9rem;">
                            Member since <asp:Literal ID="litMemberSince" runat="server" /> &mdash; Keep up the great work.
                        </p>
                    </div>
                </div>
                <div class="col-auto">
                    <a href="../Courses/CourseList.aspx" class="btn btn-warning">
                        <i class="fas fa-plus me-1"></i>Explore Courses
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">

        <!-- ===== STATS ROW ===== -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon purple"><i class="fas fa-book-open"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litEnrolled" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Enrolled</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litCompleted" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Completed</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-clipboard-check"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litQuizzesTaken" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Quizzes</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon orange"><i class="fas fa-comments"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litForumPosts" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Forum Posts</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">

            <!-- ============================== LEFT COLUMN ============================== -->
            <div class="col-lg-8">

                <!-- MY COURSES -->
                <div class="section-header mb-3">
                    <h5 class="fw-bold mb-0">
                        <i class="fas fa-book-open me-2 text-primary"></i>My Courses
                    </h5>
                    <a href="../Courses/CourseList.aspx" class="small text-primary">View all &rarr;</a>
                </div>

                <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                    <div class="text-center py-4 text-muted ms-card p-4 mb-3">
                        <i class="fas fa-book fa-3x mb-3 d-block" style="color:#ddd;"></i>
                        <p class="mb-2">You haven't enrolled in any courses yet.</p>
                        <a href="../Courses/CourseList.aspx" class="btn btn-primary btn-sm">Browse Courses</a>
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptEnrolled" runat="server">
                    <ItemTemplate>
                        <div class="enrolled-course-item">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <span class="course-cat-badge cat-<%# Eval("Category").ToString().ToLower() == "self-care" ? "selfcare" : GetCatClass(Eval("Category").ToString()) %>">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                    </span>
                                    <h6 class="fw-bold mb-0 mt-1">
                                        <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>"
                                           class="text-decoration-none" style="color:var(--ms-text);">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                        </a>
                                    </h6>
                                </div>
                                <%# Convert.ToBoolean(Eval("IsCompleted"))
                                    ? "<span class='badge bg-success'>Completed</span>"
                                    : "<span class='badge bg-light text-muted border'>" + Eval("Progress") + "%</span>" %>
                            </div>
                            <div class="progress mt-2" style="height:6px;">
                                <div class="progress-bar" role="progressbar"
                                     style="width:<%# Eval("Progress") %>%;"
                                     aria-valuenow='<%# Eval("Progress") %>'
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <small class="text-muted">Progress: <%# Eval("Progress") %>%</small>
                                <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>"
                                   class="btn btn-sm btn-outline-primary">
                                    <%# Convert.ToBoolean(Eval("IsCompleted")) ? "Review" : "Continue" %>
                                    <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- MY CERTIFICATES -->
                <asp:Panel ID="pnlCertificates" runat="server" Visible="false">
                    <div class="section-header mb-3 mt-4">
                        <h5 class="fw-bold mb-0">
                            <i class="fas fa-certificate me-2" style="color:#f9c74f;"></i>My Certificates
                        </h5>
                        <span class="small text-muted">
                            <asp:Literal ID="litCertCount" runat="server" /> earned
                        </span>
                    </div>
                    <div class="row g-3">
                        <asp:Repeater ID="rptCertificates" runat="server">
                            <ItemTemplate>
                                <div class="col-md-6">
                                    <div class="certificate-card">
                                        <div class="cert-icon">
                                            <i class="fas fa-award"></i>
                                        </div>
                                        <div class="cert-body">
                                            <div class="cert-title">
                                                <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                            </div>
                                            <div class="cert-category">
                                                <span class="course-cat-badge cat-<%# Eval("Category").ToString().ToLower() == "self-care" ? "selfcare" : GetCatClass(Eval("Category").ToString()) %>" style="font-size:0.65rem;padding:0.15rem 0.5rem;">
                                                    <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                                </span>
                                            </div>
                                            <div class="cert-date">
                                                <i class="fas fa-calendar-check me-1"></i>
                                                <%# Convert.ToDateTime(Eval("EnrollDate")).ToString("dd MMMM yyyy") %>
                                            </div>
                                            <div class="cert-number">
                                                CERT-<%# Eval("UserID") %>-<%# Eval("CourseID") %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>

                <!-- DISCUSSION ACTIVITY -->
                <div class="section-header mb-3 mt-4">
                    <h5 class="fw-bold mb-0">
                        <i class="fas fa-comments me-2 text-primary"></i>Discussion Activity
                    </h5>
                    <a href="Discussions.aspx" class="small text-primary">Visit forum &rarr;</a>
                </div>

                <div class="ms-card p-3">
                    <asp:Panel ID="pnlNoActivity" runat="server" Visible="false">
                        <div class="text-center py-3 text-muted small">
                            <i class="fas fa-comment-slash fa-2x mb-2 d-block" style="color:#ddd;"></i>
                            You haven't posted in the forum yet.
                            <a href="Discussions.aspx" class="d-block mt-1 text-primary">Join the discussion &rarr;</a>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptActivity" runat="server">
                        <ItemTemplate>
                            <div class="activity-item">
                                <div class="activity-type-icon <%# Eval("ActivityType").ToString() %>">
                                    <i class="fas <%# Eval("ActivityType").ToString()=="post" ? "fa-pen" : "fa-reply" %>"></i>
                                </div>
                                <div class="activity-label">
                                    <div class="activity-title">
                                        <a href='Discussions.aspx' class="text-decoration-none" style="color:var(--ms-text);">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Label").ToString()) %>
                                        </a>
                                    </div>
                                    <div class="activity-meta">
                                        <%# Eval("ActivityType").ToString()=="post" ? "<i class='fas fa-pen me-1'></i>New discussion" : "<i class='fas fa-reply me-1'></i>Reply in: " + System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("Context"))) %>
                                        &nbsp;&bull;&nbsp;
                                        <%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>

            <!-- ============================== RIGHT COLUMN ============================== -->
            <div class="col-lg-4">

                <!-- PROFILE CARD -->
                <div class="ms-card p-4 mb-4 profile-card-mini text-center">
                    <div class="avatar-lg">
                        <asp:Literal ID="litProfileInitial" runat="server" />
                    </div>
                    <div class="fw-bold fs-6 mb-1">
                        <asp:Literal ID="litProfileName" runat="server" />
                    </div>
                    <div class="text-muted small mb-2">
                        @<asp:Literal ID="litProfileUsername" runat="server" />
                    </div>
                    <asp:Panel ID="pnlBio" runat="server" Visible="false">
                        <p class="profile-bio-preview px-2 mb-3">
                            <asp:Literal ID="litProfileBio" runat="server" />
                        </p>
                    </asp:Panel>
                    <div class="d-flex gap-2 justify-content-center">
                        <a href="Profile.aspx" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-user-edit me-1"></i>Edit Profile
                        </a>
                        <a href="../ChangePassword.aspx" class="btn btn-outline-secondary btn-sm">
                            <i class="fas fa-key me-1"></i>Password
                        </a>
                    </div>
                </div>

                <!-- ACHIEVEMENTS -->
                <div class="ms-card p-4 mb-4">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-star me-2 text-warning"></i>Achievements
                    </h6>
                    <asp:Literal ID="litAchievements" runat="server" />
                </div>

                <!-- RECENT QUIZ RESULTS -->
                <div class="ms-card p-3 mb-4">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-clipboard-check me-2 text-primary"></i>Recent Quiz Results
                    </h6>

                    <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false">
                        <div class="text-center py-3 text-muted small">
                            <i class="fas fa-clipboard fa-2x mb-2 d-block" style="color:#ddd;"></i>
                            No quiz results yet.
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptQuizResults" runat="server">
                        <ItemTemplate>
                            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                <div>
                                    <div class="fw-semibold small">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("QuizTitle").ToString()) %>
                                    </div>
                                    <div class="text-muted" style="font-size:0.72rem;">
                                        <%# Convert.ToDateTime(Eval("DateTaken")).ToString("dd MMM yyyy") %>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <div class="fw-bold small <%# Convert.ToDecimal(Eval("Percentage")) >= 70 ? "text-success" : "text-danger" %>">
                                        <%# Eval("Score") %>/<%# Eval("TotalQuestions") %>
                                    </div>
                                    <small class="<%# Convert.ToDecimal(Eval("Percentage")) >= 70 ? "text-success" : "text-danger" %>">
                                        <%# string.Format("{0:0}%", Eval("Percentage")) %>
                                    </small>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- QUICK ACTIONS -->
                <div class="ms-card p-3">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-bolt me-2 text-warning"></i>Quick Actions
                    </h6>
                    <div class="d-grid gap-2">
                        <a href="ProgressTracking.aspx" class="btn btn-primary btn-sm text-start">
                            <i class="fas fa-chart-line me-2"></i>My Progress
                        </a>
                        <a href="../Courses/CourseList.aspx" class="btn btn-outline-primary btn-sm text-start">
                            <i class="fas fa-book-open me-2"></i>Browse All Courses
                        </a>
                        <a href="Discussions.aspx" class="btn btn-outline-primary btn-sm text-start">
                            <i class="fas fa-comment-dots me-2"></i>Community Discussions
                        </a>
                        <a href="Profile.aspx" class="btn btn-outline-primary btn-sm text-start">
                            <i class="fas fa-user-edit me-2"></i>Edit My Profile
                        </a>
                        <a href="../ChangePassword.aspx" class="btn btn-outline-secondary btn-sm text-start">
                            <i class="fas fa-key me-2"></i>Change Password
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
