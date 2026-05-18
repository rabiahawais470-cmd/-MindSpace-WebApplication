<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="MindSpace.ProfilePage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="max-width: 720px; margin: 0 auto;">

        <div class="mb-4">
            <h3 style="font-family: var(--font-heading); font-weight: 700;">My Profile</h3>
            <p class="text-muted mb-0" style="font-size: var(--text-sm);">Update your personal information and bio.</p>
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

        <!-- PROFILE HEADER CARD -->
        <div class="card p-4 mb-4 d-flex flex-row align-items-center" style="gap: 24px;">
            <div class="rounded-circle d-flex align-items-center justify-content-center"
                 style="width: 80px; height: 80px; background: linear-gradient(135deg, var(--color-primary), #9D8FE0); color: #fff; font-size: 1.75rem; font-weight: 700; flex-shrink: 0;">
                <asp:Literal ID="litAvatarInitial" runat="server" />
            </div>
            <div style="flex: 1; min-width: 0;">
                <h5 class="fw-bold mb-1"><asp:Literal ID="litDisplayName" runat="server" /></h5>
                <div class="text-muted small mb-2"><asp:Literal ID="litDisplayUsername" runat="server" /></div>
                <span class="badge badge-soft-primary"><asp:Literal ID="litRole" runat="server" /></span>
            </div>
        </div>

        <!-- ACCOUNT STATS STRIP -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon purple"><i class="fa-solid fa-book-open"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litStatEnrolled" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Enrolled</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fa-solid fa-check-circle"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litStatCompleted" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Completed</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fa-solid fa-clipboard-check"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litStatQuizzes" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Quizzes</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon orange"><i class="fa-solid fa-comments"></i></div>
                    <div>
                        <div class="stat-num"><asp:Literal ID="litStatForum" runat="server">0</asp:Literal></div>
                        <div class="stat-label">Posts</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- PERSONAL INFO FORM -->
        <div class="card p-4 mb-4">
            <h6 class="fw-bold mb-3">Personal Information</h6>

            <div class="row g-3">
                <div class="col-12">
                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                        ErrorMessage="Full name is required." CssClass="validation-error" Display="Dynamic" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="true"
                        style="background: #F9FAFB;" />
                    <small class="text-muted" style="font-size: 0.72rem;">Username cannot be changed.</small>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email Address <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="Email is required." CssClass="validation-error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="Please enter a valid email." CssClass="validation-error" Display="Dynamic" />
                </div>
                <div class="col-12">
                    <label class="form-label">Bio <span class="text-muted">(optional)</span></label>
                    <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" Rows="4"
                        CssClass="form-control" MaxLength="500"
                        placeholder="Tell us a bit about yourself..." />
                    <small class="text-muted" style="font-size: 0.72rem;">
                        <span id="bioCount">0</span>/500 characters
                    </small>
                </div>
            </div>

            <div class="d-flex gap-2 mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                    CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <a href="../ChangePassword.aspx" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-key me-1"></i>Change Password
                </a>
            </div>
        </div>

        <!-- ACCOUNT INFO -->
        <div class="card p-4">
            <h6 class="fw-bold mb-3">Account Information</h6>
            <div class="row g-2" style="font-size: var(--text-sm);">
                <div class="col-sm-4 text-muted">Member Since</div>
                <div class="col-sm-8 fw-semibold"><asp:Literal ID="litJoined" runat="server" /></div>
            </div>
        </div>

    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var bio   = document.getElementById('<%: txtBio.ClientID %>');
        var count = document.getElementById('bioCount');
        if (bio && count) {
            function updateCount() { count.textContent = bio.value.length; }
            bio.addEventListener('input', updateCount);
            updateCount();
        }
    });
</script>
</asp:Content>
