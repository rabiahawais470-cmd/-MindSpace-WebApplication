<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MindSpace.DefaultPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== HERO ===== -->
    <section class="home-hero">
        <div class="home-hero-grid">
            <div class="home-hero-text">
                <span class="home-hero-eyebrow">
                    <span class="dot"></span> Mental Wellness, Reimagined
                </span>
                <h1 class="home-hero-title">
                    Quiet your mind.<br/>
                    Learn to live <span class="accent">unhurried</span>.
                </h1>
                <p class="home-hero-sub">
                    Evidence-based micro-courses on stress, sleep, anxiety and self-compassion &mdash; built with care for students and young adults navigating real life.
                </p>
                <div class="home-hero-cta">
                    <a href="Register.aspx" class="btn btn-primary btn-lg">
                        Begin for free
                        <i class="fa-solid fa-arrow-right ms-2"></i>
                    </a>
                    <a href="Courses/CourseList.aspx" class="btn btn-outline-primary btn-lg">Browse courses</a>
                </div>
                <div class="home-hero-meta">
                    <div class="home-hero-meta-item">
                        <div class="num">6</div>
                        <div class="lbl">Courses</div>
                    </div>
                    <div class="home-hero-meta-item">
                        <div class="num">75</div>
                        <div class="lbl">Quiz Questions</div>
                    </div>
                    <div class="home-hero-meta-item">
                        <div class="num">100%</div>
                        <div class="lbl">Free Forever</div>
                    </div>
                    <div class="home-hero-meta-item">
                        <div class="num">5min</div>
                        <div class="lbl">To Start</div>
                    </div>
                </div>
            </div>
            <div class="home-hero-cluster">
                <div class="home-hero-photo p1"></div>
                <div class="home-hero-photo p3"></div>
                <div class="home-hero-photo p2"></div>
                <div class="home-hero-badge b1">
                    <span class="home-hero-badge-icon green"><i class="fa-solid fa-leaf"></i></span>
                    <div class="home-hero-badge-text">
                        <div class="t1">Self-paced</div>
                        <div class="t2">Learn at your own rhythm</div>
                    </div>
                </div>
                <div class="home-hero-badge b2">
                    <span class="home-hero-badge-icon"><i class="fa-solid fa-shield-halved"></i></span>
                    <div class="home-hero-badge-text">
                        <div class="t1">Private</div>
                        <div class="t2">Your data, your eyes only</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== MANIFESTO ===== -->
    <section class="home-manifesto">
        <div class="home-manifesto-inner reveal">
            <div class="home-manifesto-eyebrow">Our quiet manifesto</div>
            <p class="home-manifesto-quote">
                Mental health isn&rsquo;t a destination, it&rsquo;s a <span class="accent">practice</span>.
                Small habits, repeated gently, change the shape of a week &mdash; and over time, the shape of a life.
            </p>
            <div class="home-manifesto-signature">
                <span>The MindSpace team</span>
            </div>
        </div>
    </section>

    <!-- ===== HOW IT WORKS ===== -->
    <section class="home-steps">
        <div class="section-head-split reveal">
            <div>
                <span class="section-eyebrow">In Three Quiet Steps</span>
                <h2 class="section-title">A <span class="accent">gentle</span> path to start</h2>
            </div>
            <p class="section-intro mb-0">No long sign-ups. No noisy gamification. Just a clear way in.</p>
        </div>
        <div class="home-steps-grid">
            <div class="home-step reveal">
                <div class="home-step-num">01</div>
                <h5>Create a free account</h5>
                <p>Username, email, and a password. That&rsquo;s all we ask for. No upsells.</p>
            </div>
            <div class="home-step reveal">
                <div class="home-step-num">02</div>
                <h5>Pick a topic that fits</h5>
                <p>Stress, sleep, anxiety, self-care &mdash; start where life is asking for attention.</p>
            </div>
            <div class="home-step reveal">
                <div class="home-step-num">03</div>
                <h5>Practice in small doses</h5>
                <p>Short readings, guided videos, and reflective quizzes. Five to ten minutes is enough.</p>
            </div>
        </div>
    </section>

    <!-- ===== BENTO CATEGORY GRID ===== -->
    <section class="home-bento">
        <div class="section-head-split reveal">
            <div>
                <span class="section-eyebrow">Explore By Topic</span>
                <h2 class="section-title">Choose where to <span class="accent">begin</span></h2>
            </div>
            <a href="Courses/CourseList.aspx" class="btn btn-outline-primary">All topics <i class="fa-solid fa-arrow-right ms-1"></i></a>
        </div>
        <div class="home-bento-grid">
            <a href="Courses/CourseList.aspx" class="bento-tile t1 lg">
                <div class="bento-tile-inner">
                    <span class="bento-tile-eyebrow">Most popular</span>
                    <div>
                        <h3 class="bento-tile-title">Mindfulness &amp; Meditation</h3>
                        <div class="bento-tile-meta">Stay present, breathe, and notice without judgement.</div>
                    </div>
                </div>
            </a>
            <a href="Courses/CourseList.aspx" class="bento-tile t2">
                <div class="bento-tile-inner">
                    <span class="bento-tile-eyebrow">Care for yourself</span>
                    <div>
                        <h3 class="bento-tile-title">Self-Care</h3>
                        <div class="bento-tile-meta">Daily rituals to recharge.</div>
                    </div>
                </div>
            </a>
            <a href="Courses/CourseList.aspx" class="bento-tile t3">
                <div class="bento-tile-inner">
                    <span class="bento-tile-eyebrow">Rest deeply</span>
                    <div>
                        <h3 class="bento-tile-title">Sleep Hygiene</h3>
                        <div class="bento-tile-meta">Habits for restorative sleep.</div>
                    </div>
                </div>
            </a>
            <a href="Courses/CourseList.aspx" class="bento-tile t4">
                <div class="bento-tile-inner">
                    <span class="bento-tile-eyebrow">Soften worry</span>
                    <div>
                        <h3 class="bento-tile-title">Anxiety</h3>
                        <div class="bento-tile-meta">Tools to ground yourself.</div>
                    </div>
                </div>
            </a>
            <a href="Courses/CourseList.aspx" class="bento-tile t5">
                <div class="bento-tile-inner">
                    <span class="bento-tile-eyebrow">Bounce forward</span>
                    <div>
                        <h3 class="bento-tile-title">Resilience</h3>
                        <div class="bento-tile-meta">Strength after setbacks.</div>
                    </div>
                </div>
            </a>
        </div>
    </section>

    <!-- ===== FEATURED COURSES (magazine: big + side stack) ===== -->
    <section class="home-featured">
        <div class="section-head-split reveal">
            <div>
                <span class="section-eyebrow">Curated For This Month</span>
                <h2 class="section-title">Start with a <span class="accent">handpicked</span> course</h2>
            </div>
            <a href="Courses/CourseList.aspx" class="btn btn-outline-primary">View all <i class="fa-solid fa-arrow-right ms-1"></i></a>
        </div>
        <asp:Repeater ID="rptCourses" runat="server">
            <HeaderTemplate><div class="home-featured-grid"></HeaderTemplate>
            <ItemTemplate>
                <asp:PlaceHolder runat="server" Visible='<%# Container.ItemIndex == 0 %>'>
                    <a class='feature-course-big cat-<%# GetCatClass(Eval("Category").ToString()) %>'
                       href='<%# "Courses/CourseDetail.aspx?id=" + Eval("CourseID") %>'>
                        <div class="feature-course-big-body">
                            <span style="display:inline-block; background:rgba(255,255,255,0.18); backdrop-filter:blur(8px); padding:5px 14px; border-radius:99px; font-size:0.7rem; font-weight:600; color:#fff; text-transform:uppercase; letter-spacing:0.08em;">
                                <%# Eval("Category") %>
                            </span>
                            <h3><%# Eval("Title") %></h3>
                            <p><%# Eval("Description") %></p>
                            <span class="btn btn-light btn-sm" style="color:var(--color-primary); font-weight:700;">
                                Start course <i class="fa-solid fa-arrow-right ms-1"></i>
                            </span>
                        </div>
                    </a>
                </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" Visible='<%# Container.ItemIndex > 0 %>'>
                    <a class="feature-course-side"
                       href='<%# "Courses/CourseDetail.aspx?id=" + Eval("CourseID") %>'>
                        <div class='feature-course-side-img cat-<%# GetCatClass(Eval("Category").ToString()) %>'></div>
                        <div class="feature-course-side-body">
                            <span class="cat-tag"><%# Eval("Category") %></span>
                            <h6><%# Eval("Title") %></h6>
                            <div class="meta"><i class="fa-regular fa-clock me-1"></i><%# Eval("Duration") %> &middot; <%# Eval("DifficultyLevel") %></div>
                        </div>
                    </a>
                </asp:PlaceHolder>
            </ItemTemplate>
            <FooterTemplate></div></FooterTemplate>
        </asp:Repeater>
    </section>

    <!-- ===== VOICES / TESTIMONIALS ===== -->
    <section class="home-voices">
        <div class="section-head-split reveal" style="justify-content: center; text-align: center;">
            <div>
                <span class="section-eyebrow">In Their Words</span>
                <h2 class="section-title">Voices from <span class="accent">our community</span></h2>
            </div>
        </div>
        <div class="home-voices-grid">
            <div class="voice-card reveal">
                <p class="voice-quote">
                    The Sleep Hygiene course rewired my late-night doom-scrolling. I&rsquo;m sleeping seven hours again for the first time in two semesters.
                </p>
                <div class="voice-author">
                    <div class="voice-author-avatar">M</div>
                    <div class="voice-author-info">
                        <div class="name">Maya R.</div>
                        <div class="role">Final-year student</div>
                    </div>
                </div>
            </div>
            <div class="voice-card reveal">
                <p class="voice-quote">
                    Short, evidence-based, no fluff. I dip in for ten minutes between lectures and actually feel a little calmer.
                </p>
                <div class="voice-author">
                    <div class="voice-author-avatar">J</div>
                    <div class="voice-author-info">
                        <div class="name">Jonas K.</div>
                        <div class="role">Computer science major</div>
                    </div>
                </div>
            </div>
            <div class="voice-card reveal">
                <p class="voice-quote">
                    The resilience module helped me name what I was going through. Naming it was the first step out of the spiral.
                </p>
                <div class="voice-author">
                    <div class="voice-author-avatar">S</div>
                    <div class="voice-author-info">
                        <div class="name">Sarah C.</div>
                        <div class="role">Postgraduate researcher</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== OUTRO CTA ===== -->
    <section class="home-outro">
        <div class="home-outro-inner reveal">
            <h2>Begin a quieter <span class="accent">five minutes</span> today.</h2>
            <p>Free, private, self-paced. The kindest thing you can do for yourself this week takes less time than scrolling.</p>
            <asp:Panel ID="pnlCTAGuest" runat="server">
                <a href="Register.aspx" class="btn btn-primary btn-lg me-2">Create free account</a>
                <a href="Login.aspx" class="btn btn-outline-light btn-lg">Sign in</a>
            </asp:Panel>
            <asp:Panel ID="pnlCTAUser" runat="server" Visible="false">
                <a href="User/UserHome.aspx" class="btn btn-primary btn-lg">Go to my dashboard</a>
            </asp:Panel>
        </div>
    </section>

    <!-- ===== FOOTER ===== -->
    <footer class="landing-footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-5 col-lg-4">
                    <h6 style="margin-bottom: 16px; display:flex; align-items:center; gap:10px;">
                        <span style="width:32px;height:32px;border-radius:8px;background:linear-gradient(135deg,#7C6FCD,#9D8FE0);display:inline-flex;align-items:center;justify-content:center;"><i class="fa-solid fa-brain"></i></span>
                        MindSpace
                    </h6>
                    <p style="font-size: var(--text-sm); line-height: 1.7; max-width: 320px;">
                        A quiet learning platform for mental wellness literacy &mdash; evidence-based, self-paced, free.
                    </p>
                </div>
                <div class="col-6 col-md-3 col-lg-2">
                    <h6>Platform</h6>
                    <ul class="list-unstyled mb-0">
                        <li><a href="<%: ResolveUrl("~/Default.aspx") %>">Home</a></li>
                        <li><a href="<%: ResolveUrl("~/Courses/CourseList.aspx") %>">Courses</a></li>
                        <li><a href="<%: ResolveUrl("~/Register.aspx") %>">Register</a></li>
                        <li><a href="<%: ResolveUrl("~/Login.aspx") %>">Sign In</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-4 col-lg-3">
                    <h6>Topics</h6>
                    <ul class="list-unstyled mb-0">
                        <li><a href="Courses/CourseList.aspx">Stress Management</a></li>
                        <li><a href="Courses/CourseList.aspx">Mindfulness</a></li>
                        <li><a href="Courses/CourseList.aspx">Anxiety</a></li>
                        <li><a href="Courses/CourseList.aspx">Sleep Hygiene</a></li>
                        <li><a href="Courses/CourseList.aspx">Resilience</a></li>
                    </ul>
                </div>
                <div class="col-md-12 col-lg-3">
                    <h6>Contact</h6>
                    <p style="font-size: var(--text-sm); margin: 0; line-height: 1.7;">
                        Questions? Reach out at<br />
                        <a href="mailto:hello@mindspace.io">hello@mindspace.io</a>
                    </p>
                </div>
            </div>
            <div class="landing-footer-bottom">
                &copy; 2026 MindSpace &mdash; Crafted with care for mental wellness.
            </div>
        </div>
    </footer>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    // Image rendering for the featured course cards is server-side via inline expressions;
    // see RenderBigCourse / RenderSideCourse helpers below (markup-only inline funcs).
</script>
</asp:Content>
