<%@ Page Title="Browse Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="MindSpace.CourseList" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- HEADER -->
    <div class="cl-header">
        <h2 class="cl-header-title">Access mental health education <span class="cl-header-accent">designed for you</span></h2>
        <p class="cl-header-sub">Short, evidence-based courses across six wellness topics &mdash; built for real life.</p>
    </div>

    <!-- VISUAL CATEGORY STRIP -->
    <div class="cl-cat-strip">
        <a href="javascript:void(0)" class="cl-cat-chip all" data-cat=""><span class="cl-cat-chip-name">All Topics</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-stress" data-cat="Stress Management"><span class="cl-cat-chip-name">Stress</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-mindfulness" data-cat="Mindfulness"><span class="cl-cat-chip-name">Mindfulness</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-anxiety" data-cat="Anxiety"><span class="cl-cat-chip-name">Anxiety</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-sleep" data-cat="Sleep Hygiene"><span class="cl-cat-chip-name">Sleep</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-resilience" data-cat="Resilience"><span class="cl-cat-chip-name">Resilience</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-selfcare" data-cat="Self-Care"><span class="cl-cat-chip-name">Self-Care</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-cognitive" data-cat="Cognitive Therapy"><span class="cl-cat-chip-name">Cognitive Therapy</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-trauma" data-cat="Trauma Recovery"><span class="cl-cat-chip-name">Trauma</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-regulation" data-cat="Emotional Regulation"><span class="cl-cat-chip-name">Emotional Regulation</span></a>
        <a href="javascript:void(0)" class="cl-cat-chip cat-positive" data-cat="Positive Psychology"><span class="cl-cat-chip-name">Positive Psychology</span></a>
    </div>

    <!-- INLINE FILTER BAR -->
    <div class="cl-filter-bar">
        <div class="input-wrap">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search courses by title or keyword..." />
        </div>
        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select" style="max-width:220px;"
                AutoPostBack="true" OnSelectedIndexChanged="btnSearch_Click">
            <asp:ListItem Value="">All Categories</asp:ListItem>
            <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
            <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
            <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
            <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
            <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
            <asp:ListItem Value="Self-Care">Self-Care</asp:ListItem>
            <asp:ListItem Value="Cognitive Therapy">Cognitive Therapy</asp:ListItem>
            <asp:ListItem Value="Trauma Recovery">Trauma Recovery</asp:ListItem>
            <asp:ListItem Value="Emotional Regulation">Emotional Regulation</asp:ListItem>
            <asp:ListItem Value="Positive Psychology">Positive Psychology</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select" style="max-width:160px;"
                AutoPostBack="true" OnSelectedIndexChanged="btnSearch_Click">
            <asp:ListItem Value="">All Levels</asp:ListItem>
            <asp:ListItem Value="Beginner">Beginner</asp:ListItem>
            <asp:ListItem Value="Intermediate">Intermediate</asp:ListItem>
            <asp:ListItem Value="Advanced">Advanced</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
            CausesValidation="false" OnClick="btnSearch_Click" />
        <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-outline-secondary"
            CausesValidation="false" OnClick="btnClear_Click" />
    </div>

    <!-- COUNT -->
    <div class="cl-grid-header">
        <h6 class="fw-bold mb-0" style="font-family: var(--font-heading);">All Courses</h6>
        <span class="cl-grid-header-count">
            <strong><asp:Literal ID="litCount" runat="server" /></strong> course<span>(s)</span>
        </span>
    </div>

    <!-- COURSE GRID (wider, more breathing room) -->
    <asp:Repeater ID="rptCourses" runat="server">
        <HeaderTemplate>
            <div class="cl-grid">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="course-card">
                <div class="course-card-cover cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                    <div style="position:absolute; bottom:14px; left:14px; right:14px; z-index:2; display:flex; justify-content:space-between; align-items:end;">
                        <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>" style="background:rgba(255,255,255,0.95); color:var(--color-text-primary);">
                            <%# Eval("Category") %>
                        </span>
                        <span style="background:rgba(28,28,46,0.75); color:#fff; padding:4px 10px; border-radius:99px; font-size:0.7rem; font-weight:600; backdrop-filter:blur(8px);">
                            <%# Eval("DifficultyLevel") %>
                        </span>
                    </div>
                </div>
                <div class="course-card-body">
                    <div class="course-card-meta-top">
                        <i class="fa-solid fa-users"></i>
                        <span><%# Eval("EnrollmentCount") %> enrolled</span>
                        <i class="fa-regular fa-clock star" style="color:var(--color-text-secondary);"></i>
                        <span><%# Eval("Duration") %></span>
                    </div>
                    <h6 class="course-card-title"><%# Eval("Title") %></h6>
                    <p class="course-card-desc"><%# Eval("Description") %></p>
                    <div class="course-card-footer-row" style="justify-content:space-between;">
                        <%# Convert.ToBoolean(Eval("IsEnrolled")) ? "<span class='badge bg-success'><i class='fa-solid fa-check me-1'></i>Enrolled</span>" : "<span style='color:var(--color-text-secondary); font-size:0.72rem;'><i class='fa-regular fa-bookmark'></i></span>" %>
                    </div>
                    <a href='<%: ResolveUrl("~/Courses/CourseDetail.aspx") %>?id=<%# Eval("CourseID") %>' class="btn btn-primary btn-sm">
                        <%# Convert.ToBoolean(Eval("IsEnrolled")) ? "Continue learning" : "View course" %>
                    </a>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate></div></FooterTemplate>
    </asp:Repeater>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
        <div class="card p-5 text-center text-muted" style="margin-top: 12px;">
            <i class="fa-solid fa-magnifying-glass fa-3x mb-3" style="color: #E5E7EB;"></i>
            <p>No courses match your filters. Try resetting them.</p>
            <div>
                <asp:Button ID="btnReset" runat="server" Text="Show All Courses"
                    CssClass="btn btn-outline-primary" CausesValidation="false" OnClick="btnClear_Click" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        var dropdown = document.querySelector('select[id$="ddlCategory"]');
        // Highlight currently active chip
        if (dropdown) {
            var sel = dropdown.value;
            document.querySelectorAll('.cl-cat-chip').forEach(function (c) {
                if ((c.getAttribute('data-cat') || '') === sel) c.classList.add('active');
            });
        }
        // Wire chip clicks: set dropdown value, dispatch change to trigger AutoPostBack
        document.querySelectorAll('.cl-cat-chip').forEach(function (chip) {
            chip.addEventListener('click', function (e) {
                e.preventDefault();
                if (!dropdown) return;
                dropdown.value = chip.getAttribute('data-cat') || '';
                var evt = document.createEvent('HTMLEvents');
                evt.initEvent('change', true, true);
                dropdown.dispatchEvent(evt);
            });
        });
    })();
</script>
</asp:Content>
