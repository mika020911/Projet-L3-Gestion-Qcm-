/**
 * 
 */
/* ============================================================
   CHARTS.JS — Graphiques du Dashboard (Chart.js)
   ============================================================ */

document.addEventListener('DOMContentLoaded', function () {

    const ctx = document.getElementById('niveauChart');
    if (!ctx) return;

    // Lire les valeurs depuis les attributs data de la canvas
    const l1 = parseInt(ctx.dataset.l1 || 0);
    const l2 = parseInt(ctx.dataset.l2 || 0);
    const l3 = parseInt(ctx.dataset.l3 || 0);
    const m1 = parseInt(ctx.dataset.m1 || 0);
    const m2 = parseInt(ctx.dataset.m2 || 0);

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['L1', 'L2', 'L3', 'M1', 'M2'],
            datasets: [{
                label: 'Étudiants',
                data: [l1, l2, l3, m1, m2],
                backgroundColor: [
                    'rgba(6,182,212,0.7)',
                    'rgba(59,130,246,0.7)',
                    'rgba(139,92,246,0.7)',
                    'rgba(236,72,153,0.7)',
                    'rgba(244,63,94,0.7)'
                ],
                borderColor: [
                    'rgb(6,182,212)',
                    'rgb(59,130,246)',
                    'rgb(139,92,246)',
                    'rgb(236,72,153)',
                    'rgb(244,63,94)'
                ],
                borderWidth: 2,
                borderRadius: 8,
                borderSkipped: false,
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#131625',
                    borderColor: '#252840',
                    borderWidth: 1,
                    titleColor: '#e8eaf6',
                    bodyColor: '#7b80a8',
                    padding: 12,
                    callbacks: {
                        label: function (ctx) {
                            return '  ' + ctx.parsed.y + ' étudiant(s)';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { color: '#252840' },
                    ticks: { color: '#7b80a8', font: { family: 'Sora', size: 13, weight: '600' } }
                },
                y: {
                    grid: { color: '#252840' },
                    ticks: {
                        color: '#7b80a8',
                        font: { family: 'JetBrains Mono', size: 12 },
                        stepSize: 1
                    },
                    beginAtZero: true
                }
            }
        }
    });
});