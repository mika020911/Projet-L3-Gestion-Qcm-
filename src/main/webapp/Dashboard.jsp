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
            <canvas id="niveauChart" style="height:260px;"
                data-l1="<%= request.getAttribute("l1") %>"
                data-l2="<%= request.getAttribute("l2") %>"
                data-l3="<%= request.getAttribute("l3") %>"
                data-m1="<%= request.getAttribute("m1") %>"
                data-m2="<%= request.getAttribute("m2") %>">
            </canvas>
        </div>

    </main>
</div>

<script src="assets/js/main.js"></script>
<script src="assets/js/charts.js"></script>
</body>
</html>
