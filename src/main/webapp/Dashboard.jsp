<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Admin</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<button class="menu-btn" onclick="toggleMenu()">☰</button>

<div class="layout">

    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <h2>🎓 ExamPro</h2>
            <span>Panneau d'administration</span>
        </div>
        <nav class="sidebar-nav">
            <a href="DashboardServlet" class="active"><span class="icon">📊</span> Dashboard</a>
            <a href="ListeEtudiantServlet"><span class="icon">👨‍🎓</span> Étudiants</a>
            <a href="AjouterEtudiant.jsp"><span class="icon">➕</span> Ajouter étudiant</a>
            <a href="ListeQcmServlet"><span class="icon">📝</span> Gestion QCM</a>
            <a href="AjouterQcm.jsp"><span class="icon">➕</span> Ajouter QCM</a>
            <a href="NotesServlet"><span class="icon">📋</span> Notes</a>
            <a href="ClassementServlet"><span class="icon">🏆</span> Classement</a>
        </nav>
        <div class="sidebar-footer">
            <a href="LogoutServlet">🚪 Déconnexion</a>
        </div>
    </aside>

    <!-- Contenu -->
    <main class="main-content">

        <div class="page-header fade-up">
            <div>
                <h1>Tableau de bord</h1>
                <p>Vue d'ensemble des étudiants par niveau</p>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card fade-up">
                <div class="label">Total étudiants</div>
                <div class="value"><%= request.getAttribute("total") %></div>
            </div>
            <div class="stat-card l1 fade-up fade-up-delay-1">
                <div class="label">Licence 1</div>
                <div class="value"><%= request.getAttribute("l1") %></div>
            </div>
            <div class="stat-card l2 fade-up fade-up-delay-2">
                <div class="label">Licence 2</div>
                <div class="value"><%= request.getAttribute("l2") %></div>
            </div>
            <div class="stat-card l3 fade-up fade-up-delay-3">
                <div class="label">Licence 3</div>
                <div class="value"><%= request.getAttribute("l3") %></div>
            </div>
            <div class="stat-card m1 fade-up fade-up-delay-4">
                <div class="label">Master 1</div>
                <div class="value"><%= request.getAttribute("m1") %></div>
            </div>
            <div class="stat-card m2 fade-up fade-up-delay-4">
                <div class="label">Master 2</div>
                <div class="value"><%= request.getAttribute("m2") %></div>
            </div>
        </div>

        <!-- Graphique -->
        <div class="chart-wrapper">
            <h3>Répartition par niveau</h3>
            <canvas id="niveauChart" style="height:260px;"></canvas>
        </div>

    </main>
</div>

<script src="assets/js/main.js"></script>

<%
// Valeurs injectées directement en Java → pas de guillemets imbriqués
int vL1 = request.getAttribute("l1") != null ? (int) request.getAttribute("l1") : 0;
int vL2 = request.getAttribute("l2") != null ? (int) request.getAttribute("l2") : 0;
int vL3 = request.getAttribute("l3") != null ? (int) request.getAttribute("l3") : 0;
int vM1 = request.getAttribute("m1") != null ? (int) request.getAttribute("m1") : 0;
int vM2 = request.getAttribute("m2") != null ? (int) request.getAttribute("m2") : 0;
%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// Les valeurs sont écrites directement par JSP — aucun data-* à lire
window.addEventListener('load', function () {
    var ctx = document.getElementById('niveauChart').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['L1', 'L2', 'L3', 'M1', 'M2'],
            datasets: [{
                label: 'Étudiants',
                data: [<%= vL1 %>, <%= vL2 %>, <%= vL3 %>, <%= vM1 %>, <%= vM2 %>],
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
                borderSkipped: false
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
                        label: function(ctx) {
                            return '  ' + ctx.parsed.y + ' étudiant(s)';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { color: '#252840' },
                    ticks: {
                        color: '#7b80a8',
                        font: { size: 13, weight: '600' }
                    }
                },
                y: {
                    grid: { color: '#252840' },
                    ticks: {
                        color: '#7b80a8',
                        font: { size: 12 },
                        stepSize: 1
                    },
                    beginAtZero: true
                }
            }
        }
    });
});
</script>
</body>
</html>
