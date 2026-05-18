<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MindSpace.DefaultPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== HERO ===== -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-7">
                    <div class="hero-eyebrow">
                        <span class="pulse"></span>
                        <span>Mental Wellness &middot; Learning Platform</span>
                    </div>
                    <h1 class="hero-title">
                        Your journey to <span>mental wellness</span> starts here.
                    </h1>
                    <p class="hero-subtitle">
                        Expert-curated micro-courses on stress, mindfulness, anxiety,
                        sleep and resilience &mdash; designed for students and young adults,
                        delivered free and at your own pace.
                    </p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="Register.aspx" class="btn btn-warning btn-lg">
                            <i class="fas fa-arrow-right me-2"></i>Start Learning Free
                        </a>
                        <a href="Courses/CourseList.aspx" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-book-open me-2"></i>Browse Courses
                        </a>
                    </div>
                    <div class="hero-stats">
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">6+</div>
                            <div class="hero-stat-label">Expert Courses</div>
                        </div>
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">100%</div>
                            <div class="hero-stat-label">Free Forever</div>
                        </div>
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">75</div>
                            <div class="hero-stat-label">Quiz Questions</div>
                        </div>
                        <div class="hero-stat-item">
                            <div class="hero-stat-num">5<i class="fas fa-star" style="font-size:1.4rem;color:#FCD34D;vertical-align:0.15em;margin-left:0.1em;"></i></div>
                            <div class="hero-stat-label">Evidence Based</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 d-none d-lg-block">
                    <div class="hero-visual">
                        <div class="hero-orb">
                            <div class="hero-orb-inner">
                                <i class="fas fa-brain"></i>
                            </div>
                        </div>
                        <div class="hero-chip c1"><i class="fas fa-spa"></i>Mindfulness</div>
                        <div class="hero-chip c2"><i class="fas fa-leaf"></i>Resilience</div>
                        <div class="hero-chip c3"><i class="fas fa-moon"></i>Sleep</div>
                        <div class="hero-chip c4"><i class="fas fa-heart"></i>Self-Care</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FEATURES ===== -->
    <section class="py-5" style="padding-top:6rem !important;padding-bottom:5rem !important;">
        <div class="container">
            <div class="section-heading reveal">
                <span class="eyebrow">Why MindSpace</span>
                <h2>Everything you need to build <span>mental health literacy</span></h2>
                <div class="section-divider"></div>
                <p>Six pillars of an evidence-based learning experience &mdash; thoughtfully designed for the way you actually learn.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 reveal">
                    <div class="feature-card">
                        <div class="feature-icon feature-icon-purple">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <h5>Structured Learning</h5>
                        <p>Evidence-based courses designed by mental health professionals covering all key areas of wellbeing.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 reveal">
                    <div class="feature-card">
                        <div class="feature-icon feature-icon-green">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5>Progress Tracking</h5>
                        <p>Monitor your learning journey with personal dashboards, quiz scores, and completion analytics.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 reveal">
                    <div class="feature-card">
                        <div class="feature-icon feature-icon-blue">
                            <i class="fas fa-comments"></i>
                        </div>
                        <h5>Community Support</h5>
                        <p>Connect with peers in the discussion forum to share experiences and support each other's growth.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 reveal">
                    <div class="feature-card">
                        <div class="feature-icon feature-icon-purple">
                            <i class="fas fa-brain"></i>
                        </div>
                        <h5>Self-Assessments</h5>
                        <p>Interactive quizzes with instant feedback help reinforce learning and measure understanding.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 reveal">
                    <div class="feature-card">
                        <div class="feature-icon feature-icon-warm">
                            <i class="fas fa-video"></i>
                        </div>
                        <h5>Rich Multimedia</h5>
                        <p>Articles, embedded videos, guided exercises, and downloadable resources for every learning style.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 reveal">
                    <div class="feature-card">
                        <div class="feature-icon feature-icon-rose">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5>Safe &amp; Private</h5>
                        <p>Your data is secure with encrypted passwords and private progress tracking for your eyes only.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FEATURED COURSES ===== -->
    <section class="py-5 home-courses-section" style="padding-top:5rem !important;padding-bottom:5rem !important;">
        <div class="container">
            <div class="section-heading reveal">
                <span class="eyebrow">Curated Path</span>
                <h2>Featured <span>courses</span></h2>
                <div class="section-divider"></div>
                <p>Start your mental health learning journey with our most popular courses, each ~30-45 minutes.</p>
            </div>
            <asp:Repeater ID="rptCourses" runat="server">
                <HeaderTemplate>
                    <div class="row g-4">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 reveal">
                        <div class="course-card cat-<%# GetCatClass(Eval("Category").ToString()) %>-bar">
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
                                   class="btn btn-primary btn-sm">View Course<i class="fas fa-arrow-right ms-1"></i></a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <div class="text-center mt-5">
                <a href="Courses/CourseList.aspx" class="btn btn-outline-primary btn-lg px-5">
                    <i class="fas fa-th-large me-2"></i>View All Courses
                </a>
            </div>
        </div>
    </section>

    <!-- ===== CTA ===== -->
    <section class="py-5 home-cta-section" style="padding-top:5rem !important;padding-bottom:5rem !important;">
        <div class="container text-center text-white position-relative" style="z-index:2;">
            <div class="hero-eyebrow mx-auto mb-3">
                <span class="pulse"></span><span>Free &middot; Self-paced &middot; Evidence-based</span>
            </div>
            <h2 class="fw-bold mb-3" style="font-family:var(--font-display);font-size:clamp(1.8rem,3.5vw,2.6rem);letter-spacing:-0.035em;background:linear-gradient(135deg,#fff,#C7D2FE);-webkit-background-clip:text;background-clip:text;color:transparent;">
                Ready to prioritise your mental health?
            </h2>
            <p class="mb-4 mx-auto" style="color:rgba(255,255,255,0.70);max-width:560px;font-size:1.05rem;">
                Join students and young adults already learning with MindSpace. It's free, evidence-based, and self-paced.
            </p>
            <asp:Panel ID="pnlCTAGuest" runat="server">
                <a href="Register.aspx" class="btn btn-warning btn-lg px-5 me-2 mb-2">
                    <i class="fas fa-user-plus me-2"></i>Create Free Account
                </a>
                <a href="Login.aspx" class="btn btn-outline-light btn-lg px-5 mb-2">
                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                </a>
            </asp:Panel>
            <asp:Panel ID="pnlCTAUser" runat="server" Visible="false">
                <a href="User/UserHome.aspx" class="btn btn-warning btn-lg px-5">
                    <i class="fas fa-tachometer-alt me-2"></i>Go to My Dashboard
                </a>
            </asp:Panel>
        </div>
    </section>

</asp:Content>
