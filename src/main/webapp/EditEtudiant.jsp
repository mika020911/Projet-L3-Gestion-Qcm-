<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Etudiant" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
Etudiant e = (Etudiant) request.getAttribute("etudiant");
if (e == null) { response.sendRedirect("ListeEtudiantServlet"); return; }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier — <%= e.getNom() %> <%= e.getPrenom() %></title>
    <link rel="stylesheet" href="assets/css/Ajouter.css">
</head>
<body>

<div class="form-page">

    <div class="form-page-header">
        <a href="ListeEtudiantServlet" class="back-btn">←</a>
        <div>
            <h1>Modifier l'étudiant</h1>
            <p><%= e.getNom() %> <%= e.getPrenom() %> — <code style="font-family:var(--font-mono);color:var(--text-muted);"><%= e.getNum() %></code></p>
        </div>
    </div>

    <div class="form-card">
        <form action="UpdateEtudiantServlet" method="post">
            <input type="hidden" name="num_etudiant" value="<%= e.getNum() %>">

            <div class="form-grid">
                <div class="form-group">
                    <label>Nom</label>
                    <input type="text" name="nom" value="<%= e.getNom() %>" required>
                </div>
                <div class="form-group">
                    <label>Prénom</label>
                    <input type="text" name="prenom" value="<%= e.getPrenom() %>" required>
                </div>
                <div class="form-group">
                    <label>Niveau</label>
                    <select name="niveau" required>
                        <option value="L1" <%= "L1".equals(e.getNiveau()) ? "selected" : "" %>>L1 — Licence 1</option>
                        <option value="L2" <%= "L2".equals(e.getNiveau()) ? "selected" : "" %>>L2 — Licence 2</option>
                        <option value="L3" <%= "L3".equals(e.getNiveau()) ? "selected" : "" %>>L3 — Licence 3</option>
                        <option value="M1" <%= "M1".equals(e.getNiveau()) ? "selected" : "" %>>M1 — Master 1</option>
                        <option value="M2" <%= "M2".equals(e.getNiveau()) ? "selected" : "" %>>M2 — Master 2</option>
                    </select>
                </div>
                <div class="form-group full-width">
                    <label>Adresse email</label>
                    <input type="email" name="email" value="<%= e.getEmail() %>" required>
                </div>
            </div>

            <div class="form-actions">
                <a href="ListeEtudiantServlet" class="btn-cancel">Annuler</a>
                <button type="submit" class="btn-submit">💾 Enregistrer</button>
            </div>
        </form>
    </div>
</div>

<script src="assets/js/main.js"></script>
</body>
</html>
