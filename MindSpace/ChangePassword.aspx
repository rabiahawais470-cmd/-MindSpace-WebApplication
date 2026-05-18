<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="MindSpace.ChangePasswordPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="max-width: 520px; margin: 20px auto;">

        <div class="mb-4">
            <h3 style="font-family: var(--font-heading); font-weight: 700;"><i class="fa-solid fa-key me-2" style="color: var(--color-primary);"></i>Change Password</h3>
            <p class="text-muted mb-0" style="font-size: var(--text-sm);">Update your account password to keep it secure.</p>
        </div>

        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div class="alert-ms-error mb-3">
                <i class="fa-solid fa-circle-exclamation me-2"></i>
                <asp:Literal ID="litError" runat="server" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
            <div class="alert-ms-success mb-3">
                <i class="fa-solid fa-circle-check me-2"></i>Password changed successfully!
            </div>
        </asp:Panel>

        <div class="card p-4">
            <input type="text" name="username" autocomplete="username"
                   style="display:none;" aria-hidden="true"
                   value='<%: Session["Username"] %>' />

            <div class="mb-3">
                <label class="form-label">Current Password <span class="text-danger">*</span></label>
                <div class="input-group">
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Your current password" MaxLength="100"
                        autocomplete="current-password" />
                    <button class="btn btn-outline-secondary" type="button"
                            onclick="togglePwd('<%: txtCurrentPassword.ClientID %>', 'eye1')">
                        <i class="fa-regular fa-eye" id="eye1"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvCurrent" runat="server"
                    ControlToValidate="txtCurrentPassword"
                    ErrorMessage="Current password is required."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label class="form-label">New Password <span class="text-danger">*</span></label>
                <div class="input-group">
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Min 8 characters" MaxLength="100"
                        autocomplete="new-password" />
                    <button class="btn btn-outline-secondary" type="button"
                            onclick="togglePwd('<%: txtNewPassword.ClientID %>', 'eye2')">
                        <i class="fa-regular fa-eye" id="eye2"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvNew" runat="server"
                    ControlToValidate="txtNewPassword"
                    ErrorMessage="New password is required."
                    CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revNew" runat="server"
                    ControlToValidate="txtNewPassword"
                    ValidationExpression=".{8,}"
                    ErrorMessage="Must be at least 8 characters."
                    CssClass="validation-error" Display="Dynamic" />
                <div class="progress mt-2" style="height: 4px;">
                    <div id="newPwdStrength" class="progress-bar" style="width:0%; transition: width 0.3s;"></div>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Confirm New Password <span class="text-danger">*</span></label>
                <div class="input-group">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Repeat new password" MaxLength="100"
                        autocomplete="new-password" />
                    <button class="btn btn-outline-secondary" type="button"
                            onclick="togglePwd('<%: txtConfirmPassword.ClientID %>', 'eye3')">
                        <i class="fa-regular fa-eye" id="eye3"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvConfirm" runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Please confirm your new password."
                    CssClass="validation-error" Display="Dynamic" />
                <asp:CompareValidator ID="cvPassword" runat="server"
                    ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword"
                    ErrorMessage="Passwords do not match."
                    CssClass="validation-error" Display="Dynamic" />
                <span id="confirmFeedback" class="validation-error"></span>
            </div>

            <div class="d-flex gap-2">
                <asp:Button ID="btnChange" runat="server" Text="Update Password"
                    CssClass="btn btn-primary" OnClick="btnChange_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                    CssClass="btn btn-outline-secondary" CausesValidation="false"
                    OnClick="btnCancel_Click" />
            </div>
        </div>

        <div class="mt-3 p-3" style="background: var(--color-primary-light); border-radius: var(--radius-md);">
            <h6 class="mb-2" style="font-size: var(--text-sm);"><i class="fa-solid fa-circle-info me-2" style="color: var(--color-primary);"></i>Password Tips</h6>
            <ul class="small text-muted mb-0" style="padding-left: 20px;">
                <li>Minimum 8 characters</li>
                <li>Mix uppercase, lowercase, numbers, and symbols for stronger passwords</li>
                <li>Don&rsquo;t reuse old passwords</li>
            </ul>
        </div>

    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    function togglePwd(fieldId, iconId) {
        var f = document.getElementById(fieldId);
        var i = document.getElementById(iconId);
        if (!f) return;
        f.type = (f.type === 'password') ? 'text' : 'password';
        if (i) i.className = (f.type === 'text') ? 'fa-regular fa-eye-slash' : 'fa-regular fa-eye';
    }

    document.addEventListener('DOMContentLoaded', function () {
        var newPwd = document.getElementById('<%: txtNewPassword.ClientID %>');
        var bar    = document.getElementById('newPwdStrength');
        if (newPwd && bar) {
            newPwd.addEventListener('input', function () {
                var v = newPwd.value, s = 0;
                if (v.length >= 8)         s++;
                if (/[A-Z]/.test(v))       s++;
                if (/[a-z]/.test(v))       s++;
                if (/[0-9]/.test(v))       s++;
                if (/[^A-Za-z0-9]/.test(v)) s++;
                bar.style.width = (s * 20) + '%';
                var c = ['', '#EF4444', '#F59E0B', '#7C6FCD', '#10B981', '#10B981'];
                bar.style.background = c[s] || '';
            });
        }
        if (typeof bindPasswordConfirm === 'function') {
            bindPasswordConfirm('<%: txtNewPassword.ClientID %>',
                                '<%: txtConfirmPassword.ClientID %>',
                                'confirmFeedback');
        }
    });
</script>
</asp:Content>
