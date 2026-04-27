<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Etudiant</title>
</head>
<body>
<form action="AddEtudiantServlet" method = "post">
NumEtud : <input type="text" name= "num"> <br>
Nom  : <input type= "text" name="nom"><br>
Prenom : <input type= "text" name= "prenom"> <br>

Niveau : 	
<select name = "niveau">
	<option>L1</option>
	<option>L2</option>
	<option>L3</option>
	<option>M1</option>
	<option>M2</option>
</select> <br>

Email: <input type = "text" name="email">
<button type="submit">Ajouter</button>
</form>

</body>
</html>