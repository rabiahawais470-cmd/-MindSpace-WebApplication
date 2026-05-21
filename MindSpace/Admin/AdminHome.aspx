<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="MindSpace.AdminHome" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="dash-banner">
        <h2>Welcome back, <asp:Literal ID="litAdminName" runat="server" /></h2>
        <p>Here&rsquo;s a quick overview of MindSpace activity.</p>
    </div>

    <!-- STATS CARDS -->
    <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fa-solid fa-users"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litTotalUsers" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Registered Learners</div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon green"><i class="fa-solid fa-graduation-cap"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litTotalCourses" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Active Courses</div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fa-solid fa-book-open-reader"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litTotalEnrollments" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Total Enrollments</div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fa-solid fa-comments"></i></div>
                <div>
                    <div class="stat-num"><asp:Literal ID="litTotalPosts" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Forum Posts</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <!-- RECENT USERS -->
        <div class="col-lg-6">
            <div class="admin-table">
                <div class="card-header-custom d-flex justify-content-between align-items-center">
                    <span><i class="fa-solid fa-users me-2"></i>Recent Users</span>
                    <a href="UserManagement.aspx" class="btn btn-sm">Manage All</a>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvRecentUsers" runat="server"
                        AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                        GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="FullName" HeaderText="Name" />
                            <asp:BoundField DataField="Username" HeaderText="Username" />
                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate>
                                    <span class="badge <%# Eval("Role").ToString() == "admin" ? "badge-role-admin" : "badge-role-learner" %>">
                                        <%# Eval("Role").ToString() == "admin" ? "Admin" : "Learner" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DateRegistered" HeaderText="Registered"
                                DataFormatString="{0:dd MMM yyyy}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- COURSES OVERVIEW -->
        <div class="col-lg-6">
            <div class="admin-table">
                <div class="card-header-custom d-flex justify-content-between align-items-center">
                    <span><i class="fa-solid fa-graduation-cap me-2"></i>Courses Overview</span>
                    <a href="CourseManagement.aspx" class="btn btn-sm">Manage All</a>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvCourses" runat="server"
                        AutoGenerateColumns="false" CssClass="table table-hover mb-0"
                        GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Course" />
                            <asp:BoundField DataField="Category" HeaderText="Category" />
                            <asp:BoundField DataField="EnrollmentCount" HeaderText="Enrolled" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class="badge <%# Convert.ToBoolean(Eval("IsActive")) ? "bg-success" : "bg-secondary" %>">
                                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- QUICK LINKS -->
    <div class="row g-3 mt-2">
        <div class="col-12">
            <h6 class="fw-bold mb-3"><i class="fa-solid fa-bolt me-2" style="color: var(--color-warning);"></i>Quick Actions</h6>
        </div>
        <div class="col-sm-6 col-md-4 col-lg-3">
            <a href="UserManagement.aspx" class="d-block text-decoration-none">
                <div class="card p-3 text-center">
                    <i class="fa-solid fa-user-plus fa-2x mb-2" style="color: var(--color-primary);"></i>
                    <div class="fw-semibold small" style="color: var(--color-text-primary);">Add New User</div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-md-4 col-lg-3">
            <a href="CourseManagement.aspx" class="d-block text-decoration-none">
                <div class="card p-3 text-center">
                    <i class="fa-solid fa-plus-circle fa-2x mb-2" style="color: var(--color-success);"></i>
                    <div class="fw-semibold small" style="color: var(--color-text-primary);">Add New Course</div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-md-4 col-lg-3">
            <a href="../User/Discussions.aspx" class="d-block text-decoration-none">
                <div class="card p-3 text-center">
                    <i class="fa-solid fa-comments fa-2x mb-2" style="color: #06B6D4;"></i>
                    <div class="fw-semibold small" style="color: var(--color-text-primary);">View Discussions</div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-md-4 col-lg-3">
            <a href="../ChangePassword.aspx" class="d-block text-decoration-none">
                <div class="card p-3 text-center">
                    <i class="fa-solid fa-key fa-2x mb-2" style="color: var(--color-warning);"></i>
                    <div class="fw-semibold small" style="color: var(--color-text-primary);">Change Password</div>
                </div>
            </a>
        </div>
    </div>

</asp:Content>
