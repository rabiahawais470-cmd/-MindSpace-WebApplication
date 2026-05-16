<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="MindSpace.DefaultPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== HERO ===== -->
    <section class="hero-section">
        <div class="container position-relative" style="z-index:2;">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <h1 class="hero-title">
                        Your Journey to <span>Mental Wellness</span> Starts Here
                    </h1>
                    <p class="hero-subtitle">
                        MindSpace is a free learning platform for students and young adults.
                        Access expert-curated courses on stress management, mindfulness, anxiety,
                        sleep hygiene, and resilience &mdash; at your own pace.
                    </p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="Register.aspx" class="btn btn-warning btn-lg px-4 fw-bold">
                            <i class="fas fa-rocket me-2"></i>Get Started Free
                        </a>
                        <a href="Courses/CourseList.aspx" class="btn btn-outline-light btn-lg px-4">
                            <i class="fas fa-book-open me-2"></i>Browse Courses
                        </a>
                    </div>
                    <div class="hero-stats">
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">5+</div>
                            <div class="hero-stat-label">Expert Courses</div>
                        </div>
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">100%</div>
                            <div class="hero-stat-label">Free Access</div>
                        </div>
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">Evidence</div>
                            <div class="hero-stat-label">Based Content</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 text-center d-none d-lg-block">
                    <div style="font-size:12rem;line-height:1;opacity:0.15;">🧠</div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FEATURES ===== -->
    <section class="py-5">
        <div class="container">
            <div class="section-heading">
                <h2>Why Choose MindSpace?</h2>
                <div class="section-divider"></div>
                <p>Everything you need to build mental health literacy in one place</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:rgba(108,92,231,0.12);">
                            <i class="fas fa-graduation-cap" style="color:#6C5CE7;"></i>
                        </div>
                        <h5 class="fw-bold">Structured Learning</h5>
                        <p class="text-muted small">Evidence-based courses designed by mental health professionals covering all key areas of wellbeing.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:rgba(0,184,148,0.12);">
                            <i class="fas fa-chart-line" style="color:#00B894;"></i>
                        </div>
                        <h5 class="fw-bold">Progress Tracking</h5>
                        <p class="text-muted small">Monitor your learning journey with personal dashboards, quiz scores, and completion tracking.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:rgba(116,185,255,0.15);">
                            <i class="fas fa-comments" style="color:#0984e3;"></i>
                        </div>
                        <h5 class="fw-bold">Community Support</h5>
                        <p class="text-muted small">Connect with peers in the discussion forum to share experiences and support each other's growth.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:rgba(253,203,110,0.2);">
                            <i class="fas fa-brain" style="color:#e17055;"></i>
                        </div>
                        <h5 class="fw-bold">Self-Assessments</h5>
                        <p class="text-muted small">Interactive quizzes with instant feedback help reinforce learning and measure understanding.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:rgba(253,203,110,0.2);">
                            <i class="fas fa-video" style="color:#fdcb6e;"></i>
                        </div>
                        <h5 class="fw-bold">Multimedia Content</h5>
                        <p class="text-muted small">Articles, embedded videos, guided exercises, and downloadable resources for every learning style.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:rgba(0,184,148,0.12);">
                            <i class="fas fa-shield-alt" style="color:#00B894;"></i>
                        </div>
                        <h5 class="fw-bold">Safe &amp; Private</h5>
                        <p class="text-muted small">Your data is secure with encrypted passwords and private progress tracking for your eyes only.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FEATURED COURSES ===== -->
    <section class="py-5" style="background:#fff;">
        <div class="container">
            <div class="section-heading">
                <h2>Featured Courses</h2>
                <div class="section-divider"></div>
                <p>Start your mental health learning journey with our most popular courses</p>
            </div>
            <asp:Repeater ID="rptCourses" runat="server">
                <HeaderTemplate>
                    <div class="row g-4">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="col-md-4">
                        <div class="course-card">
                            <div class="course-card-header">
                                <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                                    <%# Eval("Category") %>
                                </span>
                                <div class="course-icon"><%# GetCourseIcon(Eval("Category").ToString()) %></div>
                                <h5 class="course-card-title"><%# Eval("Title") %></h5>
                            </div>
                            <div class="course-card-body">
                                <p class="course-card-desc"><%# Eval("Description") %></p>
                                <div class="course-card-meta">
                                    <span><i class="fas fa-signal me-1"></i><%# Eval("DifficultyLevel") %></span>
                                    <span><i class="fas fa-clock me-1"></i><%# Eval("Duration") %></span>
                                </div>
                            </div>
                            <div class="course-card-footer">
                                <span class="text-muted small">
                                    <i class="fas fa-users me-1"></i><%# Eval("EnrollmentCount") %> enrolled
                                </span>
                                <a href="<%: ResolveUrl("~/Courses/CourseDetail.aspx") %>?id=<%# Eval("CourseID") %>"
                                   class="btn btn-primary btn-sm">View Course</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <div class="text-center mt-4">
                <a href="Courses/CourseList.aspx" class="btn btn-outline-primary btn-lg px-5">
                    <i class="fas fa-th-large me-2"></i>View All Courses
                </a>
            </div>
        </div>
    </section>

    <!-- ===== CTA ===== -->
    <section class="py-5" style="background:linear-gradient(135deg,#6C5CE7,#5541d0);">
        <div class="container text-center text-white">
            <h2 class="fw-bold mb-3">Ready to Prioritise Your Mental Health?</h2>
            <p class="mb-4 opacity-90">Join students and young adults already learning with MindSpace. It's free, evidence-based, and self-paced.</p>
            <asp:Panel ID="pnlCTAGuest" runat="server">
                <a href="Register.aspx" class="btn btn-warning btn-lg px-5 me-3 fw-bold">
                    <i class="fas fa-user-plus me-2"></i>Create Free Account
                </a>
                <a href="Login.aspx" class="btn btn-outline-light btn-lg px-5">
                    <i class="fas fa-sign-in-alt me-2"></i>Login
                </a>
            </asp:Panel>
            <asp:Panel ID="pnlCTAUser" runat="server" Visible="false">
                <a href="User/UserHome.aspx" class="btn btn-warning btn-lg px-5 fw-bold">
                    <i class="fas fa-tachometer-alt me-2"></i>Go to My Dashboard
                </a>
            </asp:Panel>
        </div>
    </section>

</asp:Content>
