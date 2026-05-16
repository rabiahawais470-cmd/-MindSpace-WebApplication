/* =============================================
   MindSpace - Client-Side Form Validation
   APU Group G29
   ============================================= */

'use strict';

/* Password strength indicator */
function checkPasswordStrength(passwordId, strengthBarId) {
    var pwd = document.getElementById(passwordId);
    var bar = document.getElementById(strengthBarId);
    if (!pwd || !bar) return;

    pwd.addEventListener('input', function () {
        var val = pwd.value;
        var score = 0;
        var tips = [];

        if (val.length >= 8)  score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[a-z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        bar.style.width = (score * 20) + '%';

        if (score <= 1) {
            bar.className = 'progress-bar bg-danger';
            bar.title = 'Weak';
        } else if (score <= 2) {
            bar.className = 'progress-bar bg-warning';
            bar.title = 'Fair';
        } else if (score <= 3) {
            bar.className = 'progress-bar bg-info';
            bar.title = 'Good';
        } else {
            bar.className = 'progress-bar bg-success';
            bar.title = 'Strong';
        }
    });
}

/* Confirm password match highlight */
function bindPasswordConfirm(pwdId, confirmId, feedbackId) {
    var pwd     = document.getElementById(pwdId);
    var confirm = document.getElementById(confirmId);
    var feedback = document.getElementById(feedbackId);
    if (!pwd || !confirm) return;

    function check() {
        if (confirm.value === '') return;
        if (pwd.value === confirm.value) {
            confirm.style.borderColor = '#00B894';
            if (feedback) { feedback.textContent = ''; feedback.style.color = ''; }
        } else {
            confirm.style.borderColor = '#E17055';
            if (feedback) {
                feedback.textContent = 'Passwords do not match.';
                feedback.style.color = '#c0392b';
                feedback.style.fontSize = '0.78rem';
            }
        }
    }
    confirm.addEventListener('input', check);
    pwd.addEventListener('input', check);
}

/* Auto-dismiss alerts after 4 seconds */
document.addEventListener('DOMContentLoaded', function () {
    var alerts = document.querySelectorAll('.alert-auto-dismiss');
    alerts.forEach(function (el) {
        setTimeout(function () {
            el.style.transition = 'opacity 0.5s';
            el.style.opacity = '0';
            setTimeout(function () { el.remove(); }, 500);
        }, 4000);
    });
});

/* Confirm delete dialog */
function confirmDelete(message) {
    return confirm(message || 'Are you sure you want to delete this record?');
}

/* Quiz: ensure all questions answered before submit */
function validateQuizForm(totalQuestions) {
    for (var i = 1; i <= totalQuestions; i++) {
        var radios = document.querySelectorAll('input[name*="q' + i + '_"]');
        if (radios.length === 0) continue;
        var answered = false;
        radios.forEach(function (r) { if (r.checked) answered = true; });
        if (!answered) {
            alert('Please answer question ' + i + ' before submitting.');
            return false;
        }
    }
    return true;
}

/* Username: no spaces, alphanumeric + underscore only */
function bindUsernameValidation(fieldId, feedbackId) {
    var field    = document.getElementById(fieldId);
    var feedback = document.getElementById(feedbackId);
    if (!field) return;

    field.addEventListener('input', function () {
        var val = field.value;
        var valid = /^[A-Za-z0-9_]{3,}$/.test(val);
        if (!valid && val.length > 0) {
            field.style.borderColor = '#E17055';
            if (feedback) {
                feedback.textContent = 'Username must be at least 3 characters: letters, numbers, or underscore only.';
                feedback.style.color = '#c0392b';
                feedback.style.fontSize = '0.78rem';
            }
        } else {
            field.style.borderColor = val.length > 0 ? '#00B894' : '';
            if (feedback) feedback.textContent = '';
        }
    });
}

/* Email format validation */
function bindEmailValidation(fieldId, feedbackId) {
    var field    = document.getElementById(fieldId);
    var feedback = document.getElementById(feedbackId);
    if (!field) return;

    field.addEventListener('blur', function () {
        var val = field.value;
        var emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (val.length > 0 && !emailRe.test(val)) {
            field.style.borderColor = '#E17055';
            if (feedback) {
                feedback.textContent = 'Please enter a valid email address.';
                feedback.style.color = '#c0392b';
                feedback.style.fontSize = '0.78rem';
            }
        } else if (val.length > 0) {
            field.style.borderColor = '#00B894';
            if (feedback) feedback.textContent = '';
        }
    });
}
