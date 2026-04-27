<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajouter QCM</title>

<link rel="stylesheet" href="assets/css/qcm.css">


</head>

<body>

<h1 style="text-align:center;">➕ Ajouter une question QCM</h1>

<div class="form-container">

<form action="AddQcmServlet" method="post">

    Numéro question :
    <input type="number" name="num_question" required>

    Question :
    <input type="text" name="question" required>

    Réponse 1 :
    <input type="text" name="reponse1" required>

    Réponse 2 :
    <input type="text" name="reponse2" required>

    Réponse 3 :
    <input type="text" name="reponse3" required>

    Réponse 4 :
    <input type="text" name="reponse4" required>

    Bonne réponse :
    <select name="bonne_reponse" required>
        <option value="">-- Choisir --</option>
        <option value="1">Réponse 1</option>
        <option value="2">Réponse 2</option>
        <option value="3">Réponse 3</option>
        <option value="4">Réponse 4</option>
    </select>

    <button type="submit">Ajouter</button>

</form>

</div>

<br>

<div style="text-align:center;">
    <a href="ListeQcmServlet">📋 Voir les QCM</a>
</div>

</body>
</html>