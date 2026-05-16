<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MindSpace.LoginPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-wrapper">
        <div class="auth-card">

            <div class="auth-logo">
                <i class="fas fa-brain"></i>
                <h2>Welcome Back</h2>
                <p>Sign in to continue your mental wellness journey</p>
            </div>

            <!-- Server-side error message -->
            <asp:Panel ID="pnlError" runat="server" Visible="false">
                <div class="alert-ms-error" id="divError">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <asp:Literal ID="litError" runat="server" />
                </div>
            </asp:Panel>

            <!-- Success message (e.g., after registration) -->
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                <div class="alert-ms-success alert-auto-dismiss">
                    <i class="fas fa-check-circle me-2"></i>
                    <asp:Literal ID="litSuccess" runat="server" />
                </div>
            </asp:Panel>

            <!-- Login Form -->
            <div class="mb-3">
                <label class="form-label" for="txtCredential">Username or Email</label>
                <asp:TextBox ID="txtCredential" runat="server" CssClass="form-control"
                    placeholder="Enter username or email" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvCredential" runat="server"
                    ControlToValidate="txtCredential"
                    ErrorMessage="Username or email is required."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="mb-4">
                <label class="form-label" for="txtPassword">Password</label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Enter password" MaxLength="100" />
                    <button class="btn btn-outline-secondary" type="button" id="btnTogglePwd"
                            onclick="togglePwd()" title="Show/Hide password">
                        <i class="fas fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Password is required."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-primary btn-full mb-3"
                OnClick="btnLogin_Click" />

            <div class="text-center">
                <span class="text-muted small">Don't have an account? </span>
                <a href="Register.aspx" class="fw-semibold small">Create one free</a>
            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    function togglePwd() {
        var pwd = document.getElementById('<%: txtPassword.ClientID %>');
        var icon = document.getElementById('eyeIcon');
        if (pwd.type === 'password') {
            pwd.type = 'text';
            icon.className = 'fas fa-eye-slash';
        } else {
            pwd.type = 'password';
            icon.className = 'fas fa-eye';
        }
    }
</script>
</asp:Content>
