<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Quiz.aspx.cs" Inherits="MindSpace.QuizPage" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-clipboard-check me-2"></i><asp:Literal ID="litQuizTitle" runat="server" /></h1>
            <p><asp:Literal ID="litQuizDesc" runat="server" /></p>
        </div>
    </div>

    <div class="container py-4" style="max-width:800px;">

        <!-- Quiz info bar -->
        <div class="ms-card p-3 mb-4 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div class="d-flex gap-4">
                <span class="small text-muted">
                    <i class="fas fa-question-circle me-1 text-primary"></i>
                    <strong><asp:Literal ID="litQuestionCount" runat="server" /></strong> questions
                </span>
                <span class="small text-muted">
                    <i class="fas fa-star me-1 text-warning"></i>
                    Passing score: <strong><asp:Literal ID="litPassingScore" runat="server" />%</strong>
                </span>
            </div>
            <span class="badge bg-primary">Attempt the quiz below</span>
        </div>

        <!-- Quiz Form -->
        <asp:HiddenField ID="hdnQuizID" runat="server" />
        <asp:HiddenField ID="hdnTotalQuestions" runat="server" />

        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <div class="quiz-question-card">
                    <div class="quiz-question-num">Question <%# Container.ItemIndex + 1 %></div>
                    <div class="quiz-question-text"><%# Eval("QuestionText") %></div>

                    <%# Eval("QuestionType").ToString() == "truefalse" ?
                        RenderTrueFalse((int)Eval("QuestionID")) :
                        RenderOptions((int)Eval("QuestionID")) %>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Submit -->
        <div class="text-center mt-4">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz"
                CssClass="btn btn-success btn-lg px-5 fw-bold"
                OnClick="btnSubmit_Click"
                OnClientClick="return validateAllAnswered();" />
            <div class="text-muted small mt-2">
                <i class="fas fa-info-circle me-1"></i>Make sure you answer all questions before submitting.
            </div>
        </div>

    </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    function validateAllAnswered() {
        var cards = document.querySelectorAll('.quiz-question-card');
        for (var i = 0; i < cards.length; i++) {
            var radios = cards[i].querySelectorAll('input[type="radio"]');
            if (radios.length === 0) continue;
            var answered = false;
            radios.forEach(function (r) { if (r.checked) answered = true; });
            if (!answered) {
                alert('Please answer Question ' + (i + 1) + ' before submitting.');
                cards[i].scrollIntoView({ behavior: 'smooth', block: 'center' });
                return false;
            }
        }
        return true;
    }

    // Highlight selected option
    document.addEventListener('change', function (e) {
        if (e.target && e.target.type === 'radio') {
            var options = e.target.closest('.quiz-question-card').querySelectorAll('.quiz-option');
            options.forEach(function (opt) {
                opt.style.borderColor = '';
                opt.style.background  = '';
            });
            var parentOpt = e.target.closest('.quiz-option');
            if (parentOpt) {
                parentOpt.style.borderColor = '#6C5CE7';
                parentOpt.style.background  = 'rgba(108,92,231,0.06)';
            }
        }
    });
</script>
</asp:Content>
