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
<title>Examen</title>
</head>

<body>

<h1>📝 Examen</h1>

<!-- TIMER -->
<h2>⏱ Temps restant : <span id="timer">02:00</span></h2>

<form action="CorrectionServlet" method="post">

<%
for(Qcm q : list){
%>

<p><b><%= q.getQst() %></b></p>

<input type="radio" name="q_<%= q.getNum() %>" value="1"> <%= q.getR1() %><br>
<input type="radio" name="q_<%= q.getNum() %>" value="2"> <%= q.getR2() %><br>
<input type="radio" name="q_<%= q.getNum() %>" value="3"> <%= q.getR3() %><br>
<input type="radio" name="q_<%= q.getNum() %>" value="4"> <%= q.getR4() %><br>

<hr>

<% } %>

<input type="submit" value="Valider">

</form>

<!-- TIMER SCRIPT -->
<script>
let temps = 120; // 2 minutes

const timerElement = document.getElementById("timer");

function updateTimer() {

    let minutes = Math.floor(temps / 60);
    let secondes = temps % 60;

    timerElement.textContent =
        String(minutes).padStart(2, '0') + ":" +
        String(secondes).padStart(2, '0');

    if (temps <= 0) {
        clearInterval(interval);
        alert("⏰ Temps écoulé !");
        document.querySelector("form").submit();
    }

    temps--;

    if (temps <= 10) {
        timerElement.style.color = "red";
    }
}

let interval = setInterval(updateTimer, 1000);
updateTimer();
</script>

</body>
</html>