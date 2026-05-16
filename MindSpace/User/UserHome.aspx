<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="UserHome.aspx.cs" Inherits="MindSpace.UserHome" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- WELCOME BANNER -->
    <div style="background:linear-gradient(135deg,#6C5CE7,#5541d0);color:#fff;padding:2rem 0;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="fw-bold mb-1">
                        Welcome back, <asp:Literal ID="litWelcome" runat="server" />! 👋
                    </h2>
                    <p class="mb-0 opacity-85">Continue your mental wellness journey. You're doing great!</p>
                </div>
                <div class="col-auto">
                    <a href="../Courses/CourseList.aspx" class="btn btn-warning fw-bold">
                        <i class="fas fa-plus me-1"></i>Explore Courses
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">

        <!-- STATS OVERVIEW -->
        <div class="row g-3 mb-4">
            <div class="col-sm-4">
                <div class="stat-card">
                    <div class="stat-icon purple"><i class="fas fa-book-open"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litEnrolled" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Courses Enrolled</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litCompleted" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Courses Completed</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-clipboard-check"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litQuizzesTaken" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Quizzes Taken</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">

            <!-- MY COURSES -->
            <div class="col-lg-7">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0"><i class="fas fa-book-open me-2 text-primary"></i>My Courses</h5>
                    <a href="../Courses/CourseList.aspx" class="small text-primary">View all courses →</a>
                </div>

                <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                    <div class="text-center py-5 text-muted">
                        <i class="fas fa-book fa-3x mb-3 d-block" style="color:#ddd;"></i>
                        <p>You haven't enrolled in any courses yet.</p>
                        <a href="../Courses/CourseList.aspx" class="btn btn-primary">Browse Courses</a>
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptEnrolled" runat="server">
                    <ItemTemplate>
                        <div class="enrolled-course-item">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                                        <%# Eval("Category") %>
                                    </span>
                                    <h6 class="fw-bold mb-0 mt-1">
                                        <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" class="text-decoration-none text-dark">
                                            <%# Eval("Title") %>
                                        </a>
                                    </h6>
                                </div>
                                <%# Convert.ToBoolean(Eval("IsCompleted")) ?
                                    "<span class='badge bg-success'>Completed</span>" :
                                    "<span class='badge bg-light text-muted'>" + Eval("Progress") + "%</span>" %>
                            </div>
                            <div class="progress mt-2">
                                <div class="progress-bar" role="progressbar"
                                     style="width:<%# Eval("Progress") %>%;"
                                     aria-valuenow='<%# Eval("Progress") %>'
                                     aria-valuemin="0" aria-valuemax="100">
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
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
            </div>

            <!-- SIDEBAR: Quiz Results + Forum Activity -->
            <div class="col-lg-5">

                <!-- RECENT QUIZ RESULTS -->
                <div class="ms-card p-3 mb-4">
                    <h6 class="fw-bold mb-3"><i class="fas fa-clipboard-check me-2 text-primary"></i>Recent Quiz Results</h6>

                    <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false">
                        <div class="text-center py-3 text-muted small">
                            <i class="fas fa-clipboard fa-2x mb-2 d-block" style="color:#ddd;"></i>
                            No quiz results yet. Take a quiz to see your scores here.
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptQuizResults" runat="server">
                        <ItemTemplate>
                            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                <div>
                                    <div class="fw-semibold small"><%# Eval("QuizTitle") %></div>
                                    <div class="text-muted" style="font-size:0.75rem;">
                                        <%# Convert.ToDateTime(Eval("DateTaken")).ToString("dd MMM yyyy") %>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <div class="fw-bold <%# Convert.ToDecimal(Eval("Percentage"))>=60?"text-success":"text-danger" %>">
                                        <%# Eval("Score") %>/<%# Eval("TotalQuestions") %>
                                    </div>
                                    <small class="<%# Convert.ToDecimal(Eval("Percentage"))>=60?"text-success":"text-danger" %>">
                                        <%# string.Format("{0:0}%", Eval("Percentage")) %>
                                    </small>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- QUICK ACTIONS -->
                <div class="ms-card p-3">
                    <h6 class="fw-bold mb-3"><i class="fas fa-bolt me-2 text-warning"></i>Quick Actions</h6>
                    <div class="d-grid gap-2">
                        <a href="../Courses/CourseList.aspx" class="btn btn-outline-primary btn-sm text-start">
                            <i class="fas fa-book-open me-2"></i>Browse All Courses
                        </a>
                        <a href="Forum.aspx" class="btn btn-outline-primary btn-sm text-start">
                            <i class="fas fa-comments me-2"></i>Visit Discussion Forum
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
