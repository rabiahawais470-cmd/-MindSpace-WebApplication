<%@ Page Title="Course Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseManagement.aspx.cs" Inherits="MindSpace.CourseManagement" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ── Delete Confirmation Modal ── */
.delete-modal-overlay {
    position: fixed; inset: 0;
    background: rgba(15, 23, 42, 0.55);
    backdrop-filter: blur(4px);
    z-index: 9999;
    display: flex; align-items: center; justify-content: center;
    opacity: 0; visibility: hidden;
    transition: opacity 0.25s ease, visibility 0.25s ease;
}
.delete-modal-overlay.active {
    opacity: 1; visibility: visible;
}
.delete-modal-dialog {
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 25px 60px rgba(15, 23, 42, 0.18), 0 0 0 1px rgba(0,0,0,0.04);
    width: 100%; max-width: 440px;
    padding: 0;
    transform: translateY(12px) scale(0.97);
    transition: transform 0.25s cubic-bezier(0.22, 1, 0.36, 1);
    overflow: hidden;
}
.delete-modal-overlay.active .delete-modal-dialog {
    transform: translateY(0) scale(1);
}
.delete-modal-header {
    padding: 28px 28px 0 28px;
    text-align: center;
}
.delete-modal-icon {
    width: 56px; height: 56px;
    border-radius: 50%;
    background: linear-gradient(135deg, #FEE2E2, #FECACA);
    display: inline-flex; align-items: center; justify-content: center;
    margin-bottom: 16px;
}
.delete-modal-icon i {
    font-size: 24px; color: #DC2626;
}
.delete-modal-title {
    font-family: var(--font-heading);
    font-size: 1.2rem; font-weight: 700;
    color: #111827; margin: 0 0 6px 0;
}
.delete-modal-body {
    padding: 0 28px 24px 28px;
    text-align: center;
}
.delete-modal-body p {
    font-size: 0.9rem; color: #6B7280;
    margin: 0; line-height: 1.55;
}
.delete-modal-course-name {
    display: inline-block;
    font-weight: 600; color: #374151;
    background: #F3F4F6;
    padding: 2px 10px; border-radius: 6px;
    margin-top: 8px; font-size: 0.85rem;
    max-width: 100%; overflow: hidden;
    text-overflow: ellipsis; white-space: nowrap;
}
.delete-modal-footer {
    padding: 16px 28px 24px 28px;
    display: flex; gap: 10px; justify-content: center;
}
.delete-modal-footer .btn {
    min-width: 120px; font-weight: 600;
    border-radius: 10px; padding: 10px 20px;
    font-size: 0.875rem;
    transition: all 0.15s ease;
}
.btn-delete-confirm {
    background: #DC2626; color: #fff;
    border: 1px solid #DC2626;
}
.btn-delete-confirm:hover {
    background: #B91C1C; border-color: #B91C1C;
    box-shadow: 0 4px 12px rgba(220, 38, 38, 0.35);
}
.btn-delete-cancel {
    background: #fff; color: #374151;
    border: 1px solid #D1D5DB;
}
.btn-delete-cancel:hover {
    background: #F9FAFB; border-color: #9CA3AF;
}
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="mb-4">
    <h3 style="font-family: var(--font-heading); font-weight: 700;">Course Management</h3>
    <p class="text-muted mb-0" style="font-size: var(--text-sm);">Add, edit, and manage all learning courses.</p>
</div>

<asp:Panel ID="pnlMsg" runat="server" Visible="false">
    <div class="alert-ms-success mb-3">
        <i class="fa-solid fa-circle-check me-2"></i>
        <asp:Literal ID="litMsg" runat="server" />
    </div>
</asp:Panel>
<asp:Panel ID="pnlError" runat="server" Visible="false">
    <div class="alert-ms-error mb-3">
        <i class="fa-solid fa-circle-exclamation me-2"></i>
        <asp:Literal ID="litError" runat="server" />
    </div>
</asp:Panel>

<!-- ADD/EDIT FORM -->
<div class="card p-4 mb-4">
    <h5 class="fw-bold mb-3">
        <asp:Literal ID="litFormTitle" runat="server">Add New Course</asp:Literal>
    </h5>
    <asp:HiddenField ID="hdnEditCourseID" runat="server" Value="0" ClientIDMode="Static" />

    <div class="row g-3">
        <div class="col-md-8">
            <label class="form-label">Course Title <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Course title" MaxLength="200" />
            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                ErrorMessage="Title is required." CssClass="validation-error" Display="Dynamic" />
        </div>
        <div class="col-md-4">
            <label class="form-label">Category <span class="text-danger">*</span></label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
                <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
                <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
                <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
                <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
                <asp:ListItem Value="Self-Care">Self-Care</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-12">
            <label class="form-label">Description <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"
                CssClass="form-control" placeholder="Detailed course description..." MaxLength="2000" />
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                ErrorMessage="Description is required." CssClass="validation-error" Display="Dynamic" />
        </div>
        <div class="col-md-4">
            <label class="form-label">Difficulty Level</label>
            <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
                <asp:ListItem Value="Beginner">Beginner</asp:ListItem>
                <asp:ListItem Value="Intermediate">Intermediate</asp:ListItem>
                <asp:ListItem Value="Advanced">Advanced</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-4">
            <label class="form-label">Duration</label>
            <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control"
                placeholder="e.g. 4 weeks" MaxLength="50" />
        </div>
        <div class="col-md-4">
            <label class="form-label">Status</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">Inactive</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    <div class="mt-4 d-flex gap-2">
        <asp:Button ID="btnSave" runat="server" Text="Save Course" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary"
            CausesValidation="false" OnClick="btnCancel_Click" />
    </div>
</div>

<!-- SEARCH BAR -->
<div class="card p-3 mb-3">
    <div class="d-flex gap-2 flex-wrap align-items-center">
        <div class="input-group" style="max-width: 300px; flex: 1;">
            <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0" placeholder="Search courses..." />
        </div>
        <asp:DropDownList ID="ddlCatFilter" runat="server" CssClass="form-select" style="max-width: 200px;">
            <asp:ListItem Value="">All Categories</asp:ListItem>
            <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
            <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
            <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
            <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
            <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
            <asp:ListItem Value="Self-Care">Self-Care</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary"
            CausesValidation="false" OnClick="btnSearch_Click" />
        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
            CausesValidation="false" OnClick="btnClear_Click" />
        <span class="ms-auto text-muted small">
            Total: <strong><asp:Literal ID="litCount" runat="server" /></strong>
        </span>
    </div>
</div>

<!-- COURSES TABLE -->
<div class="admin-table">
    <div class="table-responsive">
        <asp:GridView ID="gvCourses" runat="server"
            AutoGenerateColumns="false"
            CssClass="table table-hover mb-0"
            GridLines="None"
            DataKeyNames="CourseID"
            OnRowCommand="gvCourses_RowCommand">
            <Columns>
                <asp:BoundField DataField="CourseID" HeaderText="ID" ItemStyle-Width="50px" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="DifficultyLevel" HeaderText="Level" />
                <asp:BoundField DataField="Duration" HeaderText="Duration" />
                <asp:BoundField DataField="EnrollmentCount" HeaderText="Enrolled" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <span class="badge <%# Convert.ToBoolean(Eval("IsActive")) ? "bg-success" : "bg-secondary" %>">
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <button type="button"
                            class="btn btn-sm btn-outline-primary me-1 btn-edit-course"
                            data-courseid='<%# Eval("CourseID") %>'
                            data-title='<%# Eval("Title") %>'
                            data-category='<%# Eval("Category") %>'
                            data-level='<%# Eval("DifficultyLevel") %>'
                            data-duration='<%# Eval("Duration") %>'
                            data-description='<%# Eval("Description") %>'>
                            <i class="fa-solid fa-pen"></i>
                        </button>
                        <asp:LinkButton ID="lbtnDelete" runat="server"
                            CssClass="btn btn-sm btn-outline-danger btn-delete-trigger"
                            CommandName="DeleteCourse"
                            CommandArgument='<%# Eval("CourseID") %>'
                            CausesValidation="false"
                            data-course-title='<%# Eval("Title") %>'>
                            <i class="fa-solid fa-trash-can"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div class="text-center py-4 text-muted">
                    <i class="fa-solid fa-graduation-cap fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>No courses found.
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</div>

<!-- DELETE CONFIRMATION MODAL -->
<div id="deleteModal" class="delete-modal-overlay" role="dialog" aria-modal="true" aria-labelledby="deleteModalTitle">
    <div class="delete-modal-dialog">
        <div class="delete-modal-header">
            <div class="delete-modal-icon">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>
            <h4 id="deleteModalTitle" class="delete-modal-title">Delete Course</h4>
        </div>
        <div class="delete-modal-body">
            <p>This action is permanent and cannot be undone. All associated quizzes, questions, enrollments, bookmarks, and resources will also be removed.</p>
            <span id="deleteModalCourseName" class="delete-modal-course-name"></span>
        </div>
        <div class="delete-modal-footer">
            <button type="button" id="btnDeleteCancel" class="btn btn-delete-cancel">Cancel</button>
            <button type="button" id="btnDeleteConfirm" class="btn btn-delete-confirm">
                <i class="fa-solid fa-trash-can me-1"></i>Delete
            </button>
        </div>
    </div>
</div>

<!-- EDIT COURSE MODAL -->
<div class="modal fade" id="editCourseModal" tabindex="-1" aria-labelledby="editCourseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCourseModalLabel">Edit Course</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label">Course Title <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtEditTitle" runat="server" CssClass="form-control" MaxLength="200" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Category <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="txtEditCategory" runat="server" CssClass="form-select">
                            <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
                            <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
                            <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
                            <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
                            <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
                            <asp:ListItem Value="Self-Care">Self-Care</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Difficulty Level</label>
                        <asp:TextBox ID="txtEditLevel" runat="server" CssClass="form-control" MaxLength="50" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Duration</label>
                        <asp:TextBox ID="txtEditDuration" runat="server" CssClass="form-control" MaxLength="50" />
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtEditDescription" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" MaxLength="2000" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <asp:Button ID="btnUpdateCourse" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnUpdateCourse_Click" />
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    'use strict';

    var overlay = document.getElementById('deleteModal');
    var nameEl = document.getElementById('deleteModalCourseName');
    var btnOk = document.getElementById('btnDeleteConfirm');
    var btnCancel = document.getElementById('btnDeleteCancel');

    var pendingHref = '';

    document.addEventListener('click', function (e) {
        var trigger = e.target.closest('.btn-delete-trigger');
        if (!trigger) return;

        e.preventDefault();
        e.stopPropagation();

        pendingHref = trigger.getAttribute('href') || '';
        nameEl.textContent = trigger.getAttribute('data-course-title') || '(this course)';

        overlay.classList.add('active');
        btnOk.focus();
    }, true);

    btnOk.addEventListener('click', function () {
        var href = pendingHref;
        closeModal();
        if (href) {
            var m = href.match(/__doPostBack\('([^']*)','([^']*)'\)/);
            if (m && typeof __doPostBack === 'function') {
                __doPostBack(m[1], m[2]);
            } else {
                window.location.href = href;
            }
        }
    });

    btnCancel.addEventListener('click', closeModal);

    overlay.addEventListener('click', function (e) {
        if (e.target === overlay) closeModal();
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && overlay.classList.contains('active')) closeModal();
    });

    function closeModal() {
        overlay.classList.remove('active');
        pendingHref = '';
    }
})();

document.querySelectorAll('.btn-edit-course').forEach(function (btn) {
    btn.addEventListener('click', function () {
        document.getElementById('hdnEditCourseID').value = this.dataset.courseid || '0';
        document.getElementById('txtEditTitle').value = this.dataset.title || '';
        document.getElementById('txtEditCategory').value = this.dataset.category || '';
        document.getElementById('txtEditLevel').value = this.dataset.level || '';
        document.getElementById('txtEditDuration').value = this.dataset.duration || '';
        document.getElementById('txtEditDescription').value = this.dataset.description || '';

        var modal = new bootstrap.Modal(document.getElementById('editCourseModal'));
        modal.show();
    });
});
</script>

</asp:Content>
