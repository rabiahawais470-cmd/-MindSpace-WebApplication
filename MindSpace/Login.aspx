<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MindSpace.LoginPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-wrapper">
        <div class="auth-split">

            <!-- LEFT: BRANDED ILLUSTRATION -->
            <div class="auth-brand-side">
                <div class="auth-brand-content">
                    <div class="auth-brand-logo">
                        <span class="auth-brand-logo-icon"><i class="fa-solid fa-brain"></i></span>
                        <span>MindSpace</span>
                    </div>
                    <div class="auth-brand-tagline">
                        <h2>Welcome back to your wellness journey.</h2>
                        <p>Continue learning, tracking progress, and connecting with peers who care about mental health.</p>
                    </div>
                </div>
                <div class="auth-brand-features">
                    <div class="auth-brand-feature"><i class="fa-solid fa-check"></i>6+ evidence-based courses</div>
                    <div class="auth-brand-feature"><i class="fa-solid fa-check"></i>Self-paced learning &amp; quizzes</div>
                    <div class="auth-brand-feature"><i class="fa-solid fa-check"></i>Private progress tracking</div>
                </div>
            </div>

            <!-- RIGHT: FORM -->
            <div class="auth-form-side">
                <div class="auth-form-header">
                    <h3>Sign in</h3>
                    <p>Welcome back! Please enter your details.</p>
                </div>

                <!-- Server-side messages -->
                <asp:Panel ID="pnlError" runat="server" Visible="false">
                    <div class="alert-ms-error mb-3">
                        <i class="fa-solid fa-circle-exclamation me-2"></i>
                        <asp:Literal ID="litError" runat="server" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                    <div class="alert-ms-success mb-3">
                        <i class="fa-solid fa-circle-check me-2"></i>
                        <asp:Literal ID="litSuccess" runat="server" />
                    </div>
                </asp:Panel>

                <div class="mb-3">
                    <label class="form-label" for="<%: txtCredential.ClientID %>">Username or Email</label>
                    <asp:TextBox ID="txtCredential" runat="server" CssClass="form-control"
                        placeholder="Enter username or email" MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvCredential" runat="server"
                        ControlToValidate="txtCredential"
                        ErrorMessage="Username or email is required."
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <div class="mb-4">
                    <label class="form-label" for="<%: txtPassword.ClientID %>">Password</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                            CssClass="form-control" placeholder="Enter password" MaxLength="100" />
                        <button class="btn btn-outline-secondary" type="button" id="btnTogglePwd"
                                onclick="togglePwd()" title="Show/Hide password">
                            <i class="fa-regular fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required."
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Sign In"
                    CssClass="btn btn-primary btn-full mb-3 py-2" OnClick="btnLogin_Click" />

                <div class="text-center mt-3">
                    <span class="text-muted small">Don&rsquo;t have an account? </span>
                    <a href="Register.aspx" class="fw-semibold small">Create one free</a>
                </div>
            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    function togglePwd() {
        var pwd = document.getElementById('<%: txtPassword.ClientID %>');
        var icon = document.getElementById('eyeIcon');
        if (!pwd) return;
        if (pwd.type === 'password') {
            pwd.type = 'text';
            icon.className = 'fa-regular fa-eye-slash';
        } else {
            pwd.type = 'password';
            icon.className = 'fa-regular fa-eye';
        }
    }
</script>
</asp:Content>
