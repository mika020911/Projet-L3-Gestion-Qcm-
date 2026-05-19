/**
 * 
 */
/* ============================================================
   TIMER.JS — Chronomètre dégressif pour l'examen
   Usage : <script src="assets/js/timer.js" data-seconds="1200">
   ============================================================ */

document.addEventListener('DOMContentLoaded', function () {

    const timerEl  = document.getElementById('timer');
    const timerWrap = document.querySelector('.timer-wrap');
    const form     = document.getElementById('examForm');

    if (!timerEl || !form) return;

    // Durée configurable via attribut data-seconds (défaut 20 min)
    const script = document.querySelector('script[src*="timer.js"]');
    let temps = script ? parseInt(script.getAttribute('data-seconds') || '1200') : 1200;

    function formatTime(sec) {
        const m = Math.floor(sec / 60);
        const s = sec % 60;
        return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
    }

    function updateTimer() {
        timerEl.textContent = formatTime(temps);

        // Alerte visuelle dans la dernière minute
        if (temps <= 60 && timerWrap) {
            timerWrap.classList.add('danger');
        }

        if (temps <= 0) {
            clearInterval(interval);
            alert('⏰ Temps écoulé ! Soumission automatique.');
            form.submit();
            return;
        }

        temps--;
    }

    updateTimer(); // affichage immédiat
    const interval = setInterval(updateTimer, 1000);
});