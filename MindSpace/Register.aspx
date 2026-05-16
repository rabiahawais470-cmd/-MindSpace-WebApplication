<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MindSpace.RegisterPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-wrapper" style="padding:3rem 1rem;">
        <div class="auth-card" style="max-width:520px;">

            <div class="auth-logo">
                <i class="fas fa-brain"></i>
                <h2>Create Your Account</h2>
                <p>Join MindSpace and start your mental wellness journey today</p>
            </div>

            <asp:Panel ID="pnlError" runat="server" Visible="false">
                <div class="alert-ms-error">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <asp:Literal ID="litError" runat="server" />
                </div>
            </asp:Panel>

            <!-- Full Name -->
            <div class="mb-3">
                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"
                    placeholder="e.g. Alex Johnson" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                    ControlToValidate="txtFullName" ErrorMessage="Full name is required."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <!-- Username -->
            <div class="mb-3">
                <label class="form-label">Username <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                    placeholder="Choose a username (letters, numbers, _)" MaxLength="50" />
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                    ControlToValidate="txtUsername" ErrorMessage="Username is required."
                    CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revUsername" runat="server"
                    ControlToValidate="txtUsername"
                    ValidationExpression="^[A-Za-z0-9_]{3,50}$"
                    ErrorMessage="Username must be 3â€“50 characters: letters, numbers, or underscore."
                    CssClass="validation-error" Display="Dynamic" />
                <span id="usernameFeedback" class="validation-error"></span>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email Address <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"
                    placeholder="your@email.com" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="Email is required."
                    CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Please enter a valid email address."
                    CssClass="validation-error" Display="Dynamic" />
                <span id="emailFeedback" class="validation-error"></span>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label">Password <span class="text-danger">*</span></label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Min 8 characters" MaxLength="100" />
                    <button class="btn btn-outline-secondary" type="button"
                            onclick="toggleRegPwd('<%: txtPassword.ClientID %>', 'eyeReg1')">
                        <i class="fas fa-eye" id="eyeReg1"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                    ControlToValidate="txtPassword" ErrorMessage="Password is required."
                    CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revPassword" runat="server"
                    ControlToValidate="txtPassword"
                    ValidationExpression=".{8,}"
                    ErrorMessage="Password must be at least 8 characters."
                    CssClass="validation-error" Display="Dynamic" />
                <!-- Password strength bar -->
                <div class="progress mt-2" style="height:5px;" title="Password strength">
                    <div id="pwdStrengthBar" class="progress-bar" style="width:0%;transition:width 0.3s;"></div>
                </div>
                <div class="d-flex justify-content-between">
                    <small class="text-muted">Password strength</small>
                    <small id="pwdStrengthLabel" class="text-muted"></small>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="mb-4">
                <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                <div class="input-group">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Repeat your password" MaxLength="100" />
                    <button class="btn btn-outline-secondary" type="button"
                            onclick="toggleRegPwd('<%: txtConfirmPassword.ClientID %>', 'eyeReg2')">
                        <i class="fas fa-eye" id="eyeReg2"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                    ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm your password."
                    CssClass="validation-error" Display="Dynamic" />
                <asp:CompareValidator ID="cvPassword" runat="server"
                    ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                    ErrorMessage="Passwords do not match."
                    CssClass="validation-error" Display="Dynamic" />
                <span id="confirmFeedback" class="validation-error"></span>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                CssClass="btn btn-primary btn-full mb-3" OnClick="btnRegister_Click" />

            <div class="text-center">
                <span class="text-muted small">Already have an account? </span>
                <a href="Login.aspx" class="fw-semibold small">Sign in</a>
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
            if (icon) icon.className = 'fas fa-eye-slash';
        } else {
            field.type = 'password';
            if (icon) icon.className = 'fas fa-eye';
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        var pwdField = document.getElementById('<%: txtPassword.ClientID %>');
        var bar      = document.getElementById('pwdStrengthBar');
        var label    = document.getElementById('pwdStrengthLabel');

        if (pwdField && bar) {
            pwdField.addEventListener('input', function () {
                var val = pwdField.value;
                var score = 0;
                if (val.length >= 8)         score++;
                if (/[A-Z]/.test(val))       score++;
                if (/[a-z]/.test(val))       score++;
                if (/[0-9]/.test(val))       score++;
                if (/[^A-Za-z0-9]/.test(val)) score++;

                bar.style.width = (score * 20) + '%';
                var levels = ['', 'Weak', 'Fair', 'Good', 'Strong', 'Very Strong'];
                var colors = ['', '#e17055', '#fdcb6e', '#74b9ff', '#00b894', '#00b894'];
                bar.style.background = colors[score] || '';
                if (label) label.textContent = levels[score] || '';
            });
        }

        bindPasswordConfirm('<%: txtPassword.ClientID %>',
                            '<%: txtConfirmPassword.ClientID %>',
                            'confirmFeedback');
        bindUsernameValidation('<%: txtUsername.ClientID %>', 'usernameFeedback');
        bindEmailValidation('<%: txtEmail.ClientID %>', 'emailFeedback');
    });
</script>
</asp:Content>
