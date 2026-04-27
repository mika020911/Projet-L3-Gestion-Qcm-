<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.ArrayList" %>
<%@ page import="model.Qcm" %>

<%
ArrayList<Qcm> list = (ArrayList<Qcm>) request.getAttribute("liste");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liste QCM</title>

<link rel="stylesheet" href="assets/css/qcm.css">


</head>

<body>

<h1 style="text-align:center;">📋 Liste des QCM</h1>

<div style="text-align:center; margin-bottom:20px;">
    <a class="btn add" href="AjouterQcm.jsp">➕ Ajouter QCM</a>
</div>

<table>

<tr>
    <th>Numero</th>
    <th>Question</th>
    <th>Réponse 1</th>
    <th>Réponse 2</th>
    <th>Réponse 3</th>
    <th>Réponse 4</th>
    <th>Bonne réponse</th>
    <th>Actions</th>
</tr>

<%
if (list != null) {
    for (Qcm q : list) {
%>

<tr>
    <td><%= q.getNum() %></td>
    <td><%= q.getQst() %></td>
    <td><%= q.getR1() %></td>
    <td><%= q.getR2() %></td>
    <td><%= q.getR3() %></td>
    <td><%= q.getR4() %></td>
    <td><%= q.getBr() %></td>

    <td>
        <a class="btn edit" href="EditQcmServlet?num_question=<%= q.getNum() %>">✏️</a>
        <a class="btn delete" href="DeleteQcmServlet?num_question=<%= q.getNum() %>">🗑</a>
    </td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="8">Aucun QCM trouvé</td>
</tr>

<%
}
%>

</table>
</body>
</html>