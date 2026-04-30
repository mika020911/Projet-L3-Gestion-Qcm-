<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modifier  QCM</title>
<link rel="stylesheet" href="assets/css/qcm.css">

</head>
<body>

<%@ page import="model.Qcm" %>

<%
Qcm q = (Qcm) request.getAttribute("qcm");

if (q == null) {
%>
    <h3 style="color:red;">Erreur : QCM introuvable</h3>
<%
    return;
}
%>

<h1 style="text-align:center;">Modifier une Question</h1>

<div class="form-container">

<form action="UpdateQcmServlet" method="post">

    Numéro question :
    <input type="number" name="num_question" value = "<%= q.getNum() %>" required>

    Question :
    <input type="text" name="question" value= "<%= q.getQst() %>" required>

    Réponse 1 :
    <input type="text" name="reponse1" value="<%= q.getR1() %>" required>

    Réponse 2 :
    <input type="text" name="reponse2" value="<%= q.getR2() %>" required>

    Réponse 3 :
    <input type="text" name="reponse3" value="<%= q.getR3() %>" required>

    Réponse 4 :
    <input type="text" name="reponse4" value="<%= q.getR4() %>" required>

    Bonne réponse :
    <select name="bonne_reponse" required>
        <option value="">-- Choisir --</option>
        <option value="1" <%= q.getBr() == 1 ? "selected" : "" %>>Réponse 1</option>
        <option value="2" <%= q.getBr() == 2 ? "selected" : "" %>>Réponse 2</option>
        <option value="3" <%= q.getBr() == 3 ? "selected" : "" %>>Réponse 3</option>
        <option value="4"<%= q.getBr() == 4 ? "selected" : "" %>>Réponse 4</option>
    </select>

    <input type= "text" value = "Modifier">

</form>

</div>

<br>

<div style="text-align:center;">
    <a href="ListeQcmServlet">📋 Voir les QCM</a>
</div>
</body>
</html>