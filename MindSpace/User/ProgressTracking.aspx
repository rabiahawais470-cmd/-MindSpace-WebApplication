<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProgressTracking.aspx.cs" Inherits="MindSpace.ProgressTracking" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dash-page progress-page">
        <div class="dash-banner progress-banner">
            <div class="d-flex flex-column flex-lg-row justify-content-between align-items-start align-items-lg-center gap-3">
                <div>
                    <h2>My Learning Progress</h2>
                    <p>Track your journey and celebrate each milestone without the clutter.</p>
                    <div class="progress-banner-meta">
                        <span><i class="fa-solid fa-chart-line"></i> Clear course tracking</span>
                        <span><i class="fa-solid fa-trophy"></i> Quiz performance at a glance</span>
                        <span><i class="fa-solid fa-comments"></i> Community contribution history</span>
                    </div>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <a href="UserHome.aspx" class="btn btn-light btn-sm">
                        <i class="fa-solid fa-table-cells-large me-1"></i>Dashboard
                    </a>
                    <a href="../Courses/CourseList.aspx" class="btn btn-outline-light btn-sm">
                        <i class="fa-solid fa-plus me-1"></i>Explore Courses
                    </a>
                </div>
            </div>
        </div>

        <div class="dash-stats-grid progress-stats-grid mb-4">
            <div class="dash-stat-card">
                <div class="dash-stat-head">
                    <div class="dash-stat-icon color-purple"><i class="fa-solid fa-percent"></i></div>
                    <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
                </div>
                <p class="dash-stat-label">Overall Progress</p>
                <p class="dash-stat-value"><asp:Literal ID="litOverallPct" runat="server">0</asp:Literal>%</p>
                <p class="dash-stat-change muted">Across all enrolled courses</p>
            </div>
            <div class="dash-stat-card">
                <div class="dash-stat-head">
                    <div class="dash-stat-icon color-green"><i class="fa-solid fa-clipboard-check"></i></div>
                    <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
                </div>
                <p class="dash-stat-label">Quizzes Taken</p>
                <p class="dash-stat-value"><asp:Literal ID="litQuizzesDone" runat="server">0</asp:Literal></p>
                <p class="dash-stat-change muted">Attempt history so far</p>
            </div>
            <div class="dash-stat-card">
                <div class="dash-stat-head">
                    <div class="dash-stat-icon color-blue"><i class="fa-solid fa-comments"></i></div>
                    <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
                </div>
                <p class="dash-stat-label">Forum Posts</p>
                <p class="dash-stat-value"><asp:Literal ID="litForumCount" runat="server">0</asp:Literal></p>
                <p class="dash-stat-change muted">Community contributions</p>
            </div>
            <div class="dash-stat-card">
                <div class="dash-stat-head">
                    <div class="dash-stat-icon color-orange"><i class="fa-regular fa-clock"></i></div>
                    <span class="dash-stat-trend"><i class="fa-solid fa-arrow-trend-up"></i></span>
                </div>
                <p class="dash-stat-label">Time on Platform</p>
                <p class="dash-stat-value"><asp:Literal ID="litHours" runat="server">0</asp:Literal>h</p>
                <p class="dash-stat-change muted">Estimated learning time</p>
            </div>
        </div>

        <div class="progress-layout">
            <div class="progress-main-stack">
                <div class="dash-panel progress-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Course Progress</h3>
                        <a class="dash-panel-link" href="../Courses/CourseList.aspx">Browse courses</a>
                    </div>

                    <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                        <div class="progress-empty-state">
                            <i class="fa-solid fa-book-open fa-2x"></i>
                            <p>You haven&rsquo;t enrolled in any courses yet.</p>
                            <a href="../Courses/CourseList.aspx" class="btn btn-primary btn-sm">Browse Courses</a>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptCourseProgress" runat="server">
                        <ItemTemplate>
                            <div class="progress-course-card">
                                <div class="progress-course-head">
                                    <div class="progress-course-icon"><i class="fa-solid fa-brain"></i></div>
                                    <div class="progress-course-meta">
                                        <div class="progress-course-topline">
                                            <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                                                <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                            </span>
                                            <span class="progress-course-status"><%# GetStatusBadge(Eval("IsCompleted"), Eval("Progress")) %></span>
                                        </div>
                                        <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" class="progress-course-title">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                        </a>
                                        <div class="progress-course-sub">
                                            <%# Eval("QuizzesPassed") %>/<%# Eval("TotalQuizzes") %> quizzes passed
                                            <span class="mx-1">&middot;</span>
                                            <%# Eval("Progress") %>% complete
                                        </div>
                                    </div>
                                    <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>" class="btn btn-sm btn-outline-primary progress-course-btn">
                                        <%# Convert.ToBoolean(Eval("IsCompleted")) ? "Review" : "Continue" %>
                                    </a>
                                </div>
                                <div class="progress mt-3" style="height: 7px;">
                                    <div class="progress-bar" style="width: <%# Eval("Progress") %>%;"></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="dash-panel progress-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Quiz Score History</h3>
                    </div>

                    <asp:Panel ID="pnlNoChart" runat="server">
                        <div class="progress-empty-state">
                            <i class="fa-solid fa-chart-column fa-2x"></i>
                            <p>Take your first quiz to see your score history here.</p>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlChart" runat="server" Visible="false">
                        <canvas id="quizScoreChart" class="progress-chart"></canvas>
                    </asp:Panel>

                    <asp:HiddenField ID="hdnChartData" runat="server" />
                </div>

                <div class="dash-panel progress-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Recent Activity</h3>
                    </div>

                    <asp:Panel ID="pnlNoActivity" runat="server" Visible="false">
                        <div class="progress-empty-state">
                            <i class="fa-solid fa-stream fa-2x"></i>
                            <p>No activity recorded yet. Start a course to build your timeline.</p>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptActivity" runat="server">
                        <ItemTemplate>
                            <div class="progress-timeline-item">
                                <div class="timeline-icon <%# System.Web.HttpUtility.HtmlEncode(Eval("IconClass").ToString()) %>">
                                    <i class="fa-solid <%# System.Web.HttpUtility.HtmlEncode(Eval("Icon").ToString()) %>"></i>
                                </div>
                                <div class="progress-timeline-body">
                                    <div class="timeline-title"><%# System.Web.HttpUtility.HtmlEncode(Eval("Label").ToString()) %></div>
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

                <div class="dash-panel progress-panel progress-next-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Next Up</h3>
                        <span class="progress-next-pill"><i class="fa-solid fa-bullseye"></i> Keep moving</span>
                    </div>
                    <div class="progress-next-list">
                        <div class="progress-next-item">
                            <div class="progress-next-icon"><i class="fa-solid fa-book-open"></i></div>
                            <div>
                                <strong>Finish a course</strong>
                                <p>Complete the course you are closest to finishing.</p>
                            </div>
                        </div>
                        <div class="progress-next-item">
                            <div class="progress-next-icon color-cyan"><i class="fa-solid fa-circle-check"></i></div>
                            <div>
                                <strong>Retake a quiz</strong>
                                <p>Lift your average by revisiting a score below 70%.</p>
                            </div>
                        </div>
                        <div class="progress-next-item">
                            <div class="progress-next-icon color-orange"><i class="fa-solid fa-comments"></i></div>
                            <div>
                                <strong>Post once</strong>
                                <p>Add one reply or post to keep your community activity active.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="dash-panel progress-panel progress-snapshot-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Learning snapshot</h3>
                        <span class="progress-next-pill"><i class="fa-solid fa-chart-pie"></i> At a glance</span>
                    </div>
                    <div class="progress-snapshot-grid">
                        <div class="progress-snapshot-item">
                            <span class="progress-snapshot-label">Average score</span>
                            <strong><asp:Literal ID="litSnapAvgScore" runat="server">&mdash;</asp:Literal></strong>
                            <small>Across your latest quiz results</small>
                        </div>
                        <div class="progress-snapshot-item">
                            <span class="progress-snapshot-label">Pass rate</span>
                            <strong><asp:Literal ID="litSnapPassRate" runat="server">&mdash;</asp:Literal></strong>
                            <small>Quiz results above the passing score</small>
                        </div>
                        <div class="progress-snapshot-item">
                            <span class="progress-snapshot-label">Quizzes passed</span>
                            <strong><asp:Literal ID="litSnapQuizzesPassed" runat="server">0</asp:Literal></strong>
                            <small>Successful quiz attempts so far</small>
                        </div>
                        <div class="progress-snapshot-item">
                            <span class="progress-snapshot-label">Time on platform</span>
                            <strong><asp:Literal ID="litSnapHours" runat="server">0</asp:Literal>h</strong>
                            <small>Estimated learning time</small>
                        </div>
                    </div>
                </div>

                <div class="dash-panel progress-panel progress-focus-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Focus this week</h3>
                    </div>
                    <div class="progress-focus-list">
                        <div class="progress-focus-item">
                            <div class="progress-focus-icon color-purple"><i class="fa-solid fa-book-open"></i></div>
                            <div>
                                <strong>Finish one module</strong>
                                <p>Move a course closer to completion before the week ends.</p>
                            </div>
                        </div>
                        <div class="progress-focus-item">
                            <div class="progress-focus-icon color-green"><i class="fa-solid fa-circle-check"></i></div>
                            <div>
                                <strong>Pass one quiz</strong>
                                <p>Retake a lower score and try to lift it above the pass mark.</p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="progress-side-stack">
                <div class="dash-panel progress-panel progress-score-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Quiz Performance</h3>
                    </div>
                    <div class="progress-score-wrap">
                        <div class="perf-score-circle">
                            <div class="perf-score-num"><asp:Literal ID="litAvgScore" runat="server">&mdash;</asp:Literal></div>
                            <div class="perf-score-lbl">Avg Score</div>
                        </div>
                    </div>
                    <div class="progress-metrics">
                        <div class="progress-metric-row">
                            <span>Best Score</span>
                            <strong><asp:Literal ID="litBestScore" runat="server">&mdash;</asp:Literal></strong>
                        </div>
                        <div class="progress-metric-row">
                            <span>Quizzes Passed</span>
                            <strong><asp:Literal ID="litQuizzesPassed" runat="server">0</asp:Literal></strong>
                        </div>
                        <div class="progress-metric-row">
                            <span>Pass Rate</span>
                            <strong><asp:Literal ID="litPassRate" runat="server">&mdash;</asp:Literal></strong>
                        </div>
                    </div>
                </div>

                <div class="dash-panel progress-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">vs. Class Average</h3>
                    </div>
                    <div class="progress-comparison">
                        <asp:Literal ID="litComparison" runat="server" />
                    </div>
                </div>

                <div class="dash-panel progress-panel progress-achievements-panel">
                    <div class="dash-panel-head">
                        <h3 class="dash-panel-title">Achievements</h3>
                    </div>
                    <asp:Literal ID="litAchievements" runat="server" />
                </div>
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
