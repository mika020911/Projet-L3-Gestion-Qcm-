<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Etudiant" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
Etudiant e = (Etudiant) request.getAttribute("etudiant");
if (e == null) { response.sendRedirect("ListeEtudiantServlet"); return; }

String editMsg       = (String) session.getAttribute("editMsg");
String editMsgDetail = (String) session.getAttribute("editMsgDetail");
if (editMsg != null)       session.removeAttribute("editMsg");
if (editMsgDetail != null) session.removeAttribute("editMsgDetail");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier — <%= e.getNom() %> <%= e.getPrenom() %></title>
    <link rel="stylesheet" href="assets/css/Ajouter.css">
    <style>
        .field-hint {
            font-size: 11px;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: color 0.2s;
        }
        .field-hint.valid   { color: #22c55e; }
        .field-hint.invalid { color: #ef4444; }
        .field-hint.neutral { color: var(--text-dim); }

        input.valid   { border-color: #22c55e !important; }
        input.invalid { border-color: #ef4444 !important; }

        .field-examples {
            font-size: 11px;
            color: var(--text-dim);
            margin-top: 4px;
        }
        .field-examples span {
            display: inline-block;
            background: var(--bg-input);
            border: 1px solid var(--border);
            border-radius: 4px;
            padding: 1px 6px;
            font-family: var(--font-mono);
            margin-right: 4px;
        }
    </style>
</head>
<body>

<%-- Toast message --%>
<% if (editMsg != null) { %>
<div class="toast <%= editMsg %>">
    <%= editMsgDetail != null ? editMsgDetail : (editMsg.equals("success") ? "✅ Modifié !" : "❌ Erreur.") %>
</div>
<% } %>

<div class="form-page">

    <div class="form-page-header">
        <a href="ListeEtudiantServlet" class="back-btn">←</a>
        <div>
            <h1>Modifier l'étudiant</h1>
            <p><%= e.getNom() %> <%= e.getPrenom() %> —
               <code style="font-family:var(--font-mono);color:var(--text-muted);"><%= e.getNum() %></code>
            </p>
        </div>
    </div>

    <div class="form-card">
        <form action="UpdateEtudiantServlet" method="post" id="editForm" novalidate>

            <%-- Champ caché : numéro non modifiable (clé primaire) --%>
            <input type="hidden" name="num_etudiant" value="<%= e.getNum() %>">

            <div class="form-grid">

                <%-- Nom --%>
                <div class="form-group">
                    <label>Nom</label>
                    <input type="text" name="nom" value="<%= e.getNom() %>" required>
                </div>

                <%-- Prénom --%>
                <div class="form-group">
                    <label>Prénom</label>
                    <input type="text" name="prenom" value="<%= e.getPrenom() %>" required>
                </div>

                <%-- Niveau --%>
                <div class="form-group">
                    <label>Niveau</label>
                    <select name="niveau" required>
                        <option value="L1" <%= "L1".equals(e.getNiveau()) ? "selected" : "" %>>L1 — Licence 1</option>
                        <option value="L2" <%= "L2".equals(e.getNiveau()) ? "selected" : "" %>>L2 — Licence 2</option>
                        <option value="L3" <%= "L3".equals(e.getNiveau()) ? "selected" : "" %>>L3 — Licence 3</option>
                        <option value="M1" <%= "M1".equals(e.getNiveau()) ? "selected" : "" %>>M1 — Master 1</option>
                        <option value="M2" <%= "M2".equals(e.getNiveau()) ? "selected" : "" %>>M2 — Master 2</option>
                    </select>
                </div>

                <%-- Email --%>
                <div class="form-group full-width">
                    <label>Adresse email</label>
                    <input type="text" id="email" name="email"
                           value="<%= e.getEmail() %>"
                           required autocomplete="off">
                    <div class="field-examples">
                        Ex : <span>jean@gmail.com</span><span>etu@univ.mg</span>
                    </div>
                    <div class="field-hint neutral" id="hint-email">
                        Format : nom@domaine.extension
                    </div>
                </div>

            </div>

            <div class="form-actions">
                <a href="ListeEtudiantServlet" class="btn-cancel">Annuler</a>
                <button type="submit" class="btn-submit">💾 Enregistrer</button>
            </div>

        </form>
    </div>
</div>

<script src="assets/js/main.js"></script>
<script>
const PATTERN_EMAIL = /^[A-Za-z0-9+_.\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/;

const emailInput = document.getElementById('email');
const hintEmail  = document.getElementById('hint-email');

// Initialiser l'indicateur sur la valeur existante
function validateEmail(val) {
    if (val === '') {
        emailInput.classList.remove('valid', 'invalid');
        hintEmail.className = 'field-hint neutral';
        hintEmail.textContent = 'Format : nom@domaine.extension';
        return;
    }
    if (PATTERN_EMAIL.test(val)) {
        emailInput.classList.add('valid'); emailInput.classList.remove('invalid');
        hintEmail.className = 'field-hint valid';
        hintEmail.textContent = '✓ Email valide';
    } else {
        emailInput.classList.add('invalid'); emailInput.classList.remove('valid');
        hintEmail.className = 'field-hint invalid';
        if (!val.includes('@')) {
            hintEmail.textContent = '✗ Manque le @ (ex: nom@domaine.com)';
        } else if (val.endsWith('@')) {
            hintEmail.textContent = '✗ Ajoutez le domaine après @';
        } else if (!val.includes('.', val.indexOf('@'))) {
            hintEmail.textContent = '✗ Manque l\'extension (ex: .com, .mg)';
        } else {
            hintEmail.textContent = '✗ Format invalide — ex: nom@domaine.com';
        }
    }
}

// Valider dès le chargement (champ pré-rempli)
validateEmail(emailInput.value.trim());

emailInput.addEventListener('input', function () {
    validateEmail(this.value.trim());
});

// Bloquer soumission si email invalide
document.getElementById('editForm').addEventListener('submit', function (e) {
    const email = emailInput.value.trim();
    if (!PATTERN_EMAIL.test(email)) {
        emailInput.classList.add('invalid');
        hintEmail.className = 'field-hint invalid';
        hintEmail.textContent = '✗ Email invalide : format attendu exemple@mail.com';
        e.preventDefault();
        emailInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
});
</script>
</body>
</html>
