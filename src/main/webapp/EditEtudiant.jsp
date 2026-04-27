<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.Etudiant" %>

<%
Etudiant e = (Etudiant) request.getAttribute("etudiant");

if (e == null) {
%>
    <h3 style="color:red;">Erreur : étudiant introuvable</h3>
<%
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modifier</title>
</head>
<body>

<form action="UpdateEtudiantServlet" method="post">

<input type="hidden" name="num_etudiant" value="<%= e.getNum() %>">

Nom :
<input type="text" name="nom" value="<%= e.getNom() %>"><br>

Prenom :
<input type="text" name="prenom" value="<%= e.getPrenom() %>"><br>

Niveau :
<input type="text" name="niveau" value="<%= e.getNiveau() %>"><br>

Email :
<input type="text" name="email" value="<%= e.getEmail() %>"><br>

<input type="submit" value="Modifier">

</form>

</body>
</html>