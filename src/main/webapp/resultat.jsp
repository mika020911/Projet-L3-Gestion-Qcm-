<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Résultat</title>
</head>

<body>

<h1>📊 Résultat de l'examen</h1>

<p>Score : <b><%= request.getAttribute("score") %> / <%= request.getAttribute("total") %></b></p>

<p>Note : <b><%= request.getAttribute("note") %> / 20</b></p>

<br>

<a href="ExamenServlet">🔁 Repasser l'examen</a>
<br>
<a href="ListeEtudiantServlet">🏠 Retour</a>

</body>
</html>