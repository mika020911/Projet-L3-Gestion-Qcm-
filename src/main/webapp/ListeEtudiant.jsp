<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Etudiant" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
ArrayList<Etudiant> list = (ArrayList<Etudiant>) request.getAttribute("liste");
int count = (list != null) ? list.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des étudiants</title>
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
            <a href="ListeEtudiantServlet" class="active"><span class="icon">👨‍🎓</span> Étudiants</a>
            <a href="AjouterEtudiant.jsp"><span class="icon">➕</span> Ajouter étudiant</a>
            <a href="ListeQcmServlet"><span class="icon">📝</span> Gestion QCM</a>
            <a href="AjouterQcm.jsp"><span class="icon">➕</span> Ajouter QCM</a>
        </nav>
        <div class="sidebar-footer">
            <a href="LogoutServlet">🚪 Déconnexion</a>
        </div>
    </aside>

    <main class="main-content">
        <div class="page-header fade-up">
            <div>
                <h1>Étudiants</h1>
                <p>Gérez la liste des étudiants inscrits</p>
            </div>
            <a href="AjouterEtudiant.jsp" class="btn btn-primary">➕ Ajouter</a>
        </div>

        <div class="list-page">

            <div class="toolbar fade-up">
                <form class="search-box" action="ListeEtudiantServlet" method="get">
                    <input type="text" name="motCle" placeholder="Rechercher par nom, prénom, numéro...">
                    <button type="submit">Chercher</button>
                </form>
                <span class="result-count"><%= count %> étudiant(s)</span>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Numéro</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Niveau</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    if (list != null && !list.isEmpty()) {
                        for (Etudiant e : list) {
                    %>
                    <tr>
                        <td><code style="font-family:var(--font-mono);color:var(--text-muted);font-size:13px;"><%= e.getNum() %></code></td>
                        <td style="font-weight:600;"><%= e.getNom() %></td>
                        <td><%= e.getPrenom() %></td>
                        <td><span class="badge badge-<%= e.getNiveau() %>"><%= e.getNiveau() %></span></td>
                        <td style="color:var(--text-muted);font-size:13px;"><%= e.getEmail() %></td>
                        <td>
                            <div class="action-btns">
                                <a class="action-btn edit" href="UpdateEtudiantServlet?num_etudiant=<%= e.getNum() %>" title="Modifier">✏️</a>
                                <a class="action-btn delete" href="DeleteEtudiantServlet?num_etudiant=<%= e.getNum() %>"
                                   onclick="return confirm('Supprimer cet étudiant ?')" title="Supprimer">🗑</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else { %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <div class="icon">👨‍🎓</div>
                                <p>Aucun étudiant trouvé.</p>
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
