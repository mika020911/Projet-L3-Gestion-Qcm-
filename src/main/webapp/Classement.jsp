<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Examen" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
ArrayList<Examen> classement = (ArrayList<Examen>) request.getAttribute("classement");
String filtreNiveau = (String) request.getAttribute("filtreNiveau");
if (filtreNiveau == null) filtreNiveau = "";
int count = (classement != null) ? classement.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classement — Ordre de mérite</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/listE.css">
	<link rel= "stylesheet" href = "assets/css/Classement.css">
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
            <a href="NotesServlet"><span class="icon">📋</span> Notes</a>
            <a href="ClassementServlet" class="active"><span class="icon">🏆</span> Classement</a>
        </nav>
        <div class="sidebar-footer">
            <a href="LogoutServlet">🚪 Déconnexion</a>
        </div>
    </aside>

    <main class="main-content">

        <div class="page-header fade-up">
            <div>
                <h1>🏆 Classement — Ordre de mérite</h1>
                <p>Classement par moyenne des notes sur l'ensemble des examens</p>
            </div>
        </div>

        <!-- Filtre niveau -->
        <div class="toolbar fade-up" style="margin-bottom:32px;">
            <form action="ClassementServlet" method="get">
                <select class="filter-select" name="niveau" onchange="this.form.submit()"
                        style="min-width:180px;">
                    <option value="">🌐 Tous les niveaux</option>
                    <option value="L1" <%= "L1".equals(filtreNiveau) ? "selected" : "" %>>L1 — Licence 1</option>
                    <option value="L2" <%= "L2".equals(filtreNiveau) ? "selected" : "" %>>L2 — Licence 2</option>
                    <option value="L3" <%= "L3".equals(filtreNiveau) ? "selected" : "" %>>L3 — Licence 3</option>
                    <option value="M1" <%= "M1".equals(filtreNiveau) ? "selected" : "" %>>M1 — Master 1</option>
                    <option value="M2" <%= "M2".equals(filtreNiveau) ? "selected" : "" %>>M2 — Master 2</option>
                </select>
            </form>
            <span class="result-count"><%= count %> étudiant(s) classé(s)</span>
        </div>

        <%
        if (classement != null && classement.size() >= 1) {
            Examen premier  = classement.size() >= 1 ? classement.get(0) : null;
            Examen deuxieme = classement.size() >= 2 ? classement.get(1) : null;
            Examen troisieme= classement.size() >= 3 ? classement.get(2) : null;
        %>

        <!-- Podium top 3 -->
        <div class="podium">

            <!-- 2ème -->
            <% if (deuxieme != null) { %>
            <div class="podium-item second">
                <div class="podium-avatar">🥈</div>
                <div class="podium-name"><%= deuxieme.getNom() %><br><small style="font-weight:400;color:var(--text-muted);"><%= deuxieme.getPrenom() %></small></div>
                <span class="badge badge-<%= deuxieme.getNiveau() %>"><%= deuxieme.getNiveau() %></span>
                <div class="podium-score"><%= deuxieme.getMoyenne() %>/10</div>
                <div class="podium-block">2</div>
            </div>
            <% } %>

            <!-- 1er -->
            <div class="podium-item first">
                <div class="podium-avatar">🥇</div>
                <div class="podium-name"><%= premier.getNom() %><br><small style="font-weight:400;color:var(--text-muted);"><%= premier.getPrenom() %></small></div>
                <span class="badge badge-<%= premier.getNiveau() %>"><%= premier.getNiveau() %></span>
                <div class="podium-score"><%= premier.getMoyenne() %>/10</div>
                <div class="podium-block">1</div>
            </div>

            <!-- 3ème -->
            <% if (troisieme != null) { %>
            <div class="podium-item third">
                <div class="podium-avatar">🥉</div>
                <div class="podium-name"><%= troisieme.getNom() %><br><small style="font-weight:400;color:var(--text-muted);"><%= troisieme.getPrenom() %></small></div>
                <span class="badge badge-<%= troisieme.getNiveau() %>"><%= troisieme.getNiveau() %></span>
                <div class="podium-score"><%= troisieme.getMoyenne() %>/10</div>
                <div class="podium-block">3</div>
            </div>
            <% } %>

        </div>
        <% } %>

        <!-- Tableau complet -->
        <div class="table-wrapper fade-up">
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center;">Rang</th>
                        <th>Numéro</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Niveau</th>
                        <th style="text-align:center;">Examens</th>
                        <th style="text-align:center;">Meilleure note</th>
                        <th>Moyenne / 10</th>
                        <th style="text-align:center;">Mention</th>
                    </tr>
                </thead>
                <tbody>
                <%
                if (classement != null && !classement.isEmpty()) {
                    int rang = 0;
                    for (Examen ex : classement) {
                        rang++;
                        String rankClass = rang == 1 ? "rank-1" : rang == 2 ? "rank-2" : rang == 3 ? "rank-3" : "rank-other";
                        String rankIcon  = rang == 1 ? "🥇" : rang == 2 ? "🥈" : rang == 3 ? "🥉" : String.valueOf(rang);

                        String mention      = ex.getMention();
                        String mentionColor = ex.getMentionColor();
                        double moy          = ex.getMoyenne();
                        int    pct          = (int) Math.round(moy * 10); // sur 100
                %>
                <tr>
                    <td style="text-align:center;">
                        <div class="rank-badge <%= rankClass %>"><%= rankIcon %></div>
                    </td>
                    <td><code style="font-size:12px;font-family:var(--font-mono);color:var(--text-muted);"><%= ex.getNum_etudiant() %></code></td>
                    <td style="font-weight:700;"><%= ex.getNom() %></td>
                    <td><%= ex.getPrenom() %></td>
                    <td><span class="badge badge-<%= ex.getNiveau() %>"><%= ex.getNiveau() %></span></td>
                    <td style="text-align:center;font-family:var(--font-mono);color:var(--text-muted);"><%= ex.getNbExamens() %></td>
                    <td style="text-align:center;font-family:var(--font-mono);font-weight:700;color:var(--text);">
                        <%= ex.getMeilleureNote() %>/10
                    </td>
                    <td>
                        <div class="avg-bar">
                            <div class="avg-bar-track">
                                <div class="avg-bar-fill"
                                     style="width:<%= pct %>%;background:<%= mentionColor %>;"></div>
                            </div>
                            <span style="font-family:var(--font-mono);font-weight:700;color:<%= mentionColor %>;font-size:14px;min-width:42px;">
                                <%= moy %>/10
                            </span>
                        </div>
                    </td>
                    <td style="text-align:center;">
                        <span style="font-size:12px;font-weight:700;color:<%= mentionColor %>;
                                     background:rgba(0,0,0,0.2);padding:3px 10px;
                                     border-radius:99px;border:1px solid <%= mentionColor %>30;">
                            <%= mention %>
                        </span>
                    </td>
                </tr>
                <%
                    }
                } else { %>
                <tr>
                    <td colspan="9">
                        <div class="empty-state">
                            <div class="icon">🏆</div>
                            <p>Aucun résultat disponible pour ce niveau.</p>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </main>
</div>

<script src="assets/js/main.js"></script>
</body>
</html>
