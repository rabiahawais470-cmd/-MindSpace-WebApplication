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

            <!-- RESOURCES -->
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
                                        "<a href='#' class='btn btn-outline-primary btn-sm mt-2'><i class=\"fas fa-download me-1\"></i>Download Resource</a>" : "" %>
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

                <!-- QUIZZES -->
                <div class="ms-card p-4">
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

            </div>
        </div>

        <!-- ===== SUCCESS STORIES ===== -->
        <div class="mt-5 pt-2" style="border-top:2px solid var(--ms-border);">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold mb-0">
                    <i class="fas fa-star me-2 text-warning"></i>Success Stories
                </h4>
                <span class="text-muted small">Hear from students who completed this course</span>
            </div>

            <!-- Story cards (visible to all) -->
            <asp:Panel ID="pnlNoStories" runat="server" Visible="false">
                <div class="text-center py-4 text-muted">
                    <i class="fas fa-comment-slash fa-2x mb-2 d-block" style="color:#ddd;"></i>
                    No success stories yet. Be the first to share yours after passing the quiz!
                </div>
            </asp:Panel>

            <div class="row g-3 mb-4">
                <asp:Repeater ID="rptStories" runat="server">
                    <ItemTemplate>
                        <div class="col-md-6 col-lg-4">
                            <div class="story-card">
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <div class="story-avatar">
                                        <%# Convert.ToString(Eval("DisplayName")).Length > 0 ? Convert.ToString(Eval("DisplayName")).Substring(0,1).ToUpper() : "?" %>
                                    </div>
                                    <div>
                                        <div class="fw-semibold" style="font-size:0.9rem;"><%# System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("DisplayName"))) %></div>
                                        <div class="text-muted" style="font-size:0.72rem;"><%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %></div>
                                    </div>
                                </div>
                                <div class="story-achievement-badge">
                                    <i class="fas fa-trophy me-1"></i><%# System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("Achievement"))) %>
                                </div>
                                <p class="story-text mb-2">
                                    <em>"<%# System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("WhatLearned"))) %>"</em>
                                </p>
                                <div class="story-result">
                                    <i class="fas fa-check-circle me-1"></i><%# System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("Result"))) %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Share story — visible to users who passed quiz (70%+) and haven't submitted yet -->
            <asp:Panel ID="pnlShareStory" runat="server" Visible="false">
                <div class="text-center mb-3">
                    <button type="button" class="btn btn-warning fw-bold px-4"
                            onclick="var w=document.getElementById('storyFormWrap');w.style.display=w.style.display==='none'?'block':'none';return false;">
                        <i class="fas fa-pen-nib me-2"></i>Share Your Success Story
                    </button>
                </div>
                <div id="storyFormWrap" style="display:none;">
                    <div class="story-form-panel">
                        <h6 class="fw-bold mb-3"><i class="fas fa-edit me-2 text-primary"></i>Tell Others What You Achieved</h6>

                        <asp:Panel ID="pnlStoryError" runat="server" Visible="false">
                            <div class="alert alert-danger py-2 small mb-3">
                                <i class="fas fa-exclamation-circle me-1"></i>
                                <asp:Literal ID="litStoryError" runat="server" />
                            </div>
                        </asp:Panel>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Your Name <span class="text-muted fw-normal">(displayed publicly)</span></label>
                                <asp:TextBox ID="txtStoryName" runat="server" CssClass="form-control form-control-sm"
                                    placeholder="e.g. Alex J." MaxLength="100" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small">Achievement Badge <span class="text-muted fw-normal">(short, shown as tag)</span></label>
                                <asp:TextBox ID="txtAchievement" runat="server" CssClass="form-control form-control-sm"
                                    placeholder="e.g. Reduced stress by 50%" MaxLength="200" />
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold small">What did you learn? <span class="text-muted fw-normal">(1–2 sentences)</span></label>
                                <asp:TextBox ID="txtWhatLearned" runat="server" TextMode="MultiLine" Rows="3"
                                    CssClass="form-control form-control-sm"
                                    placeholder="e.g. I learned to recognise my stress triggers and apply the 4-7-8 breathing technique instantly." />
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold small">What result did you achieve?</label>
                                <asp:TextBox ID="txtResult" runat="server" CssClass="form-control form-control-sm"
                                    placeholder="e.g. I now sleep 7 hours a night and feel much calmer during exams." MaxLength="500" />
                            </div>
                            <div class="col-12">
                                <asp:Button ID="btnSubmitStory" runat="server" Text="Submit My Story"
                                    CssClass="btn btn-primary btn-sm px-4" OnClick="btnSubmitStory_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <!-- Encourage enrolled users who haven't yet passed the quiz -->
            <asp:Panel ID="pnlEncourageQuiz" runat="server" Visible="false">
                <div class="encourage-quiz-banner">
                    <i class="fas fa-lightbulb me-2"></i>
                    Pass the course quiz with <strong>70% or above</strong> to unlock the ability to share your own success story!
                </div>
            </asp:Panel>

        </div>

    </div>
</asp:Content>
