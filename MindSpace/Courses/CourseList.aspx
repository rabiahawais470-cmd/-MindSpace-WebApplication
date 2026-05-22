<%@ Page Title="Browse Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="MindSpace.CourseList" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="padding-bottom: 60px;">

    <!-- HEADER -->
    <div class="cl-header">
        <h2 class="cl-header-title">Access Mental Health Education <span class="cl-header-accent">Designed for You</span></h2>
        <p class="cl-header-sub">Short, evidence-based courses across six wellness topics &mdash; built for real life.</p>
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

    <!-- COURSE GRID (blogs-card style) -->
    <asp:Repeater ID="rptCourses" runat="server">
        <HeaderTemplate>
            <div class="ms-blog-grid">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="ms-blog-card-wrap">
                <a class="ms-blog-card" href='<%: ResolveUrl("~/Courses/CourseDetail.aspx") %>?id=<%# Eval("CourseID") %>'>
                    <div class='ms-blog-card-img cat-<%# GetCatClass(Eval("Category").ToString()) %>'>
                        <span class="ms-blog-card-tag">#<%# Eval("Category").ToString().Replace(" ", "").ToUpper() %></span>
                    </div>
                    <div class="ms-blog-card-body">
                        <h3 class="ms-blog-card-title"><%# Eval("Title") %></h3>
                        <p class="ms-blog-card-desc"><%# Eval("Description") %></p>
                        <div class="ms-blog-card-footer">
                            <span class="ms-blog-card-more">
                                <span class="ms-blog-card-more-icon">
                                    <i class="fa-solid fa-arrow-right arr-a"></i>
                                    <i class="fa-solid fa-arrow-right arr-b"></i>
                                </span>
                                <%# Convert.ToBoolean(Eval("IsEnrolled")) ? "Continue learning" : "Read more" %>
                            </span>
                            <span class="ms-blog-card-date">
                                <%# Eval("DifficultyLevel") %> &middot; <%# Eval("Duration") %>
                            </span>
                        </div>
                    </div>
                </a>
                <button type="button"
                        class='ms-bookmark-btn <%# Convert.ToBoolean(Eval("IsBookmarked")) ? "is-on" : "" %>'
                        data-course-id='<%# Eval("CourseID") %>'
                        aria-label="Toggle bookmark"
                        title="Bookmark this course">
                    <i class='<%# Convert.ToBoolean(Eval("IsBookmarked")) ? "fa-solid fa-bookmark" : "fa-regular fa-bookmark" %>'></i>
                </button>
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

    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ===== Bookmark toggle (course cards) ===== */
(function () {
    var endpoint = '<%: ResolveUrl("~/Handlers/BookmarkHandler.ashx") %>';
    var buttons = document.querySelectorAll('.ms-bookmark-btn');
    buttons.forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var courseId = btn.getAttribute('data-course-id');
            if (!courseId || btn.dataset.busy === '1') return;
            btn.dataset.busy = '1';
            var icon = btn.querySelector('i');
            fetch(endpoint, {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'courseId=' + encodeURIComponent(courseId)
            })
            .then(function (r) {
                if (r.status === 401) {
                    window.location.href = '<%: ResolveUrl("~/Login.aspx") %>';
                    return null;
                }
                return r.json();
            })
            .then(function (data) {
                if (!data || !data.ok) return;
                if (data.bookmarked) {
                    btn.classList.add('is-on');
                    if (icon) { icon.classList.remove('fa-regular'); icon.classList.add('fa-solid'); }
                } else {
                    btn.classList.remove('is-on');
                    if (icon) { icon.classList.remove('fa-solid'); icon.classList.add('fa-regular'); }
                }
            })
            .catch(function () { /* swallow */ })
            .then(function () { btn.dataset.busy = '0'; });
        });
    });
})();
</script>
</asp:Content>
