<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Qcm" %>
<%
if (session.getAttribute("etudiant") == null) {
    response.sendRedirect("loginEtudiant.jsp"); return;
}
String erreur = (String) request.getAttribute("erreur");
String niveau = (String) request.getAttribute("niveau");
ArrayList<Qcm> list = (ArrayList<Qcm>) request.getAttribute("liste");
int total = (list != null) ? list.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Examen <%= niveau != null ? "— " + niveau : "" %></title>
    <link rel="stylesheet" href="assets/css/qcm.css">
</head>
<body>

<% if (erreur != null) { %>

<div class="exam-page">
    <div class="exam-error">
        <div class="icon">⚠️</div>
        <h2>Aucune question disponible</h2>
        <p><%= erreur %></p>
        <a href="loginEtudiant.jsp" class="btn btn-ghost">← Retour</a>
    </div>
</div>

<% } else { %>

<div class="exam-page">

    <!-- Header -->
    <div class="exam-header">
        <div>
            <h1>Examen</h1>
            <p style="color:var(--text-muted);font-size:13px;margin-top:4px;">
                Niveau <span class="badge badge-<%= niveau %>"><%= niveau %></span>
                &nbsp;·&nbsp; <%= total %> questions
            </p>
        </div>
        <div class="exam-meta">
            <div class="timer-wrap">
                ⏱ <span id="timer">20:00</span>
            </div>
        </div>
    </div>

    <!-- Barre de progression -->
    <div class="exam-progress">
        <span class="progress-label">0 / <%= total %> répondues</span>
        <div class="progress-bar">
            <div class="progress-fill" style="width:0%"></div>
        </div>
    </div>

    <!-- Formulaire -->
    <form action="CorrectionServlet" method="post" id="examForm">

    <%
    int i = 0;
    for (Qcm q : list) {
        i++;
    %>
    <div class="question-card fade-up" style="animation-delay:<%= (i * 0.04) %>s;">
        <div class="question-number">Question <%= i %> / <%= total %></div>
        <span class="question-theme"><%= q.getTheme() %></span>
        <div class="question-text"><%= q.getQst() %></div>

        <div class="options-list">
            <label class="option-item">
                <input type="radio" name="q_<%= q.getNum() %>" value="1" required>
                <span class="answer-badge a">A</span>
                <span class="option-label"><%= q.getR1() %></span>
            </label>
            <label class="option-item">
                <input type="radio" name="q_<%= q.getNum() %>" value="2">
                <span class="answer-badge b">B</span>
                <span class="option-label"><%= q.getR2() %></span>
            </label>
            <label class="option-item">
                <input type="radio" name="q_<%= q.getNum() %>" value="3">
                <span class="answer-badge c">C</span>
                <span class="option-label"><%= q.getR3() %></span>
            </label>
            <label class="option-item">
                <input type="radio" name="q_<%= q.getNum() %>" value="4">
                <span class="answer-badge d">D</span>
                <span class="option-label"><%= q.getR4() %></span>
            </label>
        </div>
    </div>
    <% } %>

    <div class="exam-submit">
        <button type="submit">✅ Soumettre l'examen</button>
        <p style="margin-top:12px;font-size:12px;color:var(--text-dim);">
            Vos résultats seront envoyés par email automatiquement.
        </p>
    </div>

    </form>
</div>

<% } %>

<script src="assets/js/main.js"></script>
<script src="assets/js/timer.js" data-seconds="1200"></script>
</body>
</html>
