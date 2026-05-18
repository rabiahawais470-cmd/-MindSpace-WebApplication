<%@ Page Title="Quiz Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuizResults.aspx.cs" Inherits="MindSpace.QuizResults" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Focus mode — hide main sidebar + topbar for results */
        #sidebar, .app-topbar { display: none !important; }
        .app-main, .app-content { padding: 0 !important; }
        body { background: #F4F2FA; }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="max-width: 760px; margin: 0 auto; padding: 40px clamp(20px, 4vw, 60px);">

        <div class="mb-4">
            <a href="../User/UserHome.aspx" class="btn btn-sm btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>

        <!-- SCORE SUMMARY -->
        <div class="card p-5 mb-4 text-center">
            <div class="text-muted small mb-2" style="text-transform: uppercase; letter-spacing: 0.08em;">Results</div>
            <h5 class="fw-bold mb-4"><asp:Literal ID="litQuizTitle" runat="server" /></h5>

            <div id="divScoreCircle" runat="server" class="score-circle mx-auto mb-3">
                <div class="score-num"><asp:Literal ID="litPercentage" runat="server" />%</div>
                <div class="score-label"><asp:Literal ID="litScore" runat="server" /></div>
            </div>

            <h4 class="fw-bold mb-2"><asp:Literal ID="litResultLabel" runat="server" /></h4>

            <div class="mb-3">
                <asp:Label ID="lblPassFailBadge" runat="server" CssClass="badge fs-6" />
            </div>

            <p class="text-muted mb-4" style="max-width: 480px; margin-left: auto; margin-right: auto; line-height: 1.6;">
                <asp:Literal ID="litFeedback" runat="server" />
            </p>

            <div class="row g-3 mb-4">
                <div class="col-4">
                    <div class="p-3" style="background: #D1FAE5; border-radius: var(--radius-md);">
                        <div class="fw-bold fs-4" style="color: #065F46;"><asp:Literal ID="litCorrect" runat="server" /></div>
                        <div class="text-muted small">Correct</div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="p-3" style="background: #FEE2E2; border-radius: var(--radius-md);">
                        <div class="fw-bold fs-4" style="color: #991B1B;"><asp:Literal ID="litIncorrect" runat="server" /></div>
                        <div class="text-muted small">Incorrect</div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="p-3" style="background: var(--color-primary-light); border-radius: var(--radius-md);">
                        <div class="fw-bold fs-4" style="color: var(--color-primary);"><asp:Literal ID="litTotal" runat="server" /></div>
                        <div class="text-muted small">Total</div>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-2 justify-content-center flex-wrap">
                <asp:HyperLink ID="hlRetake" runat="server" CssClass="btn btn-primary">
                    <i class="fa-solid fa-rotate-right me-2"></i>Retake Quiz
                </asp:HyperLink>
                <asp:HyperLink ID="hlCourse" runat="server" CssClass="btn btn-outline-secondary">
                    <i class="fa-solid fa-book-open me-2"></i>Back to Course
                </asp:HyperLink>
                <a href="../User/UserHome.aspx" class="btn btn-outline-primary">
                    <i class="fa-solid fa-table-cells-large me-2"></i>Dashboard
                </a>
            </div>
        </div>

        <!-- PER-QUESTION REVIEW -->
        <asp:Panel ID="pnlReview" runat="server" Visible="false">
            <h5 class="fw-bold mb-3"><i class="fa-solid fa-list-check me-2" style="color: var(--color-primary);"></i>Question Review</h5>

            <asp:Repeater ID="rptReview" runat="server">
                <ItemTemplate>
                    <div class="card p-4 mb-3" style="border-left: 4px solid var(--color-success);">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <i class="fa-solid fa-circle-check" style="color: var(--color-success);"></i>
                            <span class="fw-semibold small">Question <%# Container.ItemIndex + 1 %></span>
                        </div>
                        <p class="fw-medium mb-3"><%# System.Web.HttpUtility.HtmlEncode(Eval("QuestionText").ToString()) %></p>
                        <div class="d-flex align-items-center gap-2 p-2" style="background: #D1FAE5; border-radius: var(--radius-md); font-size: var(--text-sm);">
                            <i class="fa-solid fa-check" style="color: #065F46;"></i>
                            <span style="color: #065F46;"><strong><%# Eval("CorrectAnswer") %>.</strong> <%# System.Web.HttpUtility.HtmlEncode(Eval("CorrectAnswerText").ToString()) %></span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

    </div>

</asp:Content>
