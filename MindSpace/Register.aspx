<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MindSpace.RegisterPage" %>

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
                        <h2>Start your mental wellness journey today.</h2>
                        <p>Join thousands of students learning about mindfulness, stress, sleep, and resilience &mdash; for free.</p>
                    </div>
                </div>
                <div class="auth-brand-features">
                    <div class="auth-brand-feature"><i class="fa-solid fa-check"></i>Always free, no payment required</div>
                    <div class="auth-brand-feature"><i class="fa-solid fa-check"></i>Self-paced courses &amp; quizzes</div>
                    <div class="auth-brand-feature"><i class="fa-solid fa-check"></i>Private &amp; secure</div>
                </div>
            </div>

            <!-- RIGHT: FORM -->
            <div class="auth-form-side">
                <div class="auth-form-header">
                    <h3>Create your account</h3>
                    <p>Free forever. Takes less than a minute.</p>
                </div>

                <asp:Panel ID="pnlError" runat="server" Visible="false">
                    <div class="alert-ms-error mb-3">
                        <i class="fa-solid fa-circle-exclamation me-2"></i>
                        <asp:Literal ID="litError" runat="server" />
                    </div>
                </asp:Panel>

                <div class="mb-3">
                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"
                        placeholder="e.g. Alex Johnson" MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                        ControlToValidate="txtFullName" ErrorMessage="Full name is required."
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Username <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                        placeholder="Choose a username" MaxLength="50" />
                    <asp:CustomValidator ID="cvUsername" runat="server"
                        ControlToValidate="txtUsername"
                        ErrorMessage="Invalid username."
                        CssClass="validation-error" Display="Dynamic"
                        OnServerValidate="ValidateUsername" />
                    <span id="usernameFeedback" class="validation-error"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email Address <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"
                        placeholder="your@email.com" MaxLength="100" />
                    <asp:CustomValidator ID="cvEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Invalid email."
                        CssClass="validation-error" Display="Dynamic"
                        OnServerValidate="ValidateEmail" />
                    <span id="emailFeedback" class="validation-error"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                            CssClass="form-control" placeholder="Min 8 characters" MaxLength="100" />
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="toggleRegPwd('<%: txtPassword.ClientID %>', 'eyeReg1')">
                            <i class="fa-regular fa-eye" id="eyeReg1"></i>
                        </button>
                    </div>
                    <asp:CustomValidator ID="cvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Invalid password."
                        CssClass="validation-error" Display="Dynamic"
                        OnServerValidate="ValidatePassword" />
                    <div class="progress mt-2" style="height: 4px;" title="Password strength">
                        <div id="pwdStrengthBar" class="progress-bar" style="width:0%; transition: width 0.3s;"></div>
                    </div>
                    <div class="d-flex justify-content-between mt-1">
                        <small class="text-muted" style="font-size: 0.72rem;">Password strength</small>
                        <small id="pwdStrengthLabel" class="text-muted" style="font-size: 0.72rem;"></small>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"
                            CssClass="form-control" placeholder="Repeat your password" MaxLength="100" />
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="toggleRegPwd('<%: txtConfirmPassword.ClientID %>', 'eyeReg2')">
                            <i class="fa-regular fa-eye" id="eyeReg2"></i>
                        </button>
                    </div>
                    <asp:CustomValidator ID="cvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Invalid confirmation."
                        CssClass="validation-error" Display="Dynamic"
                        OnServerValidate="ValidateConfirmPassword" />
                    <span id="confirmFeedback" class="validation-error"></span>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                    CssClass="btn btn-primary btn-full mb-3 py-2" OnClick="btnRegister_Click" />

                <div class="text-center mt-3">
                    <span class="text-muted small">Already have an account? </span>
                    <a href="Login.aspx" class="fw-semibold small">Sign in</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    function toggleRegPwd(fieldId, iconId) {
        var field = document.getElementById(fieldId);
        var icon  = document.getElementById(iconId);
        if (!field) return;
        if (field.type === 'password') {
            field.type = 'text';
            if (icon) icon.className = 'fa-regular fa-eye-slash';
        } else {
            field.type = 'password';
            if (icon) icon.className = 'fa-regular fa-eye';
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.validation-error').forEach(function (el) {
            el.style.setProperty('visibility', 'visible', 'important');
        });

        var pwdField = document.getElementById('<%: txtPassword.ClientID %>');
        var bar      = document.getElementById('pwdStrengthBar');
        var label    = document.getElementById('pwdStrengthLabel');

        if (pwdField && bar) {
            pwdField.addEventListener('input', function () {
                var val = pwdField.value, score = 0;
                if (val.length >= 8)         score++;
                if (/[A-Z]/.test(val))       score++;
                if (/[a-z]/.test(val))       score++;
                if (/[0-9]/.test(val))       score++;
                if (/[^A-Za-z0-9]/.test(val)) score++;
                bar.style.width = (score * 20) + '%';
                var levels = ['', 'Weak', 'Fair', 'Good', 'Strong', 'Very Strong'];
                var colors = ['', '#EF4444', '#F59E0B', '#7C6FCD', '#10B981', '#10B981'];
                bar.style.background = colors[score] || '';
                if (label) label.textContent = levels[score] || '';
            });
        }

        if (typeof bindPasswordConfirm === 'function') {
            bindPasswordConfirm('<%: txtPassword.ClientID %>',
                                '<%: txtConfirmPassword.ClientID %>',
                                'confirmFeedback');
        }
        if (typeof bindUsernameValidation === 'function') {
            bindUsernameValidation('<%: txtUsername.ClientID %>', 'usernameFeedback');
        }
        if (typeof bindEmailValidation === 'function') {
            bindEmailValidation('<%: txtEmail.ClientID %>', 'emailFeedback');
        }
    });
</script>
</asp:Content>
