<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard Admin</title>
<link rel="stylesheet" type="text/css" href="assets\css\style.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="assets/js/dashboard.js"></script>


</head>

<body>
<!-- Bouton menu -->
<div class="menu-btn" onclick="toggleMenu()">☰</div>

<!-- Sidebar -->
<div id="sidebar" class="sidebar">
    <h2>Admin Panel</h2>

    <a href="DashboardServlet">📊 Dashboard</a>
    <a href="ListeEtudiantServlet">👨‍🎓 Étudiants</a>
    <a href= "ListeQcmServlet">Gestion QCM</a>
    
</div>

<h1>📊 Dashboard Admin</h1>

<div class="card"><h2>Total</h2><h3><%= request.getAttribute("total") %></h3></div>
<div class="card"><h2>L1</h2><h3><%= request.getAttribute("l1") %></h3></div>
<div class="card"><h2>L2</h2><h3><%= request.getAttribute("l2") %></h3></div>
<div class="card"><h2>L3</h2><h3><%= request.getAttribute("l3") %></h3></div>
<div class="card"><h2>M1</h2><h3><%= request.getAttribute("m1") %></h3></div>
<div class="card"><h2>M2</h2><h3><%= request.getAttribute("m2") %></h3></div>

<br><br>

<div style="width: 450px; height: 300px;">
    <canvas id="niveauChart"></canvas>
</div>

<script>
const ctx = document.getElementById('niveauChart');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['L1', 'L2', 'L3', 'M1', 'M2'],
        datasets: [{
            label: 'Étudiants',
            data: [
                <%= request.getAttribute("l1") %>,
                <%= request.getAttribute("l2") %>,
                <%= request.getAttribute("l3") %>,
                <%= request.getAttribute("m1") %>,
                <%= request.getAttribute("m2") %>
            ],
            backgroundColor: ['blue', 'green', 'orange', 'purple', 'red']
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
</script>

<br>

<a href="ListeEtudiantServlet">Voir la liste des étudiants</a>

</body>
</html>