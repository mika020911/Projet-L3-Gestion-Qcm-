<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Examen" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
ArrayList<Examen> liste = (ArrayList<Examen>) request.getAttribute("liste");
String filtreNiveau   = (String) request.getAttribute("filtreNiveau");
String filtreEtudiant = (String) request.getAttribute("filtreEtudiant");
if (filtreNiveau   == null) filtreNiveau   = "";
if (filtreEtudiant == null) filtreEtudiant = "";
int count = (liste != null) ? liste.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Notes</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/listE.css">
</head>
<body>

<button class="menu-btn" onclick="toggleMenu()">☰</button>

<div class="layout">
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <h2>🎓 ExamPro</h2>
            <span>Panneau d'administration</span>
        </div>
        <nav class="sidebar-nav">
            <a href="DashboardServlet"><span class="icon">📊</span> Dashboard</a>
            <a href="ListeEtudiantServlet"><span class="icon">👨‍🎓</span> Étudiants</a>
            <a href="ListeQcmServlet"><span class="icon">📝</span> Gestion QCM</a>
            <a href="NotesServlet" class="active"><span class="icon">📋</span> Notes</a>
            <a href="ClassementServlet"><span class="icon">🏆</span> Classement</a>
        </nav>
        <div class="sidebar-footer">
            <a href="LogoutServlet">🚪 Déconnexion</a>
        </div>
    </aside>

    <main class="main-content">

        <div class="page-header fade-up">
            <div>
                <h1>📋 Notes des étudiants</h1>
                <p>Historique de tous les examens passés</p>
            </div>
            <a href="ClassementServlet" class="btn btn-primary">🏆 Voir classement</a>
        </div>

        <div class="list-page">

            <!-- Filtres -->
            <div class="toolbar fade-up">

                <!-- Filtre par numéro étudiant -->
                <form class="search-box" action="NotesServlet" method="get">
                    <input type="text" name="num_etudiant"
                           value="<%= filtreEtudiant %>"
                           placeholder="N° étudiant...">
                    <button type="submit">Chercher</button>
                </form>

                <!-- Filtre par niveau -->
                <form action="NotesServlet" method="get">
                    <select class="filter-select" name="niveau" onchange="this.form.submit()">
                        <option value="">Tous niveaux</option>
                        <option value="L1" <%= "L1".equals(filtreNiveau) ? "selected" : "" %>>L1</option>
                        <option value="L2" <%= "L2".equals(filtreNiveau) ? "selected" : "" %>>L2</option>
                        <option value="L3" <%= "L3".equals(filtreNiveau) ? "selected" : "" %>>L3</option>
                        <option value="M1" <%= "M1".equals(filtreNiveau) ? "selected" : "" %>>M1</option>
                        <option value="M2" <%= "M2".equals(filtreNiveau) ? "selected" : "" %>>M2</option>
                    </select>
                </form>

                <% if (!filtreNiveau.isEmpty() || !filtreEtudiant.isEmpty()) { %>
                <a href="NotesServlet" class="btn btn-ghost" style="padding:8px 14px;height:40px;">🔄 Tout voir</a>
                <% } %>

                <span class="result-count"><%= count %> résultat(s)</span>
            </div>

            <!-- Tableau -->
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Numéro</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Niveau</th>
                            <th>Année</th>
                            <th style="text-align:center;">Note / 10</th>
                            <th style="text-align:center;">Mention</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    if (liste != null && !liste.isEmpty()) {
                        int i = 0;
                        for (Examen ex : liste) {
                            i++;
                            // Calculer mention selon note
                            String mention;
                            String mentionColor;
                            int note = ex.getNote();
                            if      (note >= 9) { mention = "Très Bien";   mentionColor = "#22c55e"; }
                            else if (note >= 7) { mention = "Bien";         mentionColor = "#4f6ef7"; }
                            else if (note >= 5) { mention = "Assez Bien";   mentionColor = "#f59e0b"; }
                            else if (note >= 3) { mention = "Passable";     mentionColor = "#f97316"; }
                            else                { mention = "Insuffisant";  mentionColor = "#ef4444"; }
                    %>
                    <tr>
                        <td style="color:var(--text-dim);font-size:12px;font-family:var(--font-mono);"><%= i %></td>
                        <td><code style="font-size:12px;font-family:var(--font-mono);color:var(--text-muted);"><%= ex.getNum_etudiant() %></code></td>
                        <td style="font-weight:600;"><%= ex.getNom() %></td>
                        <td><%= ex.getPrenom() %></td>
                        <td><span class="badge badge-<%= ex.getNiveau() %>"><%= ex.getNiveau() %></span></td>
                        <td style="color:var(--text-muted);font-size:13px;"><%= ex.getAnnee_Sco() %></td>
                        <td style="text-align:center;">
                            <!-- Barre visuelle de la note -->
                            <div style="display:flex;align-items:center;gap:8px;justify-content:center;">
                                <div style="width:80px;height:6px;background:var(--border);border-radius:99px;overflow:hidden;">
                                    <div style="width:<%= (note * 10) %>%;height:100%;background:<%= mentionColor %>;border-radius:99px;"></div>
                                </div>
                                <span style="font-family:var(--font-mono);font-weight:700;color:<%= mentionColor %>;font-size:14px;">
                                    <%= note %>/10
                                </span>
                            </div>
                        </td>
                        <td style="text-align:center;">
                            <span style="font-size:12px;font-weight:700;color:<%= mentionColor %>;
                                         background:rgba(0,0,0,0.2);padding:3px 10px;border-radius:99px;
                                         border:1px solid <%= mentionColor %>30;">
                                <%= mention %>
                            </span>
                        </td>
                    </tr>
                    <%
                        }
                    } else { %>
                    <tr>
                        <td colspan="8">
                            <div class="empty-state">
                                <div class="icon">📋</div>
                                <p>Aucune note trouvée.</p>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </main>
</div>

<script src="assets/js/main.js"></script>
</body>
</html>
