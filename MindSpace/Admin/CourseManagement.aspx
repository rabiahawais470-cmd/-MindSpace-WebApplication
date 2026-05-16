<%@ Page Title="Course Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CourseManagement.aspx.cs" Inherits="MindSpace.CourseManagement" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-graduation-cap me-2"></i>Course Management</h1>
            <p>Add, edit, and manage all learning courses</p>
        </div>
    </div>

    <div class="container py-4">

        <!-- MESSAGES -->
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

        <!-- ADD / EDIT FORM -->
        <div class="ms-card p-4 mb-4">
            <h5 class="fw-bold mb-3">
                <asp:Literal ID="litFormTitle" runat="server">Add New Course</asp:Literal>
            </h5>
            <asp:HiddenField ID="hdnEditCourseID" runat="server" Value="0" />

            <div class="row g-3">
                <div class="col-md-8">
                    <label class="form-label">Course Title <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Course title" MaxLength="200" />
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                        ErrorMessage="Title is required." CssClass="validation-error" Display="Dynamic" />
                </div>
                <div class="col-md-4">
                    <label class="form-label">Category <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
                        <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
                        <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
                        <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
                        <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
                        <asp:ListItem Value="Self-Care">Self-Care</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-12">
                    <label class="form-label">Description <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"
                        CssClass="form-control" placeholder="Detailed course description..." MaxLength="2000" />
                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                        ErrorMessage="Description is required." CssClass="validation-error" Display="Dynamic" />
                </div>
                <div class="col-md-4">
                    <label class="form-label">Difficulty Level</label>
                    <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
                        <asp:ListItem Value="Beginner">Beginner</asp:ListItem>
                        <asp:ListItem Value="Intermediate">Intermediate</asp:ListItem>
                        <asp:ListItem Value="Advanced">Advanced</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Duration</label>
                    <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control"
                        placeholder="e.g. 4 weeks" MaxLength="50" />
                </div>
                <div class="col-md-4">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">Inactive</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="mt-3 d-flex gap-2">
                <asp:Button ID="btnSave" runat="server" Text="Save Course" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary"
                    CausesValidation="false" OnClick="btnCancel_Click" />
            </div>
        </div>

        <!-- SEARCH -->
        <div class="d-flex gap-2 mb-3 flex-wrap align-items-center">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search courses..." style="max-width:300px;" />
            <asp:DropDownList ID="ddlCatFilter" runat="server" CssClass="form-select" style="max-width:200px;">
                <asp:ListItem Value="">All Categories</asp:ListItem>
                <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
                <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
                <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
                <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
                <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary"
                CausesValidation="false" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                CausesValidation="false" OnClick="btnClear_Click" />
            <span class="ms-auto text-muted small">
                Total: <strong><asp:Literal ID="litCount" runat="server" /></strong> courses
            </span>
        </div>

        <!-- COURSES TABLE -->
        <div class="admin-table">
            <div class="table-responsive">
                <asp:GridView ID="gvCourses" runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-hover mb-0"
                    GridLines="None"
                    DataKeyNames="CourseID"
                    OnRowCommand="gvCourses_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="CourseID"       HeaderText="ID"         ItemStyle-Width="50px" />
                        <asp:BoundField DataField="Title"          HeaderText="Title"      />
                        <asp:BoundField DataField="Category"       HeaderText="Category"   />
                        <asp:BoundField DataField="DifficultyLevel" HeaderText="Level"     />
                        <asp:BoundField DataField="Duration"       HeaderText="Duration"   />
                        <asp:BoundField DataField="EnrollmentCount" HeaderText="Enrolled"  />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class="badge <%# Convert.ToBoolean(Eval("IsActive"))?"bg-success":"bg-secondary" %>">
                                    <%# Convert.ToBoolean(Eval("IsActive"))?"Active":"Inactive" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnEdit" runat="server" CssClass="btn btn-sm btn-outline-primary me-1"
                                    CommandName="EditCourse" CommandArgument='<%# Eval("CourseID") %>'>
                                    <i class="fas fa-edit"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lbtnDelete" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                    CommandName="DeleteCourse" CommandArgument='<%# Eval("CourseID") %>'
                                    OnClientClick="return confirmDelete('Deactivate this course?');">
                                    <i class="fas fa-trash-alt"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center py-4 text-muted">
                            <i class="fas fa-graduation-cap fa-2x mb-2 d-block"></i>No courses found.
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>
