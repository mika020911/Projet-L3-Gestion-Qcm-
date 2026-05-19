<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
String msg = (String) session.getAttribute("msg");
if (msg != null) session.removeAttribute("msg");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une question QCM</title>
    <link rel="stylesheet" href="assets/css/qcm.css">
</head>
<body>

<% if (msg != null) { %>
<div class="toast <%= msg %>">
    <%= msg.equals("success") ? "✅ Question ajoutée !" : "❌ Erreur lors de l'ajout." %>
</div>
<% } %>

<div class="qcm-form-page">

    <div class="qcm-form-header">
        <a href="ListeQcmServlet" class="btn btn-ghost" style="padding:8px 14px;">← Retour</a>
        <div>
            <h1>Ajouter une question</h1>
            <p>Nouvelle question QCM avec niveau et thème</p>
        </div>
    </div>

    <div class="qcm-form-card">
        <form action="AddQcmServlet" method="post">

            <!-- Question -->
            <div class="form-section">
                <div class="form-section-title">Question</div>
                <div class="form-group">
                    <label>Numéro</label>
                    <input type="number" name="num_question" placeholder="1" required>
                </div>
                <div class="form-group">
                    <label>Énoncé de la question</label>
                    <input type="text" name="question" placeholder="Quelle est la formule de l'eau ?" required>
                </div>
            </div>

            <!-- Réponses -->
            <div class="form-section">
                <div class="form-section-title">Réponses</div>
                <div class="answers-grid">
                    <div class="answer-item form-group">
                        <label><span class="answer-badge a">A</span> Réponse 1</label>
                        <input type="text" name="reponse1" placeholder="Réponse A" required>
                    </div>
                    <div class="answer-item form-group">
                        <label><span class="answer-badge b">B</span> Réponse 2</label>
                        <input type="text" name="reponse2" placeholder="Réponse B" required>
                    </div>
                    <div class="answer-item form-group">
                        <label><span class="answer-badge c">C</span> Réponse 3</label>
                        <input type="text" name="reponse3" placeholder="Réponse C" required>
                    </div>
                    <div class="answer-item form-group">
                        <label><span class="answer-badge d">D</span> Réponse 4</label>
                        <input type="text" name="reponse4" placeholder="Réponse D" required>
                    </div>
                </div>
                <div class="form-group" style="margin-top:16px;">
                    <label>Bonne réponse</label>
                    <select name="bonne_reponse" required>
                        <option value="">-- Sélectionner --</option>
                        <option value="1">A — Réponse 1</option>
                        <option value="2">B — Réponse 2</option>
                        <option value="3">C — Réponse 3</option>
                        <option value="4">D — Réponse 4</option>
                    </select>
                </div>
            </div>

            <!-- Catégorisation -->
            <div class="form-section">
                <div class="form-section-title">Catégorisation</div>
                <div class="meta-grid">
                    <div class="form-group">
                        <label>Thème</label>
                        <select name="theme" required>
                            <option value="">-- Choisir --</option>
                            <option value="Mathematiques">📐 Mathématiques</option>
                            <option value="Physique">⚗️ Physique</option>
                            <option value="Chimie">🧪 Chimie</option>
                            <option value="Informatique">💻 Informatique</option>
                            <option value="Histoire">📜 Histoire</option>
                            <option value="Geographie">🌍 Géographie</option>
                            <option value="Biologie">🧬 Biologie</option>
                            <option value="Economie">📈 Économie</option>
                            <option value="Droit">⚖️ Droit</option>
                            <option value="Philosophie">🧠 Philosophie</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Niveau</label>
                        <select name="niveau" required>
                            <option value="">-- Choisir --</option>
                            <option value="L1">L1 — Licence 1</option>
                            <option value="L2">L2 — Licence 2</option>
                            <option value="L3">L3 — Licence 3</option>
                            <option value="M1">M1 — Master 1</option>
                            <option value="M2">M2 — Master 2</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="ListeQcmServlet" class="btn-cancel">Annuler</a>
                <button type="submit" class="btn-submit">➕ Ajouter la question</button>
            </div>

        </form>
    </div>
</div>

<script src="assets/js/main.js"></script>
</body>
</html>
