<%@ Page Title="Browse Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="MindSpace.CourseList" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-graduation-cap me-2"></i>Browse Courses</h1>
            <p>Explore evidence-based mental health learning modules at your own pace</p>
        </div>
    </div>

    <div class="container py-4">

        <!-- SEARCH & FILTER -->
        <div class="ms-card p-3 mb-4">
            <div class="row g-2 align-items-end">
                <div class="col-md-4">
                    <label class="form-label small fw-semibold">Search</label>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                        placeholder="Search courses..." />
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-semibold">Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">All Categories</asp:ListItem>
                        <asp:ListItem Value="Stress Management">Stress Management</asp:ListItem>
                        <asp:ListItem Value="Mindfulness">Mindfulness</asp:ListItem>
                        <asp:ListItem Value="Anxiety">Anxiety</asp:ListItem>
                        <asp:ListItem Value="Sleep Hygiene">Sleep Hygiene</asp:ListItem>
                        <asp:ListItem Value="Resilience">Resilience</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-semibold">Level</label>
                    <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">All Levels</asp:ListItem>
                        <asp:ListItem Value="Beginner">Beginner</asp:ListItem>
                        <asp:ListItem Value="Intermediate">Intermediate</asp:ListItem>
                        <asp:ListItem Value="Advanced">Advanced</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <div class="d-flex gap-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                            CausesValidation="false" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                            CausesValidation="false" OnClick="btnClear_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- RESULTS SUMMARY -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <p class="text-muted mb-0 small">
                Showing <strong><asp:Literal ID="litCount" runat="server" /></strong> course(s)
            </p>
        </div>

        <!-- COURSE GRID -->
        <asp:Repeater ID="rptCourses" runat="server">
            <HeaderTemplate><div class="row g-4"></HeaderTemplate>
            <ItemTemplate>
                <div class="col-md-6 col-xl-4">
                    <div class="course-card">
                        <div class="course-card-header">
                            <span class="course-cat-badge cat-<%# GetCatClass(Eval("Category").ToString()) %>">
                                <%# Eval("Category") %>
                            </span>
                            <div class="course-icon"><%# GetCourseIcon(Eval("Category").ToString()) %></div>
                            <h5 class="course-card-title"><%# Eval("Title") %></h5>
                        </div>
                        <div class="course-card-body">
                            <p class="course-card-desc"><%# Eval("Description") %></p>
                            <div class="course-card-meta">
                                <span><i class="fas fa-signal me-1"></i><%# Eval("DifficultyLevel") %></span>
                                <span><i class="fas fa-clock me-1"></i><%# Eval("Duration") %></span>
                                <span><i class="fas fa-users me-1"></i><%# Eval("EnrollmentCount") %> enrolled</span>
                            </div>
                        </div>
                        <div class="course-card-footer">
                            <%# Convert.ToBoolean(Eval("IsEnrolled")) ?
                                "<span class='badge bg-success me-auto'><i class=\"fas fa-check me-1\"></i>Enrolled</span>" : "" %>
                            <a href="<%: ResolveUrl("~/Courses/CourseDetail.aspx") %>?id=<%# Eval("CourseID") %>"
                               class="btn btn-primary btn-sm ms-auto">
                                <%# Convert.ToBoolean(Eval("IsEnrolled")) ? "Continue" : "View Course" %>
                                <i class="fas fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate></div></FooterTemplate>
        </asp:Repeater>

        <!-- Empty state -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="text-center py-5 text-muted">
                <i class="fas fa-search fa-3x mb-3 d-block" style="color:#ddd;"></i>
                <p>No courses match your search. Try different keywords or clear the filters.</p>
                <asp:Button ID="btnReset" runat="server" Text="Show All Courses"
                    CssClass="btn btn-outline-primary" CausesValidation="false" OnClick="btnClear_Click" />
            </div>
        </asp:Panel>

    </div>
</asp:Content>
