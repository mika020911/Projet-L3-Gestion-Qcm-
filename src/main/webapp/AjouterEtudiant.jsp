<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
String msg = (String) session.getAttribute("msg");
if (msg != null) session.removeAttribute("msg");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un étudiant</title>
    <link rel="stylesheet" href="assets/css/Ajouter.css">
</head>
<body>

<% if (msg != null) { %>
<div class="toast <%= msg %>">
    <%= msg.equals("success") ? "✅ Étudiant ajouté avec succès !" : "❌ Erreur lors de l'ajout." %>
</div>
<% } %>

<div class="form-page">

    <div class="form-page-header">
        <a href="ListeEtudiantServlet" class="back-btn">←</a>
        <div>
            <h1>Ajouter un étudiant</h1>
            <p>Remplissez les informations ci-dessous</p>
        </div>
    </div>

    <div class="form-card">
        <form action="AddEtudiantServlet" method="post">

            <div class="form-grid">
                <div class="form-group">
                    <label>Numéro étudiant</label>
                    <input type="text" name="num" placeholder="ETU001" required>
                </div>
                <div class="form-group">
                    <label>Niveau</label>
                    <select name="niveau" required>
                        <option value="">-- Choisir --</option>
                        <option value="L1">L1 — Licence 1</option>
                        <option value="L2">L2 — Licence 2</option>
                        <option value="L3">L3 — Licence 3</option>
                        <option value="M1">M1 — Master 1</option>
                        <option value="M2">M2 — Master 2</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Nom</label>
                    <input type="text" name="nom" placeholder="RAKOTO" required>
                </div>
                <div class="form-group">
                    <label>Prénom</label>
                    <input type="text" name="prenom" placeholder="Jean" required>
                </div>
                <div class="form-group full-width">
                    <label>Adresse email</label>
                    <input type="email" name="email" placeholder="jean.rakoto@email.com" required>
                </div>
            </div>

            <div class="form-actions">
                <a href="ListeEtudiantServlet" class="btn-cancel">Annuler</a>
                <button type="submit" class="btn-submit"> Ajouter l'étudiant</button>
            </div>

        </form>
    </div>
</div>

<script src="assets/js/main.js"></script>
</body>
</html>
