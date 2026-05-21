<%@ Page Title="FAQ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="MindSpace.User.FAQ" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="cl-header">
        <h2 class="cl-header-title">Frequently Asked <span class="cl-header-accent">Questions</span></h2>
        <p class="cl-header-sub">Quick answers about how MindSpace works. Tap any question to expand.</p>
    </div>

    <div class="faq-list">
        <div class="faq-item">
            <button type="button" class="faq-q">
                <span>What is MindSpace?</span>
                <i class="fa-solid fa-chevron-down faq-chev"></i>
            </button>
            <div class="faq-a">
                <div class="faq-a-inner">
                    MindSpace is a mental health education platform offering evidence-based courses on stress, anxiety, sleep, mindfulness, resilience, and self-care.
                </div>
            </div>
        </div>

        <div class="faq-item">
            <button type="button" class="faq-q">
                <span>How do I enrol in a course?</span>
                <i class="fa-solid fa-chevron-down faq-chev"></i>
            </button>
            <div class="faq-a">
                <div class="faq-a-inner">
                    Browse the courses page, click <strong>View Course</strong>, then click <strong>Enrol</strong>.
                </div>
            </div>
        </div>

        <div class="faq-item">
            <button type="button" class="faq-q">
                <span>How do quizzes work?</span>
                <i class="fa-solid fa-chevron-down faq-chev"></i>
            </button>
            <div class="faq-a">
                <div class="faq-a-inner">
                    Each course has a quiz with a 70% passing threshold. You can retake quizzes as many times as needed.
                </div>
            </div>
        </div>

        <div class="faq-item">
            <button type="button" class="faq-q">
                <span>How is my progress tracked?</span>
                <i class="fa-solid fa-chevron-down faq-chev"></i>
            </button>
            <div class="faq-a">
                <div class="faq-a-inner">
                    Your progress is automatically tracked as you complete course materials and quizzes. View it under the <strong>Progress</strong> section.
                </div>
            </div>
        </div>

        <div class="faq-item">
            <button type="button" class="faq-q">
                <span>How do bookmarks work?</span>
                <i class="fa-solid fa-chevron-down faq-chev"></i>
            </button>
            <div class="faq-a">
                <div class="faq-a-inner">
                    Click the bookmark icon on any course card to save it. Access all bookmarked courses under <strong>Bookmarks</strong> in the sidebar.
                </div>
            </div>
        </div>

        <div class="faq-item">
            <button type="button" class="faq-q">
                <span>How do I change my password?</span>
                <i class="fa-solid fa-chevron-down faq-chev"></i>
            </button>
            <div class="faq-a">
                <div class="faq-a-inner">
                    Go to <strong>Account</strong> in the sidebar and select <strong>Change Password</strong>.
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* FAQ accordion: clicking a question toggles open/closed */
(function () {
    var items = document.querySelectorAll('.faq-item');
    items.forEach(function (item) {
        var q = item.querySelector('.faq-q');
        if (!q) return;
        q.addEventListener('click', function () {
            item.classList.toggle('open');
        });
    });
})();
</script>
</asp:Content>
