<%@ Page Title="Notification Preferences" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NotificationPreferences.aspx.cs" Inherits="MindSpace.User.NotificationPreferences" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="cl-header">
        <h2 class="cl-header-title">Notification <span class="cl-header-accent">Preferences</span></h2>
        <p class="cl-header-sub">Choose which updates you&rsquo;d like to hear about. Changes apply immediately.</p>
    </div>

    <div class="simple-form">
        <asp:Panel ID="pnlSaved" runat="server" Visible="false" CssClass="ms-flash">
            <i class="fa-solid fa-circle-check me-1"></i> Preferences saved.
        </asp:Panel>

        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Course updates</strong>
                <span>New lessons, worksheets, and quizzes in courses you&rsquo;re enrolled in.</span>
            </div>
            <asp:CheckBox ID="chkCourseUpdates" runat="server" Checked="true" CssClass="form-check-input" />
        </div>
        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Discussion replies</strong>
                <span>Get notified when someone replies to your post or thread.</span>
            </div>
            <asp:CheckBox ID="chkDiscussionReplies" runat="server" Checked="true" CssClass="form-check-input" />
        </div>
        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Weekly digest</strong>
                <span>A Sunday summary of your progress, new courses, and community highlights.</span>
            </div>
            <asp:CheckBox ID="chkWeeklyDigest" runat="server" Checked="false" CssClass="form-check-input" />
        </div>
        <div class="toggle-row">
            <div class="toggle-meta">
                <strong>Quiz reminders</strong>
                <span>Nudges to retake a quiz you didn&rsquo;t pass, or finish one you started.</span>
            </div>
            <asp:CheckBox ID="chkQuizReminders" runat="server" Checked="true" CssClass="form-check-input" />
        </div>

        <div class="form-actions" style="margin-top: 18px;">
            <asp:Button ID="btnSave" runat="server" Text="Save preferences" CssClass="btn btn-primary" OnClick="btnSave_Click" />
        </div>

        <p class="form-help" style="margin-top: 14px; margin-bottom: 0;">
            <i class="fa-solid fa-circle-info me-1"></i>
            This is a placeholder. Email notifications are not wired up yet &mdash; your choices are saved to your session.
        </p>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
