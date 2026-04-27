<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Etudiant" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liste des etudiants</title>
</head>
<body>

<form action="ListeEtudiantServlet" method = get>
Recherche:
<input type="text" name="motCle">
<input type="submit" name="chercher">
</form>

<h2>Liste des étudiants</h2>

<table border="1">
    <tr>
        <th>Num</th>
        <th>Nom</th>
        <th>Prenom</th>
        <th>Niveau</th>
        <th>Email</th>
    </tr>

<%
	ArrayList<Etudiant> list = (ArrayList<Etudiant>) request.getAttribute("liste");

if (list != null){
    for (Etudiant e : list) {
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

<% }
} else{
%>

<p>Aucun étudiant trouvé</p>

<%
}
%>

</table>

</body>
</html>