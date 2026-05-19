<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin — Connexion</title>
    <link rel="stylesheet" href="assets/css/login.css">
</head>
<body>

<div class="login-card">

    <div class="login-logo">
        <div class="icon-wrap">🎓</div>
        <h1>Espace Admin</h1>
        <p>Connectez-vous pour accéder au tableau de bord</p>
    </div>

    <%
    String loginError = (String) session.getAttribute("loginError");
    if (loginError != null) {
        session.removeAttribute("loginError");
    %>
    <div class="login-error">⚠️ <%= loginError %></div>
    <% } %>

    <form class="login-form" action="LoginAdminServlet" method="post">
        <div class="form-group">
            <label>Code Admin</label>
            <input type="text" name="code_admin" placeholder="Admin01" required autofocus>
        </div>
        <div class="form-group">
            <label>Mot de passe</label>
            <input type="password" name="mdp" placeholder="••••••••" required>
        </div>
        <button type="submit">Se connecter</button>
    </form>

    <div class="login-footer">
        Vous êtes étudiant ? <a href="loginEtudiant.jsp">Accéder à l'examen →</a>
    </div>

</div>

<script src="assets/js/main.js"></script>
</body>
</html>
