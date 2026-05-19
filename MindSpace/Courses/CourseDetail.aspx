<%@ Page Title="Course Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="MindSpace.CourseDetail" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Hidden literal kept so backend's litIcon.Text assignment doesn't NRE; not displayed --%>
    <asp:Literal ID="litIcon" runat="server" Visible="false" />

    <!-- BREADCRUMB -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb" style="font-size: var(--text-sm); padding: 0;">
            <li class="breadcrumb-item"><a href="<%: ResolveUrl("~/User/UserHome.aspx") %>" style="color: var(--color-text-secondary);">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="<%: ResolveUrl("~/Courses/CourseList.aspx") %>" style="color: var(--color-text-secondary);">Courses</a></li>
            <li class="breadcrumb-item active" aria-current="page" style="color: var(--color-text-primary);">Course Detail</li>
        </ol>
    </nav>

    <asp:Panel ID="pnlMsg" runat="server" Visible="false">
        <div class="alert-ms-success mb-3">
            <i class="fa-solid fa-circle-check me-2"></i>
            <asp:Literal ID="litMsg" runat="server" />
        </div>
    </asp:Panel>

    <div class="row g-4">

        <!-- LEFT COLUMN -->
        <div class="col-lg-8">

            <!-- COURSE HERO with real photo (category-driven via JS) -->
            <div class="card mb-4 cd-hero-card">
                <div class="cd-hero-image" data-category-host>
                    <span class="cd-hero-tag" id="cdHeroBadge"></span>
                </div>
                <div class="cd-hero-body">
                    <div class="cd-hero-badge-mount"><asp:Literal ID="litCatBadge" runat="server" /></div>
                    <h2 class="cd-hero-title">
                        <asp:Literal ID="litCourseTitle" runat="server" />
                    </h2>
                    <p class="cd-hero-desc">
                        <asp:Literal ID="litCourseDesc" runat="server" />
                    </p>
                    <div class="cd-hero-meta">
                        <span><i class="fa-solid fa-signal me-2"></i><asp:Literal ID="litLevel" runat="server" /></span>
                        <span><i class="fa-regular fa-clock me-2"></i><asp:Literal ID="litDuration" runat="server" /></span>
                        <span><i class="fa-solid fa-users me-2"></i><asp:Literal ID="litEnrolled" runat="server" /> enrolled</span>
                    </div>
                </div>
            </div>

            <!-- COURSE MATERIALS — tabbed interface -->
            <div class="card cd-materials mb-4">
                <div class="cd-materials-head">
                    <span class="cd-eyebrow">Course Materials</span>
                    <h5>What you&rsquo;ll learn from</h5>
                </div>

                <div class="cd-tabs" role="tablist">
                    <button type="button" class="cd-tab active" data-tab="articles">
                        <i class="fa-regular fa-file-lines"></i>
                        <span>Articles</span>
                        <span class="cd-tab-count" data-count="articles">0</span>
                    </button>
                    <button type="button" class="cd-tab" data-tab="videos">
                        <i class="fa-regular fa-circle-play"></i>
                        <span>Videos</span>
                        <span class="cd-tab-count" data-count="videos">0</span>
                    </button>
                    <button type="button" class="cd-tab" data-tab="downloads">
                        <i class="fa-solid fa-download"></i>
                        <span>Worksheets</span>
                        <span class="cd-tab-count" data-count="downloads">0</span>
                    </button>
                </div>

                <div class="cd-tab-panels">
                    <div class="cd-tab-panel active" data-panel="articles">
                        <div class="cd-articles-list">
                            <div class="cd-empty" data-empty>
                                <i class="fa-regular fa-file-lines"></i>
                                <p>No articles available for this course yet.</p>
                            </div>
                        </div>
                    </div>
                    <div class="cd-tab-panel" data-panel="videos">
                        <div class="cd-videos-list">
                            <div class="cd-empty" data-empty>
                                <i class="fa-regular fa-circle-play"></i>
                                <p>No videos available for this course yet.</p>
                            </div>
                        </div>
                    </div>
                    <div class="cd-tab-panel" data-panel="downloads">
                        <div class="cd-downloads-list">
                            <div class="cd-empty" data-empty>
                                <i class="fa-solid fa-download"></i>
                                <p>No worksheets available for this course yet.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Hidden raw repeater (JS reads + distributes) -->
                <asp:Panel ID="pnlNoResources" runat="server" Visible="false" CssClass="cd-empty d-block">
                    <i class="fa-regular fa-folder-open"></i>
                    <p>No resources available for this course yet.</p>
                </asp:Panel>
                <div id="cdResourcesRaw" hidden>
                    <asp:Repeater ID="rptResources" runat="server">
                        <ItemTemplate>
                            <article class="cd-raw-resource"
                                     data-type='<%# Eval("ResourceType") %>'
                                     data-title='<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Title").ToString()) %>'
                                     data-url='<%# Eval("URL") %>'
                                     data-order='<%# Eval("OrderNum") %>'>
                                <div class="cd-raw-content"><%# Eval("Content") %></div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

        </div>

        <!-- RIGHT SIDEBAR -->
        <div class="col-lg-4">

            <!-- ENROLLMENT / METADATA -->
            <div class="card p-4 mb-3">
                <asp:Panel ID="pnlEnrollBtn" runat="server">
                    <asp:Button ID="btnEnroll" runat="server" Text="Enroll Now &mdash; Free"
                        CssClass="btn btn-primary btn-full mb-3" OnClick="btnEnroll_Click" />
                </asp:Panel>

                <asp:Panel ID="pnlEnrolled" runat="server" Visible="false">
                    <div class="text-center mb-3 p-3" style="background: var(--color-badge-beginner-bg); color: var(--color-badge-beginner-text); border-radius: var(--radius-md);">
                        <i class="fa-solid fa-circle-check me-1"></i> You&rsquo;re enrolled
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlLoginToEnroll" runat="server" Visible="false">
                    <a href="../Login.aspx" class="btn btn-primary btn-full mb-3">
                        <i class="fa-solid fa-right-to-bracket me-2"></i>Login to Enroll
                    </a>
                </asp:Panel>

                <asp:Panel ID="pnlProgress" runat="server" Visible="false">
                    <div class="d-flex justify-content-between small mb-1">
                        <span class="text-muted">Your Progress</span>
                        <span class="fw-bold"><asp:Literal ID="litProgressPct" runat="server" />%</span>
                    </div>
                    <div class="progress mb-3" style="height: 8px;">
                        <div id="courseProgressBar" runat="server" class="progress-bar"></div>
                    </div>
                </asp:Panel>

                <a href="../User/Discussions.aspx" class="btn btn-outline-secondary btn-full mt-2">
                    <i class="fa-regular fa-comments me-1"></i>Community Discussion
                </a>
            </div>

            <!-- QUIZZES -->
            <div class="card p-4 mb-3">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-circle-question me-2" style="color: var(--color-primary);"></i>Course Quizzes</h6>

                <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false">
                    <div class="text-center py-3 text-muted small">
                        <i class="fa-solid fa-clipboard fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                        No quizzes available yet.
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlLoginForQuiz" runat="server" Visible="false">
                    <div class="text-center py-3 text-muted small">
                        <i class="fa-solid fa-lock fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                        <a href="../Login.aspx" style="color: var(--color-primary);">Login</a> and enroll to take quizzes.
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptQuizzes" runat="server">
                    <ItemTemplate>
                        <div class="p-3 mb-2" style="background: var(--color-primary-light); border-radius: var(--radius-md);">
                            <div class="fw-semibold mb-1" style="font-size: var(--text-sm);"><%# Eval("Title") %></div>
                            <p class="text-muted small mb-2" style="font-size: 0.72rem;"><%# Eval("Description") %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted" style="font-size: 0.72rem;">Pass: <%# Eval("PassingScore") %>%</small>
                                <a href='<%: ResolveUrl("~/Courses/Quiz.aspx") %>?quizID=<%# Eval("QuizID") %>'
                                   class="btn btn-primary btn-sm">
                                    <i class="fa-solid fa-play me-1"></i>Start
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- CERTIFICATE -->
            <asp:Panel ID="pnlCertificate" runat="server" Visible="false">
                <div class="cert-panel">
                    <div class="cert-panel-header">
                        <i class="fa-solid fa-award cert-panel-icon"></i>
                        <div class="cert-panel-title">Certificate of Completion</div>
                        <div class="cert-panel-sub">MindSpace Mental Health Portal</div>
                    </div>
                    <div class="cert-panel-body">
                        <div class="cert-panel-label">This certifies that</div>
                        <div class="cert-panel-name"><asp:Literal ID="litCertName" runat="server" /></div>
                        <div class="cert-panel-label mt-1">has successfully completed</div>
                        <div class="cert-panel-course"><asp:Literal ID="litCertCourse" runat="server" /></div>
                        <div class="cert-panel-score mt-2">
                            <i class="fa-solid fa-star me-1" style="color: var(--color-warning);"></i>
                            Score: <asp:Literal ID="litCertScore" runat="server" />%
                        </div>
                        <hr style="margin: 0.75rem 0;" />
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="cert-panel-date">
                                <i class="fa-regular fa-calendar-check me-1"></i>
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

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
(function () {
    /* ---------- 1. Apply category class to the hero so its background-image loads ---------- */
    (function applyCategoryHero() {
        var badgeSpan = document.querySelector('.cd-hero-badge-mount .course-cat-badge');
        if (!badgeSpan) return;
        var catClass = Array.from(badgeSpan.classList).find(function (c) { return c.indexOf('cat-') === 0; });
        var hero = document.querySelector('.cd-hero-image');
        if (catClass && hero) hero.classList.add(catClass);
    })();

    /* ---------- 2. Author + date authors mapping by category ---------- */
    var BYLINE = {
        'cat-stress':      { author: 'Dr. Sarah Chen',     role: 'Clinical Editor' },
        'cat-mindfulness': { author: 'Dr. James Okafor',   role: 'Mindfulness Researcher' },
        'cat-anxiety':     { author: 'Dr. Maya Patel',     role: 'CBT Specialist' },
        'cat-sleep':       { author: 'Dr. Liam Hartwell',  role: 'Sleep Science Lead' },
        'cat-resilience':  { author: 'Dr. Anna Hoffman',   role: 'Resilience Researcher' },
        'cat-selfcare':    { author: 'Dr. Anika Joshi',    role: 'Wellbeing Editor' },
        'cat-cognitive':   { author: 'Dr. Rohan Mehta',    role: 'Cognitive Therapy Lead' },
        'cat-trauma':      { author: 'Dr. Elena Kowalski', role: 'Trauma Therapy Researcher' },
        'cat-regulation':  { author: 'Dr. Priya Iyer',     role: 'DBT Programme Director' },
        'cat-positive':    { author: 'Dr. Marcus Bennett', role: 'Positive Psychology Lead' }
    };
    var DEFAULT_BYLINE = { author: 'MindSpace Editorial Team', role: 'Reviewed by clinicians' };

    var courseCat = (function () {
        var b = document.querySelector('.cd-hero-badge-mount .course-cat-badge');
        if (!b) return '';
        var c = Array.from(b.classList).find(function (cls) { return cls.indexOf('cat-') === 0; });
        return c || '';
    })();

    function bylineFor(orderIndex) {
        var base = BYLINE[courseCat] || DEFAULT_BYLINE;
        // Offer two co-authors for second article on the same course so it doesn't look templated
        if (orderIndex === 1 && BYLINE[courseCat]) {
            return { author: BYLINE[courseCat].author, role: BYLINE[courseCat].role + ' &middot; Peer-reviewed' };
        }
        return base;
    }

    /* ---------- 3. Date generator (stable per article) ---------- */
    var MONTHS = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    function dateFor(orderNum, totalArticles) {
        // Spread articles over the past ~8 weeks. Earlier OrderNum = earlier date.
        var today = new Date();
        var daysBack = 7 + (orderNum * 14) + ((orderNum * 3) % 5);
        var d = new Date(today.getTime() - daysBack * 24 * 60 * 60 * 1000);
        return MONTHS[d.getMonth()] + ' ' + d.getDate() + ', ' + d.getFullYear();
    }

    /* ---------- 4. Reading time + summary helpers ---------- */
    function wordCount(text) {
        if (!text) return 0;
        return text.trim().split(/\s+/).length;
    }
    function readingTime(text) {
        var words = wordCount(text);
        var mins = Math.max(1, Math.round(words / 200));
        return mins + ' min read';
    }
    /* Detect a numbered list start anywhere in text — "(1) Foo" or "1. Foo" */
    var NUM_LIST_RE = /(^|[\s])(\(?\s?1\s?[\)\.])\s+([A-Z])/;
    function findNumberedStart(text) {
        var m = text.match(NUM_LIST_RE);
        if (!m) return -1;
        return text.indexOf(m[2]) + (m[1] && m[1].length ? 0 : 0);
    }

    function makeSummary(text, maxLen) {
        if (!text) return '';
        text = text.trim();
        // If the content contains a numbered list, prefer the intro text as summary
        var listStart = findNumberedStart(text);
        if (listStart > 0) {
            var intro = text.substring(0, listStart).trim();
            if (intro.length >= 50 && intro.length <= maxLen + 140) {
                intro = intro.replace(/[:;,]+$/, '').trim();
                if (!/[.!?]$/.test(intro)) intro += '.';
                return intro;
            }
        }
        if (text.length <= maxLen) return text;
        var cut = text.substr(0, maxLen);
        var lastPeriod = cut.lastIndexOf('. ');
        var lastSemi = cut.lastIndexOf('; ');
        var lastSpace = cut.lastIndexOf(' ');
        var bp = Math.max(lastPeriod, lastSemi);
        if (bp > maxLen * 0.6) return cut.substr(0, bp + 1);
        if (lastSpace > 0) return cut.substr(0, lastSpace) + '...';
        return cut + '...';
    }

    /* ---------- 5. Paragraph + numbered-list formatter ---------- */
    function paragraphify(text) {
        // Split into rough paragraphs of ~2 sentences each
        var pieces = text.split(/(?:\.\s+)(?=[A-Z])/g);
        var out = [];
        var buf = '';
        for (var i = 0; i < pieces.length; i++) {
            var seg = pieces[i].trim();
            if (!seg) continue;
            // Don't add a period if segment already ends with sentence-ending or list-introducing punctuation
            if (!/[.!?:;]$/.test(seg)) seg += '.';
            buf += (buf ? ' ' : '') + seg;
            if ((i + 1) % 2 === 0 || i === pieces.length - 1) {
                out.push(buf);
                buf = '';
            }
        }
        if (buf) out.push(buf);
        return out.map(function (p) { return '<p>' + p + '</p>'; }).join('');
    }

    function formatFullContent(text) {
        if (!text) return '';
        text = text.trim();

        var listStart = findNumberedStart(text);
        if (listStart < 0) {
            return paragraphify(text);
        }

        // Intro = everything before the first "(1)" / "1." marker
        var intro = text.substring(0, listStart).trim();

        // Locate trailing text AFTER the last numbered item — anything that doesn't fit the (N) pattern
        var listPart = text.substring(listStart);

        // Split listPart on boundaries before each numbered marker
        var rawItems = listPart.split(/(?:[;,.]\s*)(?=\(?\s?\d+\s?[\)\.]\s+[A-Z])/);

        var items = [];
        var trailing = '';

        for (var i = 0; i < rawItems.length; i++) {
            var seg = rawItems[i].trim();
            if (!seg) continue;
            var numMatch = seg.match(/^\(?\s?(\d+)\s?[\)\.]\s+([\s\S]+)$/);
            if (numMatch) {
                var content = numMatch[2].trim();
                content = content.replace(/[;]+$/, '').trim();
                if (!/[.!?]$/.test(content)) content += '.';
                items.push(content);
            } else if (items.length > 0) {
                // Text after the numbered list (e.g. closing sentence)
                var t = seg.replace(/^[;,.\s]+/, '').trim();
                if (!/[.!?]$/.test(t)) t += '.';
                trailing += (trailing ? ' ' : '') + t;
            } else {
                // Shouldn't happen — fall back to merge into intro
                intro = (intro + ' ' + seg).trim();
            }
        }

        var html = '';
        if (intro) {
            if (!/[.!?:]$/.test(intro)) intro += ':';
            html += paragraphify(intro);
        }
        if (items.length > 0) {
            html += '<ol class="cd-article-list">';
            items.forEach(function (item) {
                html += '<li>' + item + '</li>';
            });
            html += '</ol>';
        }
        if (trailing) {
            html += '<p>' + trailing + '</p>';
        }
        return html;
    }

    /* ---------- 6. Distribute raw resources into the right tab ---------- */
    var raw  = document.querySelectorAll('#cdResourcesRaw .cd-raw-resource');
    var articlesList  = document.querySelector('.cd-articles-list');
    var videosList    = document.querySelector('.cd-videos-list');
    var downloadsList = document.querySelector('.cd-downloads-list');

    var counts = { articles: 0, videos: 0, downloads: 0 };
    var totalArticles = Array.from(raw).filter(function (r) { return r.getAttribute('data-type') === 'article'; }).length;

    Array.from(raw).forEach(function (node, index) {
        var type     = (node.getAttribute('data-type') || '').toLowerCase();
        var title    = node.getAttribute('data-title') || '';
        var url      = node.getAttribute('data-url') || '';
        var orderRaw = parseInt(node.getAttribute('data-order') || '0', 10);
        var content  = (node.querySelector('.cd-raw-content') ? node.querySelector('.cd-raw-content').textContent : '').trim();

        if (type === 'article') {
            var byline    = bylineFor(counts.articles);
            var dateStr   = dateFor(counts.articles, totalArticles);
            var rt        = readingTime(content);
            var summary   = makeSummary(content, 240);
            var fullHtml  = formatFullContent(content);

            var card = document.createElement('article');
            card.className = 'cd-article-card';
            card.innerHTML =
                '<header class="cd-article-meta">' +
                '  <span class="meta-item"><i class="fa-regular fa-user"></i> ' + byline.author + '<span class="meta-role">&nbsp;&middot;&nbsp;' + byline.role + '</span></span>' +
                '  <span class="meta-item"><i class="fa-regular fa-calendar"></i> ' + dateStr + '</span>' +
                '  <span class="meta-item"><i class="fa-regular fa-clock"></i> ' + rt + '</span>' +
                '</header>' +
                '<h6 class="cd-article-title">' + title + '</h6>' +
                '<p class="cd-article-summary">' + summary + '</p>' +
                '<div class="cd-article-full" hidden>' + fullHtml + '</div>' +
                '<button type="button" class="cd-article-toggle">' +
                '  <span class="toggle-label-more">Read more</span>' +
                '  <span class="toggle-label-less" hidden>Show less</span>' +
                '  <i class="fa-solid fa-chevron-down"></i>' +
                '</button>';
            articlesList.appendChild(card);
            counts.articles++;
        }
        else if (type === 'video') {
            var safeUrl = (url || '').replace(/['"<>]/g, '');
            var vidCard = document.createElement('article');
            vidCard.className = 'cd-video-card';
            vidCard.innerHTML =
                '<div class="cd-video-meta"><i class="fa-regular fa-circle-play"></i>&nbsp; Featured talk</div>' +
                '<h6 class="cd-video-title">' + title + '</h6>' +
                (safeUrl ? '<div class="cd-video-embed"><iframe src="' + safeUrl + '?rel=0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen title="Video resource"></iframe></div>' : '') +
                (content ? '<p class="cd-video-desc">' + content + '</p>' : '');
            videosList.appendChild(vidCard);
            counts.videos++;
        }
        else if (type === 'download') {
            var dlCard = document.createElement('article');
            dlCard.className = 'cd-download-card';
            dlCard.innerHTML =
                '<div class="cd-download-icon"><i class="fa-solid fa-file-arrow-down"></i></div>' +
                '<div class="cd-download-body">' +
                '  <h6 class="cd-download-title">' + title + '</h6>' +
                (content ? '<p class="cd-download-desc">' + content + '</p>' : '') +
                '</div>' +
                '<div class="cd-download-action">' +
                (url ? '<a href="' + url + '" download class="btn btn-primary btn-sm"><i class="fa-solid fa-download me-1"></i>Download</a>' : '<span class="btn btn-outline-secondary btn-sm disabled">Coming soon</span>') +
                '</div>';
            downloadsList.appendChild(dlCard);
            counts.downloads++;
        }
    });

    /* ---------- 7. Update tab counts + empty states ---------- */
    document.querySelectorAll('[data-count]').forEach(function (el) {
        var key = el.getAttribute('data-count');
        el.textContent = counts[key];
        if (counts[key] === 0) el.classList.add('zero');
    });
    document.querySelectorAll('[data-panel]').forEach(function (panel) {
        var key = panel.getAttribute('data-panel');
        var empty = panel.querySelector('[data-empty]');
        if (counts[key] > 0 && empty) empty.remove();
    });

    /* ---------- 8. Tab switching ---------- */
    var tabs = document.querySelectorAll('.cd-tab');
    var panels = document.querySelectorAll('.cd-tab-panel');
    tabs.forEach(function (tab) {
        tab.addEventListener('click', function () {
            var target = tab.getAttribute('data-tab');
            tabs.forEach(function (t) { t.classList.remove('active'); });
            panels.forEach(function (p) { p.classList.remove('active'); });
            tab.classList.add('active');
            var panel = document.querySelector('[data-panel="' + target + '"]');
            if (panel) panel.classList.add('active');
        });
    });

    /* ---------- 9. Read more / less ---------- */
    document.addEventListener('click', function (ev) {
        var btn = ev.target.closest && ev.target.closest('.cd-article-toggle');
        if (!btn) return;
        var card = btn.closest('.cd-article-card');
        if (!card) return;
        var summary = card.querySelector('.cd-article-summary');
        var full    = card.querySelector('.cd-article-full');
        var more    = btn.querySelector('.toggle-label-more');
        var less    = btn.querySelector('.toggle-label-less');
        var chev    = btn.querySelector('.fa-chevron-down, .fa-chevron-up');
        var isOpen  = !full.hasAttribute('hidden');
        if (isOpen) {
            full.setAttribute('hidden', '');
            if (summary) summary.removeAttribute('hidden');
            more.removeAttribute('hidden');
            less.setAttribute('hidden', '');
            if (chev) chev.classList.replace('fa-chevron-up', 'fa-chevron-down');
        } else {
            full.removeAttribute('hidden');
            if (summary) summary.setAttribute('hidden', '');
            more.setAttribute('hidden', '');
            less.removeAttribute('hidden');
            if (chev) chev.classList.replace('fa-chevron-down', 'fa-chevron-up');
        }
    });
})();
</script>
</asp:Content>
