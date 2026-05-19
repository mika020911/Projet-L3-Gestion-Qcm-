<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Qcm" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
ArrayList<Qcm> list = (ArrayList<Qcm>) request.getAttribute("liste");
String filtreNiveau = (String) request.getAttribute("filtreNiveau");
String filtreTheme  = (String) request.getAttribute("filtreTheme");
if (filtreNiveau == null) filtreNiveau = "";
if (filtreTheme  == null) filtreTheme  = "";
int count = (list != null) ? list.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste QCM</title>
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
            <a href="AjouterEtudiant.jsp"><span class="icon">➕</span> Ajouter étudiant</a>
            <a href="ListeQcmServlet" class="active"><span class="icon">📝</span> Gestion QCM</a>
            <a href="AjouterQcm.jsp"><span class="icon">➕</span> Ajouter QCM</a>
        </nav>
        <div class="sidebar-footer">
            <a href="LogoutServlet">🚪 Déconnexion</a>
        </div>
    </aside>

    <main class="main-content">
        <div class="page-header fade-up">
            <div>
                <h1>Gestion QCM</h1>
                <p>Questions filtrables par niveau et thème</p>
            </div>
            <a href="AjouterQcm.jsp" class="btn btn-primary">➕ Ajouter</a>
        </div>

        <div class="list-page">
            <div class="toolbar fade-up">

                <form class="search-box" action="ListeQcmServlet" method="get">
                    <input type="text" name="motCle" placeholder="Rechercher...">
                    <button type="submit">Chercher</button>
                </form>

                <form action="ListeQcmServlet" method="get">
                    <select class="filter-select" name="niveau" onchange="this.form.submit()">
                        <option value="">Tous niveaux</option>
                        <option value="L1" <%= "L1".equals(filtreNiveau)?"selected":"" %>>L1</option>
                        <option value="L2" <%= "L2".equals(filtreNiveau)?"selected":"" %>>L2</option>
                        <option value="L3" <%= "L3".equals(filtreNiveau)?"selected":"" %>>L3</option>
                        <option value="M1" <%= "M1".equals(filtreNiveau)?"selected":"" %>>M1</option>
                        <option value="M2" <%= "M2".equals(filtreNiveau)?"selected":"" %>>M2</option>
                    </select>
                </form>

                <form action="ListeQcmServlet" method="get">
                    <select class="filter-select" name="theme" onchange="this.form.submit()">
                        <option value="">Tous thèmes</option>
                        <option value="Mathematiques"  <%= "Mathematiques".equals(filtreTheme) ?"selected":"" %>>📐 Maths</option>
                        <option value="Physique"        <%= "Physique".equals(filtreTheme)       ?"selected":"" %>>⚗️ Physique</option>
                        <option value="Chimie"          <%= "Chimie".equals(filtreTheme)         ?"selected":"" %>>🧪 Chimie</option>
                        <option value="Informatique"    <%= "Informatique".equals(filtreTheme)   ?"selected":"" %>>💻 Informatique</option>
                        <option value="Histoire"        <%= "Histoire".equals(filtreTheme)       ?"selected":"" %>>📜 Histoire</option>
                        <option value="Geographie"      <%= "Geographie".equals(filtreTheme)     ?"selected":"" %>>🌍 Géo</option>
                        <option value="Biologie"        <%= "Biologie".equals(filtreTheme)       ?"selected":"" %>>🧬 Bio</option>
                        <option value="Economie"        <%= "Economie".equals(filtreTheme)       ?"selected":"" %>>📈 Éco</option>
                        <option value="Droit"           <%= "Droit".equals(filtreTheme)          ?"selected":"" %>>⚖️ Droit</option>
                        <option value="Philosophie"     <%= "Philosophie".equals(filtreTheme)    ?"selected":"" %>>🧠 Philo</option>
                    </select>
                </form>

                <% if (!filtreNiveau.isEmpty() || !filtreTheme.isEmpty()) { %>
                <a href="ListeQcmServlet" class="btn btn-ghost" style="padding:8px 14px;height:40px;">🔄</a>
                <% } %>

                <span class="result-count"><%= count %> question(s)</span>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Question</th>
                            <th>A</th><th>B</th><th>C</th><th>D</th>
                            <th>Bonne rép.</th>
                            <th>Thème</th>
                            <th>Niveau</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    if (list != null && !list.isEmpty()) {
                        for (Qcm q : list) {
                    %>
                    <tr>
                        <td><code style="font-family:var(--font-mono);color:var(--text-muted);font-size:12px;">#<%= q.getNum() %></code></td>
                        <td style="max-width:220px;font-weight:600;font-size:13px;"><%= q.getQst() %></td>
                        <td style="font-size:12px;color:var(--text-muted);"><%= q.getR1() %></td>
                        <td style="font-size:12px;color:var(--text-muted);"><%= q.getR2() %></td>
                        <td style="font-size:12px;color:var(--text-muted);"><%= q.getR3() %></td>
                        <td style="font-size:12px;color:var(--text-muted);"><%= q.getR4() %></td>
                        <td><span class="answer-badge-inline"><%= q.getBr() %></span></td>
                        <td style="font-size:12px;"><%= q.getTheme() %></td>
                        <td><span class="badge badge-<%= q.getNiveau() %>"><%= q.getNiveau() %></span></td>
                        <td>
                            <div class="action-btns">
                                <a class="action-btn edit" href="UpdateQcmServlet?num_question=<%= q.getNum() %>" title="Modifier">✏️</a>
                                <a class="action-btn delete" href="DeleteQcmServlet?num_question=<%= q.getNum() %>"
                                   onclick="return confirm('Supprimer cette question ?')" title="Supprimer">🗑</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else { %>
                    <tr>
                        <td colspan="10">
                            <div class="empty-state">
                                <div class="icon">📝</div>
                                <p>Aucune question trouvée.</p>
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
