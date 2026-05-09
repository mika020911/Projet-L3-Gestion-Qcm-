<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Etudiant" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liste des étudiants</title>

<link rel="stylesheet" href="assets/css/listE.css">

</head>

<body>

<div class="container">

<h2>📋 Liste des étudiants</h2>

<form action="ListeEtudiantServlet" method="get">
    <input type="text" name="motCle" placeholder="Rechercher...">
    <input type="submit" value="Chercher">
</form>

<table>

<tr>
    <th>Num</th>
    <th>Nom</th>
    <th>Prénom</th>
    <th>Niveau</th>
    <th>Email</th>
    <th>Actions</th>
</tr>

<%
ArrayList<Etudiant> list =
(ArrayList<Etudiant>) request.getAttribute("liste");

if(list != null){
    for(Etudiant e : list){
%>

<tr>
    <td><%= e.getNum() %></td>
    <td><%= e.getNom() %></td>
    <td><%= e.getPrenom() %></td>
    <td><%= e.getNiveau() %></td>
    <td><%= e.getEmail() %></td>
    <td>
        <a href="DeleteEtudiantServlet?num_etudiant=<%= e.getNum() %>">Supprimer</a>
        <a href="UpdateEtudiantServlet?num_etudiant=<%= e.getNum() %>">Modifier</a>
    </td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="6" class="empty">Aucun étudiant trouvé</td>
</tr>

<%
}
%>

</table>

</div>

</body>
</html>