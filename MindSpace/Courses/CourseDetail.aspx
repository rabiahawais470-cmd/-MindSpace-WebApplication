<%@ Page Title="Course Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="MindSpace.CourseDetail" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- COURSE HEADER -->
    <div style="background:linear-gradient(135deg,#1e1b3a,#3d2fb3);color:#fff;padding:3rem 0;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <asp:Literal ID="litCatBadge" runat="server" />
                    <h1 class="fw-bold mt-2 mb-2"><asp:Literal ID="litCourseTitle" runat="server" /></h1>
                    <p class="opacity-85 mb-3"><asp:Literal ID="litCourseDesc" runat="server" /></p>
                    <div class="d-flex gap-3 flex-wrap" style="font-size:0.875rem;opacity:0.85;">
                        <span><i class="fas fa-signal me-1"></i><asp:Literal ID="litLevel" runat="server" /></span>
                        <span><i class="fas fa-clock me-1"></i><asp:Literal ID="litDuration" runat="server" /></span>
                        <span><i class="fas fa-users me-1"></i><asp:Literal ID="litEnrolled" runat="server" /> enrolled</span>
                    </div>
                </div>
                <div class="col-lg-4 text-center mt-3 mt-lg-0">
                    <div style="font-size:5rem;line-height:1;"><asp:Literal ID="litIcon" runat="server" /></div>
                    <asp:Panel ID="pnlEnrollBtn" runat="server">
                        <asp:Button ID="btnEnroll" runat="server" Text="Enroll Now - Free!"
                            CssClass="btn btn-warning btn-lg fw-bold mt-2 px-4" OnClick="btnEnroll_Click" />
                    </asp:Panel>
                    <asp:Panel ID="pnlEnrolled" runat="server" Visible="false">
                        <div class="mt-2">
                            <span class="badge bg-success p-2 fs-6">
                                <i class="fas fa-check me-1"></i>You're enrolled!
                            </span>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnlLoginToEnroll" runat="server" Visible="false">
                        <a href="../Login.aspx" class="btn btn-outline-light btn-lg mt-2">
                            <i class="fas fa-sign-in-alt me-2"></i>Login to Enroll
                        </a>
                    </asp:Panel>
                </div>
            </div>
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

            <!-- LEARNING RESOURCES -->
            <div class="col-lg-8">
                <h4 class="fw-bold mb-3">
                    <i class="fas fa-book-open me-2 text-primary"></i>Learning Resources
                </h4>

                <asp:Panel ID="pnlNoResources" runat="server" Visible="false">
                    <div class="text-muted text-center py-4">
                        <i class="fas fa-file-alt fa-2x mb-2 d-block" style="color:#ddd;"></i>
                        No resources available for this course yet.
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="ms-card p-4 mb-3">
                            <div class="d-flex align-items-start gap-3">
                                <div style="width:40px;height:40px;border-radius:8px;flex-shrink:0;display:flex;align-items:center;justify-content:center;
                                            background:<%# GetResourceBg(Eval("ResourceType").ToString()) %>;">
                                    <i class="<%# GetResourceIcon(Eval("ResourceType").ToString()) %>" style="color:#fff;"></i>
                                </div>
                                <div style="flex:1;">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h6 class="fw-bold mb-0"><%# Eval("Title") %></h6>
                                        <span class="badge" style="background:<%# GetResourceBg(Eval("ResourceType").ToString()) %>;">
                                            <%# Eval("ResourceType") %>
                                        </span>
                                    </div>

                                    <%# Eval("ResourceType").ToString()=="video" && !string.IsNullOrEmpty(Convert.ToString(Eval("URL"))) ?
                                        "<div class='ratio ratio-16x9 mt-2'><iframe src='" + Eval("URL") + "?rel=0' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen class='rounded' title='Video resource'></iframe></div>" : "" %>

                                    <%# !string.IsNullOrEmpty(Convert.ToString(Eval("Content"))) ?
                                        "<p class='text-muted small mt-2 mb-0' style='line-height:1.7;'>" +
                                        Convert.ToString(Eval("Content")).Replace("\n","<br/>") + "</p>" : "" %>

                                    <%# Eval("ResourceType").ToString()=="download" ?
                                        (string.IsNullOrEmpty(Convert.ToString(Eval("URL")))
                                            ? "<span class='btn btn-outline-secondary btn-sm mt-2 disabled'><i class=\"fas fa-download me-1\"></i>Coming Soon</span>"
                                            : "<a href='" + System.Web.HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("URL"))) + "' download class='btn btn-success btn-sm mt-2'><i class=\"fas fa-download me-1\"></i>Download Resource</a>")
                                        : "" %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- SIDEBAR -->
            <div class="col-lg-4">

                <!-- PROGRESS (enrolled users) -->
                <asp:Panel ID="pnlProgress" runat="server" Visible="false">
                    <div class="ms-card p-3 mb-4">
                        <h6 class="fw-bold mb-2">
                            <i class="fas fa-chart-line me-2 text-primary"></i>My Progress
                        </h6>
                        <div class="progress mb-1">
                            <div id="courseProgressBar" runat="server" class="progress-bar" role="progressbar"></div>
                        </div>
                        <div class="d-flex justify-content-between">
                            <small class="text-muted">Progress</small>
                            <small class="fw-semibold"><asp:Literal ID="litProgressPct" runat="server" />%</small>
                        </div>
                    </div>
                </asp:Panel>

                <!-- AVAILABLE QUIZZES -->
                <div class="ms-card p-4 mb-4">
                    <h5 class="fw-bold mb-3">
                        <i class="fas fa-clipboard-check me-2 text-primary"></i>Available Quizzes
                    </h5>

                    <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false">
                        <div class="text-muted text-center py-3">
                            <i class="fas fa-clipboard fa-2x mb-2 d-block" style="color:#ddd;"></i>
                            No quizzes available yet.
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlLoginForQuiz" runat="server" Visible="false">
                        <div class="text-muted text-center py-3 small">
                            <i class="fas fa-lock fa-2x mb-2 d-block" style="color:#ddd;"></i>
                            <a href="../Login.aspx">Login</a> and enroll to take quizzes.
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptQuizzes" runat="server">
                        <ItemTemplate>
                            <div class="border rounded p-3 mb-2">
                                <h6 class="fw-bold mb-1"><%# Eval("Title") %></h6>
                                <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">Pass: <%# Eval("PassingScore") %>%</small>
                                    <a href="<%: ResolveUrl("~/Courses/Quiz.aspx") %>?quizID=<%# Eval("QuizID") %>"
                                       class="btn btn-success btn-sm">
                                        <i class="fas fa-play me-1"></i>Take Quiz
                                    </a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- COMPLETION CERTIFICATE (shown after passing quiz with 70%+) -->
                <asp:Panel ID="pnlCertificate" runat="server" Visible="false">
                    <div class="cert-panel">
                        <div class="cert-panel-header">
                            <i class="fas fa-award cert-panel-icon"></i>
                            <div class="cert-panel-title">Certificate of Completion</div>
                            <div class="cert-panel-sub">MindSpace Mental Health Learning Portal</div>
                        </div>
                        <div class="cert-panel-body">
                            <div class="cert-panel-label">This certifies that</div>
                            <div class="cert-panel-name"><asp:Literal ID="litCertName" runat="server" /></div>
                            <div class="cert-panel-label mt-1">has successfully completed</div>
                            <div class="cert-panel-course"><asp:Literal ID="litCertCourse" runat="server" /></div>
                            <div class="cert-panel-score mt-2">
                                <i class="fas fa-star me-1" style="color:#f9c74f;"></i>
                                Score: <asp:Literal ID="litCertScore" runat="server" />%
                            </div>
                            <hr style="border-color:rgba(108,92,231,0.15);margin:0.75rem 0;">
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="cert-panel-date">
                                    <i class="fas fa-calendar-check me-1"></i>
                                    <asp:Literal ID="litCertDate" runat="server" />
                                </small>
                                <small class="cert-panel-num">
                                    <asp:Literal ID="litCertNum" runat="server" />
                                </small>
                            </div>
                        </div>
                    </div>
                </asp:Panel>

            </div>
        </div>

    </div>
</asp:Content>
