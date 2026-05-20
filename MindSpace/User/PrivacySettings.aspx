<%@ Page Title="Privacy Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PrivacySettings.aspx.cs" Inherits="MindSpace.User.PrivacySettings" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="cl-header">
        <h2 class="cl-header-title">privacy <span class="cl-header-accent">settings</span></h2>
        <p class="cl-header-sub">Control what other learners can see about your activity on MindSpace.</p>
    </div>

    <div class="simple-form">
        <asp:Panel ID="pnlSaved" runat="server" Visible="false" CssClass="ms-flash">
            <i class="fa-solid fa-circle-check me-1"></i> Privacy settings saved.
        </asp:Panel>

        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Show my profile publicly</strong>
                <span>When off, your username and bio are hidden from the community feed.</span>
            </div>
            <asp:CheckBox ID="chkPublicProfile" runat="server" Checked="true" CssClass="form-check-input" />
        </div>
        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Show my course progress</strong>
                <span>Let other learners see which courses you&rsquo;ve completed.</span>
            </div>
            <asp:CheckBox ID="chkShowProgress" runat="server" Checked="true" CssClass="form-check-input" />
        </div>
        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Show my forum activity</strong>
                <span>Your posts and replies will be visible under your profile when on.</span>
            </div>
            <asp:CheckBox ID="chkShowForumActivity" runat="server" Checked="true" CssClass="form-check-input" />
        </div>
        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Allow analytics tracking</strong>
                <span>Helps us understand how the site is used. No personal data is shared.</span>
            </div>
            <asp:CheckBox ID="chkAnalytics" runat="server" Checked="true" CssClass="form-check-input" />
        </div>

        <div class="form-actions" style="margin-top: 18px;">
            <asp:Button ID="btnSave" runat="server" Text="Save settings" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        </div>

        <p class="form-help" style="margin-top: 14px; margin-bottom: 0;">
            <i class="fa-solid fa-circle-info me-1"></i>
            This is a placeholder. Visibility rules are saved to your session for now.
        </p>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
