<%@ Page Title="Quiz Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="QuizResults.aspx.cs" Inherits="MindSpace.QuizResults" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-poll me-2"></i>Quiz Results</h1>
            <p>Here's how you performed on <strong><asp:Literal ID="litQuizTitle" runat="server" /></strong></p>
        </div>
    </div>

    <div class="container py-4" style="max-width:700px;">

        <!-- SCORE CARD -->
        <div class="ms-card p-4 mb-4 text-center">

            <!-- Score Circle (class set in code-behind) -->
            <div id="divScoreCircle" runat="server" class="score-circle mx-auto mb-3">
                <div class="score-num"><asp:Literal ID="litPercentage" runat="server" />%</div>
                <div class="score-label"><asp:Literal ID="litScore" runat="server" /></div>
            </div>

            <h3 class="fw-bold mb-2"><asp:Literal ID="litResultLabel" runat="server" /></h3>

            <div class="mb-3">
                <asp:Label ID="lblPassFailBadge" runat="server" CssClass="badge fs-6 px-3 py-2" />
            </div>

            <p class="text-muted mb-4"><asp:Literal ID="litFeedback" runat="server" /></p>

            <div class="row g-3 mb-4">
                <div class="col-4">
                    <div class="p-3 rounded" style="background:rgba(0,184,148,0.08);">
                        <div class="fw-bold fs-5 text-success"><asp:Literal ID="litCorrect" runat="server" /></div>
                        <div class="text-muted small">Correct</div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="p-3 rounded" style="background:rgba(225,112,85,0.08);">
                        <div class="fw-bold fs-5 text-danger"><asp:Literal ID="litIncorrect" runat="server" /></div>
                        <div class="text-muted small">Incorrect</div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="p-3 rounded" style="background:rgba(108,92,231,0.08);">
                        <div class="fw-bold fs-5 text-primary"><asp:Literal ID="litTotal" runat="server" /></div>
                        <div class="text-muted small">Total</div>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-2 justify-content-center flex-wrap">
                <asp:HyperLink ID="hlRetake" runat="server" CssClass="btn btn-primary">
                    <i class="fas fa-redo me-2"></i>Retake Quiz
                </asp:HyperLink>
                <asp:HyperLink ID="hlCourse" runat="server" CssClass="btn btn-outline-secondary">
                    <i class="fas fa-book-open me-2"></i>Back to Course
                </asp:HyperLink>
                <a href="../User/UserHome.aspx" class="btn btn-outline-primary">
                    <i class="fas fa-home me-2"></i>My Dashboard
                </a>
            </div>
        </div>

        <!-- ANSWER REVIEW -->
        <asp:Panel ID="pnlReview" runat="server" Visible="false">
            <h5 class="fw-bold mb-3">
                <i class="fas fa-list-check me-2 text-primary"></i>Question Review
            </h5>

            <asp:Repeater ID="rptReview" runat="server">
                <ItemTemplate>
                    <div class="quiz-question-card mb-3"
                         style="border-left:4px solid #74B9FF;">
                        <div class="quiz-question-num">Question <%# Container.ItemIndex + 1 %></div>
                        <div class="quiz-question-text"><%# Eval("QuestionText") %></div>
                        <div class="mt-2 small">
                            <span class="badge bg-success">
                                <i class="fas fa-check me-1"></i>Correct Answer:
                                <%# Eval("CorrectAnswer") %>
                            </span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

    </div>
</asp:Content>
