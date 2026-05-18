<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="MindSpace.QuizPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Focus mode — hide main sidebar + topbar for quiz */
        #sidebar, .app-topbar { display: none !important; }
        .app-main, .app-content { padding: 0 !important; }
        body { background: #F4F2FA; }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex" style="min-height: 100vh;">

        <!-- DARK LEFT PANEL — Quiz info + timer -->
        <aside class="quiz-dark-panel">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <a href="javascript:history.back()" class="btn btn-sm btn-outline-light">
                    <i class="fa-solid fa-arrow-left"></i>
                </a>
                <span class="text-white-50 small">Quiz Mode</span>
            </div>

            <h6 class="fw-bold mb-1" style="color: #fff; font-family: var(--font-heading);">
                <asp:Literal ID="litQuizTitle" runat="server" />
            </h6>
            <p class="text-white-50 mb-4" style="font-size: 0.75rem; line-height: 1.5;">
                <asp:Literal ID="litQuizDesc" runat="server" />
            </p>

            <div class="d-flex flex-column gap-2 mb-3">
                <div class="d-flex justify-content-between text-white-50" style="font-size: 0.72rem;">
                    <span>Questions</span>
                    <span class="fw-bold" style="color: #fff;"><asp:Literal ID="litQuestionCount" runat="server" /></span>
                </div>
                <div class="d-flex justify-content-between text-white-50" style="font-size: 0.72rem;">
                    <span>Passing Score</span>
                    <span class="fw-bold" style="color: #fff;"><asp:Literal ID="litPassingScore" runat="server" />%</span>
                </div>
            </div>

            <!-- Timer -->
            <div class="quiz-timer">
                <div class="quiz-timer-label">Time Elapsed</div>
                <div class="quiz-timer-display" id="timerDisplay">00:00</div>
            </div>
        </aside>

        <!-- MAIN QUIZ AREA -->
        <div style="flex: 1; padding: 40px clamp(20px, 4vw, 60px); max-width: 900px; margin: 0 auto;">

            <div class="mb-4">
                <div style="color: var(--color-primary); font-size: var(--text-sm); font-weight: 600;">
                    <i class="fa-solid fa-clipboard-check me-1"></i>Quiz in Progress
                </div>
            </div>

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

            <div class="d-flex justify-content-between align-items-center mt-4">
                <div class="text-muted small">
                    <i class="fa-solid fa-circle-info me-1"></i>Answer all questions before submitting.
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz"
                    CssClass="btn btn-primary btn-lg"
                    OnClick="btnSubmit_Click"
                    OnClientClick="return validateAllAnswered();" />
            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    // Timer (counts up while quiz is active)
    (function () {
        var start = Date.now();
        var el = document.getElementById('timerDisplay');
        if (!el) return;
        function tick() {
            var diff = Math.floor((Date.now() - start) / 1000);
            var m = String(Math.floor(diff / 60)).padStart(2, '0');
            var s = String(diff % 60).padStart(2, '0');
            el.textContent = m + ':' + s;
        }
        setInterval(tick, 1000);
        tick();
    })();

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
            var card = e.target.closest('.quiz-question-card');
            if (!card) return;
            card.querySelectorAll('.quiz-option').forEach(function (opt) {
                opt.classList.remove('selected');
            });
            var parentOpt = e.target.closest('.quiz-option');
            if (parentOpt) parentOpt.classList.add('selected');
        }
    });
</script>
</asp:Content>
