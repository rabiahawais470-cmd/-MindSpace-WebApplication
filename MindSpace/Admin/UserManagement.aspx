<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="MindSpace.UserManagement" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="mb-4">
        <h3 style="font-family: var(--font-heading); font-weight: 700;">User Management</h3>
        <p class="text-muted mb-0" style="font-size: var(--text-sm);">Add, edit, and manage all registered users.</p>
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

    <!-- ADD/EDIT PANEL -->
    <div class="card p-4 mb-4">
        <h5 class="fw-bold mb-3">
            <asp:Literal ID="litFormTitle" runat="server">Add New User</asp:Literal>
        </h5>
        <asp:HiddenField ID="hdnEditUserID" runat="server" Value="0" />

        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Full name" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                    ErrorMessage="Full name required." CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-6">
                <label class="form-label">Username <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" MaxLength="50" />
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                    ErrorMessage="Username required." CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-6">
                <label class="form-label">Email <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="Email" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email required." CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-3">
                <label class="form-label">Role <span class="text-danger">*</span></label>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                    <asp:ListItem Value="learner">Learner</asp:ListItem>
                    <asp:ListItem Value="admin">Admin</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <label class="form-label">Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="1">Active</asp:ListItem>
                    <asp:ListItem Value="0">Inactive</asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Panel ID="pnlPasswordField" runat="server">
                <div class="col-md-6">
                    <label class="form-label">Password <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        CssClass="form-control" placeholder="Min 8 characters" MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="Password required." CssClass="validation-error" Display="Dynamic" />
                </div>
            </asp:Panel>
        </div>

        <div class="mt-4 d-flex gap-2">
            <asp:Button ID="btnSave" runat="server" Text="Save User" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary"
                CausesValidation="false" OnClick="btnCancelEdit_Click" />
        </div>
    </div>

    <!-- SEARCH BAR -->
    <div class="card p-3 mb-3">
        <div class="d-flex gap-2 flex-wrap align-items-center">
            <div class="input-group" style="max-width: 350px; flex: 1;">
                <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0" placeholder="Search by name, username, or email..." />
            </div>
            <asp:DropDownList ID="ddlRoleFilter" runat="server" CssClass="form-select" style="max-width: 160px;">
                <asp:ListItem Value="">All Roles</asp:ListItem>
                <asp:ListItem Value="learner">Learner</asp:ListItem>
                <asp:ListItem Value="admin">Admin</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary"
                CausesValidation="false" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                CausesValidation="false" OnClick="btnClearSearch_Click" />
            <span class="ms-auto text-muted small">
                Total: <strong><asp:Literal ID="litCount" runat="server" /></strong>
            </span>
        </div>
    </div>

    <!-- USERS TABLE -->
    <div class="admin-table">
        <div class="table-responsive">
            <asp:GridView ID="gvUsers" runat="server"
                AutoGenerateColumns="false"
                CssClass="table table-hover mb-0"
                GridLines="None"
                DataKeyNames="UserID"
                OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="ID" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:TemplateField HeaderText="Role">
                        <ItemTemplate>
                            <span class="badge <%# Eval("Role").ToString() == "admin" ? "badge-role-admin" : "badge-role-learner" %>">
                                <%# Eval("Role") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge <%# Convert.ToBoolean(Eval("IsActive")) ? "bg-success" : "bg-secondary" %>">
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DateRegistered" HeaderText="Registered"
                        DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnEdit" runat="server" CssClass="btn btn-sm btn-outline-primary me-1"
                                CommandName="EditUser" CommandArgument='<%# Eval("UserID") %>'>
                                <i class="fa-solid fa-pen"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="lbtnDelete" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>'
                                OnClientClick="return confirm('Delete this user? They will be deactivated.');">
                                <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center py-4 text-muted">
                        <i class="fa-solid fa-users fa-2x mb-2 d-block" style="color: #E5E7EB;"></i>No users found.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
