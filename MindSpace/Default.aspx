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

    <!-- ===== PARALLAX FEATURE INTRO ===== -->
    <section class="ms-pfeature-intro">
        <h2>explore by <span class="accent">topic</span>.</h2>
        <span class="scroll-cue">Scroll <i class="fa-solid fa-arrow-down"></i></span>
    </section>

    <!-- ===== PARALLAX FEATURE PANELS ===== -->
    <div class="ms-pfeature-track">
        <section class="ms-pfeature-section" data-pfeature>
            <div class="ms-pfeature-copy">
                <h3>stress, softened</h3>
                <p>Short evidence-based practices for the days that feel too full. Breath, body, mind &mdash; one small reset at a time, repeated until it sticks.</p>
            </div>
            <div class="ms-pfeature-img-wrap" data-pfeature-img>
                <img src="https://images.unsplash.com/photo-1499728603263-13726abce5fd?w=960&q=75" alt="Stress management course imagery" />
            </div>
        </section>

        <section class="ms-pfeature-section reverse" data-pfeature>
            <div class="ms-pfeature-copy">
                <h3>anxiety, named</h3>
                <p>Cognitive-behavioural tools to put words on the worry, examine it, and choose a calmer response. Built on six decades of clinical research.</p>
            </div>
            <div class="ms-pfeature-img-wrap" data-pfeature-img>
                <img src="https://images.unsplash.com/photo-1474418397713-7ede21d49118?w=960&q=75" alt="Anxiety course imagery" />
            </div>
        </section>

        <section class="ms-pfeature-section" data-pfeature>
            <div class="ms-pfeature-copy">
                <h3>resilience, rebuilt</h3>
                <p>Setbacks happen. The work is what comes after. Frameworks for emotional regulation, meaning-making, and the slow, quiet repair of a hard week.</p>
            </div>
            <div class="ms-pfeature-img-wrap" data-pfeature-img>
                <img src="https://images.unsplash.com/photo-1551632811-561732d1e306?w=960&q=75" alt="Resilience course imagery" />
            </div>
        </section>
    </div>

    <!-- ===== TEXT PARALLAX STICKY SECTIONS ===== -->
    <div class="ms-text-parallax-track">

        <div class="ms-text-parallax-block" data-tp-block>
            <div class="ms-text-parallax-sticky"
                 data-tp-sticky
                 style="background-image: url('https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=1600&q=80');"></div>
            <div class="ms-text-parallax-overlay" data-tp-overlay>
                <p class="sub">evidence-based</p>
                <h2>built on science.</h2>
            </div>
        </div>
        <div class="ms-text-parallax-content">
            <h3>Every course traces back to peer-reviewed research.</h3>
            <div class="body">
                <p>Our courses draw on cognitive-behavioural therapy, dialectical behaviour therapy, polyvagal theory, and positive psychology &mdash; methods with decades of randomised-trial evidence behind them.</p>
                <p>No fluff, no quick fixes. Just the techniques clinicians actually use, translated into something a student can practise in five minutes between lectures.</p>
                <a href="Courses/CourseList.aspx" class="btn btn-primary">Browse the library <i class="fa-solid fa-arrow-up-right-from-square ms-2"></i></a>
            </div>
        </div>

        <div class="ms-text-parallax-block" data-tp-block>
            <div class="ms-text-parallax-sticky"
                 data-tp-sticky
                 style="background-image: url('https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=1600&q=80');"></div>
            <div class="ms-text-parallax-overlay" data-tp-overlay>
                <p class="sub">self-paced</p>
                <h2>learn at your rhythm.</h2>
            </div>
        </div>
        <div class="ms-text-parallax-content">
            <h3>Five minutes today. Five minutes tomorrow. That is enough.</h3>
            <div class="body">
                <p>Each course breaks down into bite-sized articles, short guided videos, and reflective quizzes. Pick up where you left off whenever life makes space.</p>
                <p>No streak shaming, no notification spam. Progress tracking that's there when you want it and quiet when you don't.</p>
                <a href="Register.aspx" class="btn btn-primary">Create a free account <i class="fa-solid fa-arrow-right ms-2"></i></a>
            </div>
        </div>

        <div class="ms-text-parallax-block" data-tp-block>
            <div class="ms-text-parallax-sticky"
                 data-tp-sticky
                 style="background-image: url('https://images.unsplash.com/photo-1518602164578-cd0074062767?w=1600&q=80');"></div>
            <div class="ms-text-parallax-overlay" data-tp-overlay>
                <p class="sub">private</p>
                <h2>your data, your eyes only.</h2>
            </div>
        </div>
        <div class="ms-text-parallax-content">
            <h3>What you read, write, and rate stays with you.</h3>
            <div class="body">
                <p>Your progress, your journal entries, your quiz scores &mdash; visible only to you. We do not sell data, we do not surface your activity to other learners, and we do not need a phone number to let you in.</p>
                <p>Encrypted at rest, transmitted over HTTPS, deletable on request.</p>
                <a href="Default.aspx#voices" class="btn btn-outline-primary">Hear from learners <i class="fa-solid fa-arrow-down ms-2"></i></a>
            </div>
        </div>

    </div>

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
/* ===== Parallax scroll tracking (vanilla equivalent of framer-motion useScroll/useTransform) ===== */
(function () {
    var clamp = function (v, lo, hi) { return Math.max(lo, Math.min(hi, v)); };

    // --- Parallax-feature panels ---
    // p = 0 when section bottom is at viewport bottom (section just entering)
    // p = 1 when section center reaches viewport top (well past midpoint)
    var pfeatures = document.querySelectorAll('[data-pfeature]');
    function updatePFeatures() {
        var vh = window.innerHeight || 800;
        pfeatures.forEach(function (sec) {
            var r = sec.getBoundingClientRect();
            // start: section top at viewport bottom  -> r.top === vh
            // end:   section center at viewport top  -> r.top + r.height/2 === 0
            var start = vh;
            var end   = -r.height / 2;
            var p = (start - r.top) / (start - end);
            sec.style.setProperty('--p', clamp(p, 0, 1).toFixed(3));
        });
    }

    // --- Text-parallax sticky blocks ---
    // For each .ms-text-parallax-block we drive two progresses:
    //   sp (sticky): 0 when block bottom enters bottom of viewport,
    //                1 when block bottom leaves top of viewport (image scales/fades)
    //   op (overlay): 0 at start (block top at bottom) -> 0.5 at middle -> 1 at end
    var tpBlocks = document.querySelectorAll('[data-tp-block]');
    function updateTPBlocks() {
        var vh = window.innerHeight || 800;
        tpBlocks.forEach(function (block) {
            var r = block.getBoundingClientRect();
            var bottom = r.bottom;
            var top    = r.top;
            // sticky: progress as block bottom passes through viewport
            var spStart = vh;       // bottom of block at bottom of viewport
            var spEnd   = 0;        // bottom of block at top of viewport
            var sp = clamp((spStart - bottom) / (spStart - spEnd), 0, 1);
            // overlay: progress across full scroll (start: top at bottom, end: bottom at top)
            var opStart = vh;        // top at bottom of viewport
            var opEnd   = -r.height; // top at -block height (block fully above viewport)
            var op = clamp((opStart - top) / (opStart - opEnd), 0, 1);
            var sticky  = block.querySelector('[data-tp-sticky]');
            var overlay = block.querySelector('[data-tp-overlay]');
            if (sticky)  sticky.style.setProperty('--sp', sp.toFixed(3));
            if (overlay) overlay.style.setProperty('--op', op.toFixed(3));
        });
    }

    var ticking = false;
    function onScroll() {
        if (ticking) return;
        ticking = true;
        window.requestAnimationFrame(function () {
            updatePFeatures();
            updateTPBlocks();
            ticking = false;
        });
    }

    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('resize', onScroll);
    // Initial paint
    onScroll();
})();
</script>
</asp:Content>
