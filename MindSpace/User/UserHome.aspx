<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="MindSpace.UserHome" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="dash-page">

    <!-- ====== HEADER ====== -->
    <div class="dash-header">
        <div>
            <h1 class="dash-header-title">dashboard</h1>
            <p class="dash-header-sub">Welcome back, <asp:Literal ID="litWelcome" runat="server" /> &mdash; member since <asp:Literal ID="litMemberSince" runat="server" />.</p>
        </div>
        <div class="dash-header-actions">
            <a class="dash-icon-btn" href="../Courses/CourseList.aspx" title="Browse courses">
                <i class="fa-regular fa-bell"></i>
                <span class="dot"></span>
            </a>
            <a class="dash-icon-btn" href="Profile.aspx" title="Profile">
                <i class="fa-regular fa-user"></i>
            </a>
        </div>
    </div>

    <!-- ====== STAT CARDS (4) ====== -->
    <div class="dash-stats-grid">
        <div class="dash-stat-card">
            <div class="dash-stat-head">
                <div class="dash-stat-icon color-blue"><i class="fa-solid fa-book-open"></i></div>
                <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
            </div>
            <p class="dash-stat-label">Enrolled</p>
            <p class="dash-stat-value"><asp:Literal ID="litEnrolled" runat="server">0</asp:Literal></p>
            <p class="dash-stat-change muted">Courses you&rsquo;re currently learning</p>
        </div>

        <div class="dash-stat-card">
            <div class="dash-stat-head">
                <div class="dash-stat-icon color-green"><i class="fa-solid fa-circle-check"></i></div>
                <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
            </div>
            <p class="dash-stat-label">Completed</p>
            <p class="dash-stat-value"><asp:Literal ID="litCompleted" runat="server">0</asp:Literal></p>
            <p class="dash-stat-change">Keep the streak going</p>
        </div>

        <div class="dash-stat-card">
            <div class="dash-stat-head">
                <div class="dash-stat-icon color-purple"><i class="fa-solid fa-clipboard-check"></i></div>
                <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
            </div>
            <p class="dash-stat-label">Quizzes Taken</p>
            <p class="dash-stat-value"><asp:Literal ID="litQuizzesTaken" runat="server">0</asp:Literal></p>
            <p class="dash-stat-change muted">Across all your courses</p>
        </div>

        <div class="dash-stat-card">
            <div class="dash-stat-head">
                <div class="dash-stat-icon color-orange"><i class="fa-regular fa-comments"></i></div>
                <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
            </div>
            <p class="dash-stat-label">Forum Posts</p>
            <p class="dash-stat-value"><asp:Literal ID="litForumPosts" runat="server">0</asp:Literal></p>
            <p class="dash-stat-change muted">Your community contributions</p>
        </div>
    </div>

    <!-- ====== BODY: ACTIVITY (left) + QUICK STATS / TOP COURSES (right) ====== -->
    <div class="dash-body-grid">

        <!-- LEFT: Recent Activity -->
        <div class="dash-panel">
            <div class="dash-panel-head">
                <h3 class="dash-panel-title">recent activity</h3>
                <a class="dash-panel-link" href="ProgressTracking.aspx">View all</a>
            </div>

            <asp:Panel ID="pnlNoActivity" runat="server" Visible="false">
                <div class="text-center py-4 text-muted">
                    <i class="fa-regular fa-comment fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                    <p class="mb-2 small">No recent activity yet.</p>
                    <a href="Discussions.aspx" class="dash-panel-link">Join a conversation &rarr;</a>
                </div>
            </asp:Panel>

            <div class="dash-activity-list">
                <asp:Repeater ID="rptActivity" runat="server">
                    <ItemTemplate>
                        <a class="dash-activity-item" href="Discussions.aspx">
                            <div class='dash-activity-icon <%# Eval("ActivityType").ToString() == "post" ? "color-purple" : "color-cyan" %>'>
                                <i class='fa-solid <%# Eval("ActivityType").ToString() == "post" ? "fa-pen" : "fa-reply" %>'></i>
                            </div>
                            <div class="dash-activity-body">
                                <p class="dash-activity-title"><%# System.Web.HttpUtility.HtmlEncode(Eval("Label").ToString()) %></p>
                                <p class="dash-activity-desc">
                                    <%# Eval("ActivityType").ToString() == "post" ? "New discussion" : "Reply in: " + System.Web.HttpUtility.HtmlEncode(Convert.ToString(Eval("Context"))) %>
                                </p>
                            </div>
                            <span class="dash-activity-time"><%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM") %></span>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Repeater ID="rptQuizResults" runat="server">
                    <ItemTemplate>
                        <a class="dash-activity-item" href="ProgressTracking.aspx">
                            <div class='dash-activity-icon <%# Convert.ToDecimal(Eval("Percentage")) >= 70 ? "color-green" : "color-orange" %>'>
                                <i class="fa-solid fa-clipboard-check"></i>
                            </div>
                            <div class="dash-activity-body">
                                <p class="dash-activity-title"><%# System.Web.HttpUtility.HtmlEncode(Eval("QuizTitle").ToString()) %></p>
                                <p class="dash-activity-desc">Scored <%# Eval("Score") %>/<%# Eval("TotalQuestions") %> &middot; <%# string.Format("{0:0}%", Eval("Percentage")) %></p>
                            </div>
                            <span class="dash-activity-time"><%# Convert.ToDateTime(Eval("DateTaken")).ToString("dd MMM") %></span>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false">
                    <%-- Empty state for quizzes; hidden by code-behind when results exist --%>
                </asp:Panel>
            </div>
        </div>

        <!-- RIGHT: Quick Stats + My Courses -->
        <div>
            <div class="dash-panel" style="margin-bottom: 24px;">
                <div class="dash-panel-head">
                    <h3 class="dash-panel-title">quick stats</h3>
                </div>
                <div class="dash-progress-row">
                    <div class="dash-progress-label">
                        <span class="left">Courses completed</span>
                        <span class="right" id="qsCompletedVal">0%</span>
                    </div>
                    <div class="dash-progress-track">
                        <div class="dash-progress-fill color-green" id="qsCompletedBar" style="width: 0%;"></div>
                    </div>
                </div>
                <div class="dash-progress-row">
                    <div class="dash-progress-label">
                        <span class="left">Quizzes taken</span>
                        <span class="right" id="qsQuizzesVal">0%</span>
                    </div>
                    <div class="dash-progress-track">
                        <div class="dash-progress-fill color-purple" id="qsQuizzesBar" style="width: 0%;"></div>
                    </div>
                </div>
                <div class="dash-progress-row">
                    <div class="dash-progress-label">
                        <span class="left">Community involvement</span>
                        <span class="right" id="qsCommunityVal">0%</span>
                    </div>
                    <div class="dash-progress-track">
                        <div class="dash-progress-fill color-orange" id="qsCommunityBar" style="width: 0%;"></div>
                    </div>
                </div>
            </div>

            <div class="dash-panel">
                <div class="dash-panel-head">
                    <h3 class="dash-panel-title">my courses</h3>
                    <a class="dash-panel-link" href="../Courses/CourseList.aspx">View all</a>
                </div>
                <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                    <div class="text-center py-3 text-muted small">
                        <i class="fa-solid fa-book fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                        <p class="mb-2">You haven&rsquo;t enrolled in any courses yet.</p>
                        <a href="../Courses/CourseList.aspx" class="btn btn-primary btn-sm">Browse Courses</a>
                    </div>
                </asp:Panel>
                <div class="dash-top-list">
                    <asp:Repeater ID="rptEnrolled" runat="server">
                        <ItemTemplate>
                            <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" class="dash-top-row" style="text-decoration: none;">
                                <span class="label" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 70%;">
                                    <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                </span>
                                <span class="val"><%# Eval("Progress") %>%</span>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

    <%-- Hidden / kept-for-backend literals (wrapped so server-side Visible toggles still don't leak text) --%>
    <div style="display: none !important;" aria-hidden="true">
        <asp:Literal ID="litAvatarInitial" runat="server" />
        <asp:Literal ID="litProfileInitial" runat="server" />
        <asp:Literal ID="litProfileName" runat="server" />
        <asp:Literal ID="litProfileUsername" runat="server" />
        <asp:Panel ID="pnlBio" runat="server">
            <asp:Literal ID="litProfileBio" runat="server" />
        </asp:Panel>
        <asp:Literal ID="litAchievements" runat="server" />
        <asp:Panel ID="pnlCertificates" runat="server">
            <asp:Literal ID="litCertCount" runat="server" />
            <asp:Repeater ID="rptCertificates" runat="server"></asp:Repeater>
        </asp:Panel>
    </div>

</div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ===== Quick Stats: compute progress percentages from stat-card values ===== */
(function () {
    function toInt(el) {
        if (!el) return 0;
        var t = (el.textContent || '').replace(/[^0-9]/g, '');
        return parseInt(t || '0', 10);
    }
    var values = document.querySelectorAll('.dash-stat-value');
    if (values.length < 4) return;
    var enrolled    = toInt(values[0]);
    var completed   = toInt(values[1]);
    var quizzes     = toInt(values[2]);
    var forumPosts  = toInt(values[3]);

    var completedPct  = enrolled > 0 ? Math.round((completed / enrolled) * 100) : 0;
    // Soft scale: 6 quizzes = 100% (3 quizzes per course on a 2-course pace)
    var quizzesPct    = Math.min(100, Math.round((quizzes / 6) * 100));
    // Soft scale: 10 forum interactions = 100%
    var communityPct  = Math.min(100, Math.round((forumPosts / 10) * 100));

    function set(barId, valId, pct) {
        var bar = document.getElementById(barId);
        var val = document.getElementById(valId);
        if (bar) { setTimeout(function () { bar.style.width = pct + '%'; }, 80); }
        if (val) { val.textContent = pct + '%'; }
    }
    set('qsCompletedBar', 'qsCompletedVal', completedPct);
    set('qsQuizzesBar',   'qsQuizzesVal',   quizzesPct);
    set('qsCommunityBar', 'qsCommunityVal', communityPct);
})();
</script>
</asp:Content>
