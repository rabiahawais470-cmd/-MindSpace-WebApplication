<%@ Page Title="Bookmarks" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bookmarks.aspx.cs" Inherits="MindSpace.User.Bookmarks" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="cl-header">
        <h2 class="cl-header-title">Your <span class="cl-header-accent">Bookmarks</span></h2>
        <p class="cl-header-sub">Courses you&rsquo;ve saved for later. Tap the bookmark icon on any course card to remove it from this list.</p>
    </div>

    <div class="cl-grid-header">
        <h6 class="fw-bold mb-0" style="font-family: var(--font-heading);">Saved Courses</h6>
        <span class="cl-grid-header-count">
            <strong><asp:Literal ID="litCount" runat="server">0</asp:Literal></strong> course<span>(s)</span>
        </span>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
        <div class="card p-5 text-center text-muted" style="margin-top: 12px;">
            <i class="fa-regular fa-bookmark fa-3x mb-3" style="color: #E5E7EB;"></i>
            <p class="mb-3">You haven&rsquo;t bookmarked anything yet.</p>
            <div>
                <a href="<%: ResolveUrl("~/Courses/CourseList.aspx") %>" class="btn btn-primary">Browse courses</a>
            </div>
        </div>
    </asp:Panel>

    <asp:Repeater ID="rptBookmarks" runat="server">
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
                                Open course
                            </span>
                            <span class="ms-blog-card-date">
                                <%# Eval("DifficultyLevel") %> &middot; <%# Eval("Duration") %>
                            </span>
                        </div>
                    </div>
                </a>
                <button type="button"
                        class="ms-bookmark-btn is-on"
                        data-course-id='<%# Eval("CourseID") %>'
                        aria-label="Remove bookmark"
                        title="Remove bookmark">
                    <i class="fa-solid fa-bookmark"></i>
                </button>
            </div>
        </ItemTemplate>
        <FooterTemplate></div></FooterTemplate>
    </asp:Repeater>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* On the Bookmarks page, toggling a bookmark removes it from the list */
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
            fetch(endpoint, {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'courseId=' + encodeURIComponent(courseId)
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data && data.ok && !data.bookmarked) {
                    var wrap = btn.closest('.ms-blog-card-wrap');
                    if (wrap) {
                        wrap.style.transition = 'opacity 0.2s, transform 0.2s';
                        wrap.style.opacity = '0';
                        wrap.style.transform = 'scale(0.95)';
                        setTimeout(function () { wrap.remove(); checkEmpty(); }, 180);
                    }
                }
            })
            .catch(function () { btn.dataset.busy = '0'; });
        });
    });

    function checkEmpty() {
        var remaining = document.querySelectorAll('.ms-blog-card-wrap').length;
        var countEl = document.querySelector('.cl-grid-header-count strong');
        if (countEl) countEl.textContent = remaining;
        if (remaining === 0) {
            // simple reload to show server-rendered empty state
            window.location.reload();
        }
    }
})();
</script>
</asp:Content>
