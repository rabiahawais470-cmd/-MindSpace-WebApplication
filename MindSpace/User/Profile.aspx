<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="MindSpace.ProfilePage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-user-edit me-2"></i>My Profile</h1>
            <p>Update your personal information and bio</p>
        </div>
    </div>

    <div class="container py-4" style="max-width:700px;">

        <asp:Panel ID="pnlMsg" runat="server" Visible="false">
            <div class="alert-ms-success alert-auto-dismiss mb-3">
                <i class="fas fa-check-circle me-2"></i>
                <asp:Literal ID="litMsg" runat="server" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div class="alert-ms-error mb-3">
                <i class="fas fa-exclamation-circle me-2"></i>
                <asp:Literal ID="litError" runat="server" />
            </div>
        </asp:Panel>

        <div class="ms-card p-4 mb-4">
            <!-- Profile Avatar -->
            <div class="text-center mb-4">
                <div style="width:90px;height:90px;border-radius:50%;background:linear-gradient(135deg,#6C5CE7,#00B894);display:flex;align-items:center;justify-content:center;margin:0 auto;font-size:2.5rem;color:#fff;">
                    <asp:Literal ID="litAvatarInitial" runat="server" />
                </div>
                <h5 class="fw-bold mt-2 mb-0">
                    <asp:Literal ID="litDisplayName" runat="server" />
                </h5>
                <small class="text-muted">
                    <asp:Literal ID="litDisplayUsername" runat="server" />
                </small>
            </div>

            <h6 class="fw-semibold mb-3 text-muted border-bottom pb-2">PROFILE INFORMATION</h6>

            <!-- Full Name -->
            <div class="mb-3">
                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                    ErrorMessage="Full name is required." CssClass="validation-error" Display="Dynamic" />
            </div>

            <!-- Username (read-only) -->
            <div class="mb-3">
                <label class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="true"
                    style="background:#f8f7ff;" />
                <small class="text-muted">Username cannot be changed.</small>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email Address <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required." CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Please enter a valid email." CssClass="validation-error" Display="Dynamic" />
            </div>

            <!-- Bio -->
            <div class="mb-4">
                <label class="form-label">Bio <span class="text-muted">(optional)</span></label>
                <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" Rows="4"
                    CssClass="form-control" MaxLength="500"
                    placeholder="Tell us a bit about yourself..." />
                <small class="text-muted">
                    <span id="bioCount">0</span>/500 characters
                </small>
            </div>

            <div class="d-flex gap-2">
                <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                    CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <a href="../ChangePassword.aspx" class="btn btn-outline-secondary">
                    <i class="fas fa-key me-1"></i>Change Password
                </a>
            </div>
        </div>

        <!-- ACCOUNT INFO -->
        <div class="ms-card p-4">
            <h6 class="fw-semibold mb-3 text-muted border-bottom pb-2">ACCOUNT INFORMATION</h6>
            <div class="row g-2 small">
                <div class="col-5 text-muted">Member Since</div>
                <div class="col-7 fw-semibold"><asp:Literal ID="litJoined" runat="server" /></div>
                <div class="col-5 text-muted">Account Role</div>
                <div class="col-7">
                    <span class="badge badge-role-learner"><asp:Literal ID="litRole" runat="server" /></span>
                </div>
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
