<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Qcm" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
Qcm q = (Qcm) request.getAttribute("qcm");
if (q == null) { response.sendRedirect("ListeQcmServlet"); return; }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier question #<%= q.getNum() %></title>
    <link rel="stylesheet" href="assets/css/qcm.css">
</head>
<body>

<div class="qcm-form-page">

    <div class="qcm-form-header">
        <a href="ListeQcmServlet" class="btn btn-ghost" style="padding:8px 14px;">← Retour</a>
        <div>
            <h1>Modifier la question</h1>
            <p>Question #<%= q.getNum() %> — <%= q.getNiveau() %> / <%= q.getTheme() %></p>
        </div>
    </div>

    <div class="qcm-form-card">
        <form action="UpdateQcmServlet" method="post">
            <input type="hidden" name="num_question" value="<%= q.getNum() %>">

            <div class="form-section">
                <div class="form-section-title">Question</div>
                <div class="form-group">
                    <label>Énoncé</label>
                    <input type="text" name="question" value="<%= q.getQst() %>" required>
                </div>
            </div>

            <div class="form-section">
                <div class="form-section-title">Réponses</div>
                <div class="answers-grid">
                    <div class="answer-item form-group">
                        <label><span class="answer-badge a">A</span> Réponse 1</label>
                        <input type="text" name="reponse1" value="<%= q.getR1() %>" required>
                    </div>
                    <div class="answer-item form-group">
                        <label><span class="answer-badge b">B</span> Réponse 2</label>
                        <input type="text" name="reponse2" value="<%= q.getR2() %>" required>
                    </div>
                    <div class="answer-item form-group">
                        <label><span class="answer-badge c">C</span> Réponse 3</label>
                        <input type="text" name="reponse3" value="<%= q.getR3() %>" required>
                    </div>
                    <div class="answer-item form-group">
                        <label><span class="answer-badge d">D</span> Réponse 4</label>
                        <input type="text" name="reponse4" value="<%= q.getR4() %>" required>
                    </div>
                </div>
                <div class="form-group" style="margin-top:16px;">
                    <label>Bonne réponse</label>
                    <select name="bonne_reponse" required>
                        <option value="1" <%= q.getBr()==1?"selected":"" %>>A — Réponse 1</option>
                        <option value="2" <%= q.getBr()==2?"selected":"" %>>B — Réponse 2</option>
                        <option value="3" <%= q.getBr()==3?"selected":"" %>>C — Réponse 3</option>
                        <option value="4" <%= q.getBr()==4?"selected":"" %>>D — Réponse 4</option>
                    </select>
                </div>
            </div>

            <div class="form-section">
                <div class="form-section-title">Catégorisation</div>
                <div class="meta-grid">
                    <div class="form-group">
                        <label>Thème</label>
                        <select name="theme" required>
                            <option value="Mathematiques"  <%= "Mathematiques".equals(q.getTheme())  ?"selected":"" %>>📐 Mathématiques</option>
                            <option value="Physique"        <%= "Physique".equals(q.getTheme())        ?"selected":"" %>>⚗️ Physique</option>
                            <option value="Chimie"          <%= "Chimie".equals(q.getTheme())          ?"selected":"" %>>🧪 Chimie</option>
                            <option value="Informatique"    <%= "Informatique".equals(q.getTheme())    ?"selected":"" %>>💻 Informatique</option>
                            <option value="Histoire"        <%= "Histoire".equals(q.getTheme())        ?"selected":"" %>>📜 Histoire</option>
                            <option value="Geographie"      <%= "Geographie".equals(q.getTheme())      ?"selected":"" %>>🌍 Géographie</option>
                            <option value="Biologie"        <%= "Biologie".equals(q.getTheme())        ?"selected":"" %>>🧬 Biologie</option>
                            <option value="Economie"        <%= "Economie".equals(q.getTheme())        ?"selected":"" %>>📈 Économie</option>
                            <option value="Droit"           <%= "Droit".equals(q.getTheme())           ?"selected":"" %>>⚖️ Droit</option>
                            <option value="Philosophie"     <%= "Philosophie".equals(q.getTheme())     ?"selected":"" %>>🧠 Philosophie</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Niveau</label>
                        <select name="niveau" required>
                            <option value="L1" <%= "L1".equals(q.getNiveau())?"selected":"" %>>L1 — Licence 1</option>
                            <option value="L2" <%= "L2".equals(q.getNiveau())?"selected":"" %>>L2 — Licence 2</option>
                            <option value="L3" <%= "L3".equals(q.getNiveau())?"selected":"" %>>L3 — Licence 3</option>
                            <option value="M1" <%= "M1".equals(q.getNiveau())?"selected":"" %>>M1 — Master 1</option>
                            <option value="M2" <%= "M2".equals(q.getNiveau())?"selected":"" %>>M2 — Master 2</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="ListeQcmServlet" class="btn-cancel">Annuler</a>
                <button type="submit" class="btn-submit"> Enregistrer</button>
            </div>
        </form>
    </div>
</div>

<script src="assets/js/main.js"></script>
</body>
</html>
