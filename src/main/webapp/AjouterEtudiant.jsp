<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href= "assets/css/Ajouter.css">
<title>Gestion Etudiant</title>
</head>
<body>
<%
String msg = (String) session.getAttribute("msg");

if (msg != null) {
    session.removeAttribute("msg");
%>

<div class="toast <%= msg %>">
    <%= msg.equals("success") ? " Étudiant ajouté !" : "Erreur lors de l'ajout !" %>
</div>

<%
}
%>

<form action="AddEtudiantServlet" method="post">

<h1>Ajouter Etudiant</h1>

<label>Num Etudiant</label>
<input type="text" name="num">

<label>Nom</label>
<input type="text" name="nom">

<label>Prénom</label>
<input type="text" name="prenom">

<label>Niveau</label>
<select name="niveau">
    <option>L1</option>
    <option>L2</option>
    <option>L3</option>
    <option>M1</option>
    <option>M2</option>
</select>

<label>Email</label>
<input type="text" name="email">

<button type="submit">Ajouter</button>

</form>
<a href="ListeEtudiantServlet" class="floating-btn">
    📋
</a>
</body>
</html>