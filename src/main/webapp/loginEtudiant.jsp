<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Étudiant</title>

<link rel="stylesheet" href="assets/css/login.css">

</head>

<body>

<div class="login-container">

    <h1>🎓 Connexion Étudiant</h1>

    <form action="loginEtudiantServlet" method="post">

        Numéro étudiant :
        <input type="text" name="num_etudiant">

        Email :
        <input type="email" name="email">

        <input type="submit" value="Connexion">

    </form>

</div>

</body>
</html>