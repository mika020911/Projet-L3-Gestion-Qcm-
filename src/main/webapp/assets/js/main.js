/**
 * 
 */
/* ============================================================
   MAIN.JS — Scripts globaux
   ============================================================ */

// ── Sidebar toggle (mobile) ──────────────────────────────────
function toggleMenu() {
    const sidebar = document.getElementById('sidebar');
    if (sidebar) sidebar.classList.toggle('open');
}

// Fermer la sidebar en cliquant en dehors
document.addEventListener('click', function (e) {
    const sidebar = document.getElementById('sidebar');
    const menuBtn = document.querySelector('.menu-btn');
    if (!sidebar || !menuBtn) return;
    if (!sidebar.contains(e.target) && !menuBtn.contains(e.target)) {
        sidebar.classList.remove('open');
    }
});

// ── Auto-dismiss des toasts ──────────────────────────────────
document.addEventListener('DOMContentLoaded', function () {
    const toasts = document.querySelectorAll('.toast');
    toasts.forEach(function (toast) {
        setTimeout(function () {
            toast.style.transition = 'opacity 0.4s ease';
            toast.style.opacity = '0';
            setTimeout(function () { toast.remove(); }, 400);
        }, 3000);
    });
});

// ── Marquer la question comme répondue ──────────────────────
document.addEventListener('change', function (e) {
    if (e.target && e.target.type === 'radio') {
        // Mettre en surbrillance l'option choisie
        const name = e.target.name;
        const allOptions = document.querySelectorAll(`input[name="${name}"]`);
        allOptions.forEach(function (input) {
            const item = input.closest('.option-item');
            if (item) item.classList.remove('selected');
        });
        const selectedItem = e.target.closest('.option-item');
        if (selectedItem) selectedItem.classList.add('selected');

        // Marquer la question card comme répondue
        const questionCard = e.target.closest('.question-card');
        if (questionCard) questionCard.classList.add('answered');

        // Mettre à jour la barre de progression
        updateProgress();
    }
});

function updateProgress() {
    const totalQuestions = document.querySelectorAll('.question-card').length;
    const answered = document.querySelectorAll('.question-card.answered').length;

    const fill = document.querySelector('.progress-fill');
    const label = document.querySelector('.progress-label');

    if (fill) fill.style.width = ((answered / totalQuestions) * 100) + '%';
    if (label) label.textContent = answered + ' / ' + totalQuestions + ' répondues';
}

// ── Initialiser la progression à 0 ──────────────────────────
document.addEventListener('DOMContentLoaded', function () {
    const fill = document.querySelector('.progress-fill');
    if (fill) fill.style.width = '0%';
});