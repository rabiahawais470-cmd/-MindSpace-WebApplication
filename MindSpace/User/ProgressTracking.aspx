<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProgressTracking.aspx.cs" Inherits="MindSpace.ProgressTracking" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== HEADER ===== -->
    <div class="dash-banner">
        <div class="row align-items-center g-3">
            <div class="col">
                <h2>My Learning Progress</h2>
                <p>Track your journey and celebrate every milestone.</p>
            </div>
            <div class="col-auto d-flex gap-2 flex-wrap">
                <a href="UserHome.aspx" class="btn btn-light btn-sm">
                    <i class="fa-solid fa-table-cells-large me-1"></i>Dashboard
                </a>
                <a href="../Courses/CourseList.aspx" class="btn btn-outline-light btn-sm">
                    <i class="fa-solid fa-plus me-1"></i>Explore Courses
                </a>
            </div>
        </div>
    </div>

    <!-- ===== STATS ROW (HighlightCards) ===== -->
    <div class="row g-4 mb-5">
        <div class="col-md-6 col-lg-3">
            <div class="ms-highlight-card hc-violet anim-fade-up">
                <span class="hc-bookmark"><i class="fa-solid fa-percent"></i></span>
                <h3 class="hc-title">overall progress</h3>
                <p class="hc-desc">Your aggregated learning completion across every enrolled course.</p>
                <div class="hc-divider"></div>
                <div class="hc-bottom">
                    <div>
                        <div class="hc-metric"><asp:Literal ID="litOverallPct" runat="server">0</asp:Literal>%</div>
                        <div class="hc-metric-label">Across all courses</div>
                    </div>
                    <a href="../Courses/CourseList.aspx" class="hc-btn">See all</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="ms-highlight-card hc-green anim-fade-up anim-delay-1">
                <span class="hc-bookmark"><i class="fa-solid fa-clipboard-check"></i></span>
                <h3 class="hc-title">quizzes taken</h3>
                <p class="hc-desc">Total quizzes you have attempted across your enrolled courses.</p>
                <div class="hc-divider"></div>
                <div class="hc-bottom">
                    <div>
                        <div class="hc-metric"><asp:Literal ID="litQuizzesDone" runat="server">0</asp:Literal></div>
                        <div class="hc-metric-label">This learning cycle</div>
                    </div>
                    <a href="../Courses/CourseList.aspx" class="hc-btn">Practice</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="ms-highlight-card hc-blue anim-fade-up anim-delay-2">
                <span class="hc-bookmark"><i class="fa-solid fa-comments"></i></span>
                <h3 class="hc-title">forum posts</h3>
                <p class="hc-desc">Contributions you have shared with the community discussion.</p>
                <div class="hc-divider"></div>
                <div class="hc-bottom">
                    <div>
                        <div class="hc-metric"><asp:Literal ID="litForumCount" runat="server">0</asp:Literal></div>
                        <div class="hc-metric-label">Total contributions</div>
                    </div>
                    <a href="Forum.aspx" class="hc-btn">Visit</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="ms-highlight-card hc-orange anim-fade-up anim-delay-3">
                <span class="hc-bookmark"><i class="fa-regular fa-clock"></i></span>
                <h3 class="hc-title">time on platform</h3>
                <p class="hc-desc">Total time you have spent learning during this period.</p>
                <div class="hc-divider"></div>
                <div class="hc-bottom">
                    <div>
                        <div class="hc-metric"><asp:Literal ID="litHours" runat="server">0</asp:Literal>h</div>
                        <div class="hc-metric-label">Daily average tracked</div>
                    </div>
                    <a href="UserHome.aspx" class="hc-btn">Dashboard</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <!-- LEFT COLUMN -->
        <div class="col-lg-8">

            <!-- COURSE PROGRESS -->
            <div class="section-header">
                <h6 class="fw-bold mb-0">Course Progress</h6>
                <a href="../Courses/CourseList.aspx" style="font-size: var(--text-sm); color: var(--color-primary);">Browse all &rarr;</a>
            </div>

            <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                <div class="card p-4 text-center text-muted mb-3">
                    <i class="fa-solid fa-book fa-3x mb-3" style="color: #E5E7EB;"></i>
                    <p class="mb-3">You haven&rsquo;t enrolled in any courses yet.</p>
                    <a href="../Courses/CourseList.aspx" class="btn btn-primary btn-sm">Browse Courses</a>
                </div>
            </asp:Panel>

            <asp:Repeater ID="rptCourseProgress" runat="server">
                <ItemTemplate>
                    <div class="progress-course-card mb-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="rounded-2 d-flex align-items-center justify-content-center"
                                 style="width: 48px; height: 48px; background: var(--color-primary-light); color: var(--color-primary); border-radius: var(--radius-md); font-size: 1.25rem; flex-shrink: 0;">
                                <i class="fa-solid fa-brain"></i>
                            </div>
                            <div style="flex: 1; min-width: 0;">
                                <div class="d-flex justify-content-between align-items-start gap-2 mb-1 flex-wrap">
                                    <div>
                                        <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                        </span>
                                        <div class="fw-semibold mt-1" style="font-size: var(--text-sm);">
                                            <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" style="color: var(--color-text-primary);">
                                                <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                            </a>
                                        </div>
                                    </div>
                                    <div>
                                        <%# GetStatusBadge(Eval("IsCompleted"), Eval("Progress")) %>
                                    </div>
                                </div>
                                <div class="progress mt-2" style="height: 6px;">
                                    <div class="progress-bar" style="width: <%# Eval("Progress") %>%;"></div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-2 flex-wrap gap-2">
                                    <div class="text-muted" style="font-size: 0.72rem;">
                                        <i class="fa-solid fa-graduation-cap me-1"></i><%# Eval("QuizzesPassed") %>/<%# Eval("TotalQuizzes") %> quizzes passed
                                        <span class="mx-1">&middot;</span>
                                        <%# Eval("Progress") %>% complete
                                    </div>
                                    <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" class="btn btn-sm btn-outline-primary">
                                        <%# Convert.ToBoolean(Eval("IsCompleted")) ? "Review" : "Continue" %>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- QUIZ SCORE CHART -->
            <div class="card p-4 mb-4 mt-4">
                <div class="section-header mb-3" style="margin-bottom: 0;">
                    <h6 class="fw-bold mb-0"><i class="fa-solid fa-chart-bar me-2" style="color: var(--color-primary);"></i>Quiz Score History</h6>
                    <a href="../Courses/CourseList.aspx" style="font-size: var(--text-sm); color: var(--color-primary);">Take a quiz &rarr;</a>
                </div>

                <asp:Panel ID="pnlNoChart" runat="server">
                    <div class="text-center py-4 text-muted small">
                        <i class="fa-solid fa-chart-bar fa-3x mb-3 d-block" style="color: #E5E7EB;"></i>
                        Take your first quiz to see your score history here.
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlChart" runat="server" Visible="false">
                    <canvas id="quizScoreChart" style="max-height: 280px;"></canvas>
                </asp:Panel>

                <asp:HiddenField ID="hdnChartData" runat="server" />
            </div>

            <!-- ACTIVITY TIMELINE -->
            <div class="card p-4">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-history me-2" style="color: var(--color-primary);"></i>Recent Activity</h6>

                <asp:Panel ID="pnlNoActivity" runat="server" Visible="false">
                    <div class="text-center py-3 text-muted small">
                        <i class="fa-solid fa-stream fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>
                        No activity recorded yet. Start a course!
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptActivity" runat="server">
                    <ItemTemplate>
                        <div class="timeline-item">
                            <div class="timeline-icon <%# System.Web.HttpUtility.HtmlEncode(Eval("IconClass").ToString()) %>">
                                <i class="fa-solid <%# System.Web.HttpUtility.HtmlEncode(Eval("Icon").ToString()) %>"></i>
                            </div>
                            <div style="flex: 1; min-width: 0;">
                                <div class="timeline-title">
                                    <%# System.Web.HttpUtility.HtmlEncode(Eval("Label").ToString()) %>
                                </div>
                                <div class="timeline-meta">
                                    <%# System.Web.HttpUtility.HtmlEncode(Eval("Detail").ToString()) %>
                                    <span class="mx-1">&middot;</span>
                                    <%# Convert.ToDateTime(Eval("RecordedAt")).ToString("dd MMM yyyy, HH:mm") %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </div>

        <!-- RIGHT COLUMN -->
        <div class="col-lg-4">

            <!-- QUIZ PERFORMANCE -->
            <div class="card p-4 mb-3">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-star me-2" style="color: var(--color-warning);"></i>Quiz Performance</h6>
                <div class="text-center mb-3">
                    <div class="perf-score-circle">
                        <div class="perf-score-num"><asp:Literal ID="litAvgScore" runat="server">&mdash;</asp:Literal></div>
                        <div class="perf-score-lbl">Avg Score</div>
                    </div>
                </div>
                <div style="font-size: var(--text-sm);">
                    <div class="d-flex justify-content-between py-2" style="border-bottom: 1px solid var(--color-card-border);">
                        <span class="text-muted"><i class="fa-solid fa-trophy me-1" style="color: var(--color-warning);"></i>Best Score</span>
                        <span class="fw-bold" style="color: var(--color-success);"><asp:Literal ID="litBestScore" runat="server">&mdash;</asp:Literal></span>
                    </div>
                    <div class="d-flex justify-content-between py-2" style="border-bottom: 1px solid var(--color-card-border);">
                        <span class="text-muted"><i class="fa-solid fa-circle-check me-1" style="color: var(--color-success);"></i>Quizzes Passed</span>
                        <span class="fw-bold" style="color: var(--color-primary);"><asp:Literal ID="litQuizzesPassed" runat="server">0</asp:Literal></span>
                    </div>
                    <div class="d-flex justify-content-between py-2">
                        <span class="text-muted"><i class="fa-solid fa-percent me-1" style="color: var(--color-primary);"></i>Pass Rate</span>
                        <span class="fw-bold"><asp:Literal ID="litPassRate" runat="server">&mdash;</asp:Literal></span>
                    </div>
                </div>
            </div>

            <!-- CLASS COMPARISON -->
            <div class="card p-4 mb-3">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-users me-2" style="color: var(--color-primary);"></i>vs. Class Average</h6>
                <asp:Literal ID="litComparison" runat="server" />
            </div>

            <!-- ACHIEVEMENTS BADGE GRID -->
            <div class="card p-4">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-trophy me-2" style="color: var(--color-warning);"></i>Achievements</h6>
                <asp:Literal ID="litAchievements" runat="server" />
            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    var hdnData = document.getElementById('<%: hdnChartData.ClientID %>');
    if (!hdnData || !hdnData.value) return;

    var data;
    try { data = JSON.parse(hdnData.value); } catch (e) { return; }
    if (!data || !data.labels || data.labels.length === 0) return;

    var ctx = document.getElementById('quizScoreChart');
    if (!ctx) return;

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data.labels,
            datasets: [
                {
                    label: 'Your Score (%)',
                    data: data.scores,
                    backgroundColor: data.scores.map(function (s) { return s >= 70 ? '#10B981' : '#EF4444'; }),
                    borderRadius: 6,
                    order: 1
                },
                {
                    label: 'Passing threshold (70%)',
                    data: data.labels.map(function () { return 70; }),
                    type: 'line',
                    borderColor: '#7C6FCD',
                    borderDash: [6, 4],
                    borderWidth: 2,
                    pointRadius: 0,
                    fill: false,
                    order: 0
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top', labels: { font: { family: 'Inter', size: 11 }, boxWidth: 14 } },
                tooltip: { callbacks: { label: function (c) { return c.dataset.label + ': ' + c.parsed.y + '%'; } } }
            },
            scales: {
                y: {
                    beginAtZero: true, max: 100,
                    ticks: { callback: function (v) { return v + '%'; }, font: { family: 'Inter', size: 11 } },
                    grid: { color: 'rgba(124,111,205,0.08)' }
                },
                x: {
                    ticks: { maxRotation: 25, font: { family: 'Inter', size: 10 } },
                    grid: { display: false }
                }
            }
        }
    });
});
</script>
</asp:Content>
