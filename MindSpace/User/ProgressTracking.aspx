<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProgressTracking.aspx.cs" Inherits="MindSpace.ProgressTracking" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ===== BANNER ===== -->
    <div class="dash-banner">
        <div class="container position-relative" style="z-index:2;">
            <div class="row align-items-center g-3">
                <div class="col">
                    <div class="hero-eyebrow mb-2"><span class="pulse"></span><span>Learning Analytics</span></div>
                    <h2 class="fw-bold mb-1" style="font-family:var(--font-display);font-size:1.75rem;letter-spacing:-0.03em;background:linear-gradient(135deg,#fff,#C7D2FE);-webkit-background-clip:text;background-clip:text;color:transparent;">
                        My Learning Progress
                    </h2>
                    <p class="mb-0" style="color:rgba(255,255,255,0.65);font-size:0.9rem;">
                        Track your journey and celebrate every milestone.
                    </p>
                </div>
                <div class="col-auto d-flex gap-2">
                    <a href="UserHome.aspx" class="btn btn-warning fw-bold btn-sm">
                        <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                    </a>
                    <a href="../Courses/CourseList.aspx" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-plus me-1"></i>Explore Courses
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-4">

        <!-- ===== STATS ROW ===== -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon purple"><i class="fas fa-percent"></i></div>
                    <div>
                        <div class="stat-num">
                            <asp:Literal ID="litOverallPct" runat="server">0</asp:Literal>%
                        </div>
                        <div class="stat-label">Overall Progress</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-clipboard-check"></i></div>
                    <div>
                        <div class="stat-num">
                            <asp:Literal ID="litQuizzesDone" runat="server">0</asp:Literal>
                        </div>
                        <div class="stat-label">Quizzes Taken</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-comments"></i></div>
                    <div>
                        <div class="stat-num">
                            <asp:Literal ID="litForumCount" runat="server">0</asp:Literal>
                        </div>
                        <div class="stat-label">Forum Contributions</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon orange"><i class="fas fa-clock"></i></div>
                    <div>
                        <div class="stat-num">
                            <asp:Literal ID="litHours" runat="server">0</asp:Literal>h
                        </div>
                        <div class="stat-label">Time on Platform</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">

            <!-- ============================== LEFT COLUMN ============================== -->
            <div class="col-lg-8">

                <!-- COURSE PROGRESS -->
                <div class="section-header mb-3">
                    <h5 class="fw-bold mb-0">
                        <i class="fas fa-book-open me-2 text-primary"></i>Course Progress
                    </h5>
                    <a href="../Courses/CourseList.aspx" class="small text-primary">Browse all &rarr;</a>
                </div>

                <asp:Panel ID="pnlNoCourses" runat="server" Visible="false">
                    <div class="ms-card p-4 text-center text-muted mb-4">
                        <i class="fas fa-book fa-3x mb-3 d-block" style="color:#ddd;"></i>
                        <p class="mb-2">You haven't enrolled in any courses yet.</p>
                        <a href="../Courses/CourseList.aspx" class="btn btn-primary btn-sm">Browse Courses</a>
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptCourseProgress" runat="server">
                    <ItemTemplate>
                        <div class="progress-course-card mb-3">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Category").ToString()) %>
                                    </span>
                                    <h6 class="fw-bold mb-0 mt-1">
                                        <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>"
                                           class="text-decoration-none" style="color:var(--ms-text);">
                                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %>
                                        </a>
                                    </h6>
                                </div>
                                <div>
                                    <%# GetStatusBadge(Eval("IsCompleted"), Eval("Progress")) %>
                                </div>
                            </div>

                            <div class="progress mb-2" style="height:10px;border-radius:50px;">
                                <div class="progress-bar" role="progressbar"
                                     style="width:<%# Eval("Progress") %>%;"
                                     aria-valuenow="<%# Eval("Progress") %>" aria-valuemin="0" aria-valuemax="100">
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <div class="small text-muted">
                                    <i class="fas fa-graduation-cap me-1 text-primary"></i>
                                    <%# Eval("QuizzesPassed") %>/<%# Eval("TotalQuizzes") %> quiz(zes) passed
                                    <span class="mx-1">&bull;</span>
                                    <i class="fas fa-check-circle me-1 text-secondary"></i>
                                    <%# Eval("Progress") %>% complete
                                    <span class="mx-1">&bull;</span>
                                    <i class="fas fa-calendar me-1"></i>
                                    Enrolled <%# Convert.ToDateTime(Eval("EnrollDate")).ToString("dd MMM yyyy") %>
                                </div>
                                <a href="../Courses/CourseDetail.aspx?id=<%# Eval("CourseID") %>"
                                   class="btn btn-sm btn-outline-primary flex-shrink-0 ms-2">
                                    <%# Convert.ToBoolean(Eval("IsCompleted")) ? "Review" : "Continue" %>
                                    <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- QUIZ SCORE CHART -->
                <div class="ms-card p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0">
                            <i class="fas fa-chart-bar me-2 text-primary"></i>Quiz Score History
                        </h6>
                        <a href="../Courses/CourseList.aspx" class="small text-primary">Take a quiz &rarr;</a>
                    </div>

                    <asp:Panel ID="pnlNoChart" runat="server">
                        <div class="text-center py-4 text-muted small">
                            <i class="fas fa-chart-bar fa-3x mb-3 d-block" style="color:#ddd;"></i>
                            Take your first quiz to see your score history here.
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlChart" runat="server" Visible="false">
                        <canvas id="quizScoreChart" style="max-height:280px;"></canvas>
                    </asp:Panel>

                    <asp:HiddenField ID="hdnChartData" runat="server" />
                </div>

                <!-- ACTIVITY TIMELINE -->
                <div class="ms-card p-4">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-history me-2 text-primary"></i>Recent Activity
                    </h6>

                    <asp:Panel ID="pnlNoActivity" runat="server" Visible="false">
                        <div class="text-center py-3 text-muted small">
                            <i class="fas fa-stream fa-2x mb-2 d-block" style="color:#ddd;"></i>
                            No activity recorded yet. Start a course!
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptActivity" runat="server">
                        <ItemTemplate>
                            <div class="timeline-item">
                                <div class="timeline-icon <%# System.Web.HttpUtility.HtmlEncode(Eval("IconClass").ToString()) %>">
                                    <i class="fas <%# System.Web.HttpUtility.HtmlEncode(Eval("Icon").ToString()) %>"></i>
                                </div>
                                <div class="timeline-body">
                                    <div class="timeline-title">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Label").ToString()) %>
                                    </div>
                                    <div class="timeline-meta">
                                        <%# System.Web.HttpUtility.HtmlEncode(Eval("Detail").ToString()) %>
                                        <span class="mx-1">&bull;</span>
                                        <%# Convert.ToDateTime(Eval("RecordedAt")).ToString("dd MMM yyyy, HH:mm") %>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>

            <!-- ============================== RIGHT COLUMN ============================== -->
            <div class="col-lg-4">

                <!-- QUIZ PERFORMANCE -->
                <div class="ms-card p-4 mb-4">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-star me-2 text-warning"></i>Quiz Performance
                    </h6>
                    <div class="text-center mb-3">
                        <div class="perf-score-circle">
                            <div class="perf-score-num">
                                <asp:Literal ID="litAvgScore" runat="server">—</asp:Literal>
                            </div>
                            <div class="perf-score-lbl">Avg Score</div>
                        </div>
                    </div>
                    <div class="small">
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span class="text-muted"><i class="fas fa-trophy me-1 text-warning"></i>Best Score</span>
                            <span class="fw-bold text-success"><asp:Literal ID="litBestScore" runat="server">—</asp:Literal></span>
                        </div>
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span class="text-muted"><i class="fas fa-check-circle me-1 text-success"></i>Quizzes Passed</span>
                            <span class="fw-bold text-primary"><asp:Literal ID="litQuizzesPassed" runat="server">0</asp:Literal></span>
                        </div>
                        <div class="d-flex justify-content-between py-2">
                            <span class="text-muted"><i class="fas fa-percent me-1 text-primary"></i>Pass Rate</span>
                            <span class="fw-bold"><asp:Literal ID="litPassRate" runat="server">—</asp:Literal></span>
                        </div>
                    </div>
                </div>

                <!-- CLASS COMPARISON -->
                <div class="ms-card p-4 mb-4">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-users me-2 text-primary"></i>vs. Class Average
                    </h6>
                    <asp:Literal ID="litComparison" runat="server" />
                </div>

                <!-- ACHIEVEMENTS -->
                <div class="ms-card p-4">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-trophy me-2 text-warning"></i>Achievements
                    </h6>
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
                    backgroundColor: data.scores.map(function (s) {
                        return s >= 70 ? 'rgba(0,184,148,0.75)' : 'rgba(225,112,85,0.75)';
                    }),
                    borderColor: data.scores.map(function (s) {
                        return s >= 70 ? '#00B894' : '#E17055';
                    }),
                    borderWidth: 1.5,
                    borderRadius: 6,
                    order: 1
                },
                {
                    label: 'Passing threshold (70%)',
                    data: data.labels.map(function () { return 70; }),
                    type: 'line',
                    borderColor: '#6C5CE7',
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
                legend: {
                    position: 'top',
                    labels: { font: { family: 'Poppins', size: 11 }, boxWidth: 14 }
                },
                tooltip: {
                    callbacks: {
                        label: function (ctx) {
                            return ctx.dataset.label + ': ' + ctx.parsed.y + '%';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    ticks: {
                        callback: function (v) { return v + '%'; },
                        font: { family: 'Poppins', size: 11 }
                    },
                    grid: { color: 'rgba(0,0,0,0.05)' }
                },
                x: {
                    ticks: {
                        maxRotation: 25,
                        font: { family: 'Poppins', size: 10 }
                    },
                    grid: { display: false }
                }
            }
        }
    });
});
</script>
</asp:Content>
