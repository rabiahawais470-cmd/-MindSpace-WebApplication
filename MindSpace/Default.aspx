<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MindSpace.DefaultPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== ANIMATED HERO ===== -->
    <section class="ah-hero">
        <div class="ah-hero-inner">
            <a href="Courses/CourseList.aspx" class="ah-hero-eyebrow">
                Read our latest research <i class="fa-solid fa-arrow-right"></i>
            </a>

            <h1 class="ah-hero-title">
                <span class="static-line">Mental wellness is</span>
                <span class="cycle-line" id="ahWords">
                    <span class="ah-hero-word active" data-i="0">quiet</span>
                    <span class="ah-hero-word" data-i="1">honest</span>
                    <span class="ah-hero-word" data-i="2">human</span>
                    <span class="ah-hero-word" data-i="3">gentle</span>
                    <span class="ah-hero-word" data-i="4">yours</span>
                </span>
            </h1>

            <p class="ah-hero-sub">
                Short, evidence-based courses on stress, sleep, anxiety, resilience, and self-compassion &mdash;
                built for students and young adults who want real tools without the noise.
            </p>

            <div class="ah-hero-cta">
                <asp:Panel ID="pnlCTAGuest" runat="server">
                    <a href="Courses/CourseList.aspx" class="btn btn-outline-primary btn-lg">
                        <i class="fa-regular fa-compass"></i> Browse courses
                    </a>
                    <a href="Register.aspx" class="btn btn-primary btn-lg">
                        Sign up free <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </asp:Panel>
                <asp:Panel ID="pnlCTAUser" runat="server" Visible="false">
                    <a href="User/UserHome.aspx" class="btn btn-primary btn-lg">
                        Go to my dashboard <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </asp:Panel>
            </div>
        </div>
    </section>

    <!-- ===== STAT BAND ===== -->
    <section class="ah-stats">
        <div class="ah-stats-grid">
            <div>
                <div class="ah-stat-num">10<span class="accent">+</span></div>
                <div class="ah-stat-label">Courses</div>
            </div>
            <div>
                <div class="ah-stat-num">150<span class="accent">+</span></div>
                <div class="ah-stat-label">Quiz Questions</div>
            </div>
            <div>
                <div class="ah-stat-num">100<span class="accent">%</span></div>
                <div class="ah-stat-label">Free Forever</div>
            </div>
            <div>
                <div class="ah-stat-num">5<span class="accent">min</span></div>
                <div class="ah-stat-label">To Get Started</div>
            </div>
        </div>
    </section>

    <!-- ===== ICON FEATURE TILES (no photos) ===== -->
    <section class="ah-features">
        <div class="ah-features-head">
            <div class="ah-features-eyebrow">Why MindSpace</div>
            <h2 class="ah-features-title">a quieter way to learn about yourself.</h2>
        </div>
        <div class="ah-features-grid">
            <div class="ah-feature-tile">
                <div class="ah-feature-icon"><i class="fa-solid fa-flask"></i></div>
                <h3 class="ah-feature-title">evidence-based</h3>
                <p class="ah-feature-body">Every course traces back to peer-reviewed research &mdash; CBT, DBT, polyvagal, positive psychology.</p>
            </div>
            <div class="ah-feature-tile">
                <div class="ah-feature-icon bg-orange"><i class="fa-regular fa-clock"></i></div>
                <h3 class="ah-feature-title">self-paced</h3>
                <p class="ah-feature-body">Five minutes is enough. Pick up where you left off whenever life makes the space.</p>
            </div>
            <div class="ah-feature-tile">
                <div class="ah-feature-icon bg-cyan"><i class="fa-solid fa-shield-halved"></i></div>
                <h3 class="ah-feature-title">private by default</h3>
                <p class="ah-feature-body">Your journal entries, quiz scores, and progress stay yours. No selling, no surfacing.</p>
            </div>
            <div class="ah-feature-tile">
                <div class="ah-feature-icon bg-magenta"><i class="fa-regular fa-heart"></i></div>
                <h3 class="ah-feature-title">made for real life</h3>
                <p class="ah-feature-body">Built for students and young adults navigating exams, work, relationships, and a noisy world.</p>
            </div>
        </div>
    </section>

    <!-- ===== OUTRO CTA ===== -->
    <section class="home-outro">
        <div class="home-outro-inner">
            <h2>begin a quieter <span class="accent">five minutes</span> today.</h2>
            <p>Free, private, self-paced. The kindest thing you can do for yourself this week takes less time than scrolling.</p>
            <% if (Session["UserID"] == null) { %>
                <a href="Register.aspx" class="btn btn-primary btn-lg me-2">Create free account</a>
                <a href="Login.aspx" class="btn btn-outline-light btn-lg">Sign in</a>
            <% } else { %>
                <a href="User/UserHome.aspx" class="btn btn-primary btn-lg">Go to my dashboard</a>
            <% } %>
        </div>
    </section>

    <!-- ===== FOOTER ===== -->
    <footer class="landing-footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-5 col-lg-4">
                    <h6 style="margin-bottom: 16px; display:flex; align-items:center; gap:10px;">
                        <span style="width:32px;height:32px;border-radius:8px;background:var(--color-orange);display:inline-flex;align-items:center;justify-content:center;"><i class="fa-solid fa-brain"></i></span>
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
/* ===== Animated hero: cycling word ===== */
(function () {
    var words = document.querySelectorAll('#ahWords .ah-hero-word');
    if (!words.length) return;
    var active = 0;
    var INTERVAL = 2200;

    function step() {
        var prev = active;
        active = (active + 1) % words.length;
        words.forEach(function (w, i) {
            w.classList.remove('active', 'past');
            if (i === active) w.classList.add('active');
            else if (i === prev) w.classList.add('past');
        });
    }

    setInterval(step, INTERVAL);
})();

/* ===== Stat counter — count up when visible ===== */
(function () {
    var nums = document.querySelectorAll('.ah-stat-num');
    if (!nums.length || !('IntersectionObserver' in window)) return;

    function animate(el) {
        var raw = el.textContent.trim();
        // Match leading integer
        var m = raw.match(/^(\d+)/);
        if (!m) return;
        var target = parseInt(m[1], 10);
        var suffix = raw.substring(m[1].length);
        // Preserve a possible <span class="accent"> inside
        var accentMatch = el.querySelector('.accent');
        var accentText = accentMatch ? accentMatch.outerHTML : suffix;
        var dur = 900;
        var start = performance.now();
        function tick(now) {
            var p = Math.min(1, (now - start) / dur);
            var eased = 1 - Math.pow(1 - p, 3);
            var v = Math.round(target * eased);
            el.innerHTML = v + accentText;
            if (p < 1) requestAnimationFrame(tick);
        }
        requestAnimationFrame(tick);
    }

    var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (e) {
            if (e.isIntersecting) {
                animate(e.target);
                io.unobserve(e.target);
            }
        });
    }, { threshold: 0.4 });
    nums.forEach(function (n) { io.observe(n); });
})();
</script>
</asp:Content>
