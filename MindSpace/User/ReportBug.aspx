<%@ Page Title="Report a Bug" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportBug.aspx.cs" Inherits="MindSpace.User.ReportBug" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="cl-header">
        <h2 class="cl-header-title">report a <span class="cl-header-accent">bug</span></h2>
        <p class="cl-header-sub">Spotted something broken? Tell us what happened and we&rsquo;ll take a look. Reports go straight to the maintainers.</p>
    </div>

    <div class="simple-form">
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="ms-flash">
            <i class="fa-solid fa-circle-check me-1"></i> Thanks &mdash; your report has been logged. We&rsquo;ll follow up if we need more details.
        </asp:Panel>

        <div class="form-row">
            <label for='<%= txtReport.ClientID %>'>What went wrong?</label>
            <p class="form-help">Include the page you were on, what you tried to do, and what happened instead.</p>
            <asp:TextBox ID="txtReport" runat="server" TextMode="MultiLine" Rows="8" placeholder="Describe the bug..." />
            <asp:RequiredFieldValidator ID="rfvReport" runat="server"
                ControlToValidate="txtReport" Display="Dynamic"
                CssClass="text-danger small mt-1"
                ErrorMessage="Please describe the bug before submitting." />
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSubmit" runat="server" Text="Send report" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            <a class="btn btn-outline-secondary" href="<%: ResolveUrl("~/User/UserHome.aspx") %>">Cancel</a>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
