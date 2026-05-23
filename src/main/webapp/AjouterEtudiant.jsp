<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("AdminPage.jsp"); return;
}
String msg       = (String) session.getAttribute("msg");
String msgDetail = (String) session.getAttribute("msgDetail");
if (msg != null)       session.removeAttribute("msg");
if (msgDetail != null) session.removeAttribute("msgDetail");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un étudiant</title>
    <link rel="stylesheet" href="assets/css/Ajouter.css">
    <style>
        /* ── Indicateurs de validation inline ── */
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

        /* Exemples sous le champ */
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

<%-- Toast avec message détaillé --%>
<% if (msg != null) { %>
<div class="toast <%= msg %>">
    <%= msgDetail != null ? msgDetail : (msg.equals("success") ? "✅ Ajout réussi !" : "❌ Erreur.") %>
</div>
<% } %>

<div class="form-page">

    <div class="form-page-header">
        <a href="ListeEtudiantServlet" class="back-btn">←</a>
        <div>
            <h1>Ajouter un étudiant</h1>
            <p>Remplissez les informations ci-dessous</p>
        </div>
    </div>

    <div class="form-card">
        <form action="AddEtudiantServlet" method="post" id="addForm" novalidate>

            <div class="form-grid">

                <%-- Numéro étudiant --%>
                <div class="form-group">
                    <label>Numéro étudiant</label>
                    <input type="text" id="num" name="num"
                           placeholder="0001 ou 002-H"
                           pattern="^(?=.*[0-9])[A-Za-z0-9\-_.]+$"
                           required autocomplete="off">
                    <div class="field-examples">
                        Ex : <span>0001</span><span>002-H</span><span>ETU2024</span>
                    </div>
                    <div class="field-hint neutral" id="hint-num">
                        Doit contenir au moins un chiffre
                    </div>
                </div>

                <%-- Niveau --%>
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

                <%-- Nom --%>
                <div class="form-group">
                    <label>Nom</label>
                    <input type="text" name="nom" placeholder="RAKOTO" required>
                </div>

                <%-- Prénom --%>
                <div class="form-group">
                    <label>Prénom</label>
                    <input type="text" name="prenom" placeholder="Jean" required>
                </div>

                <%-- Email --%>
                <div class="form-group full-width">
                    <label>Adresse email</label>
                    <input type="text" id="email" name="email"
                           placeholder="exemple@mail.com"
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
                <button type="submit" class="btn-submit" id="submitBtn">➕ Ajouter l'étudiant</button>
            </div>

        </form>
    </div>
</div>

<script src="assets/js/main.js"></script>
<script>
// ── Patterns de validation (mêmes que côté serveur) ──────────────
const PATTERN_NUM   = /^(?=.*[0-9])[A-Za-z0-9\-_.]+$/;
const PATTERN_EMAIL = /^[A-Za-z0-9+_.\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/;

// ── Validation du numéro en temps réel ───────────────────────────
const numInput  = document.getElementById('num');
const hintNum   = document.getElementById('hint-num');

numInput.addEventListener('input', function () {
    const val = this.value.trim();
    if (val === '') {
        this.classList.remove('valid', 'invalid');
        hintNum.className = 'field-hint neutral';
        hintNum.textContent = 'Doit contenir au moins un chiffre';
        return;
    }
    if (PATTERN_NUM.test(val)) {
        this.classList.add('valid'); this.classList.remove('invalid');
        hintNum.className = 'field-hint valid';
        hintNum.textContent = '✓ Format valide';
    } else {
        this.classList.add('invalid'); this.classList.remove('valid');
        // Message d'erreur précis
        if (/^[A-Za-z\-_.]+$/.test(val)) {
            hintNum.textContent = '✗ Que des lettres — ajoutez au moins un chiffre';
        } else {
            hintNum.textContent = '✗ Caractères autorisés : lettres, chiffres, - _ .';
        }
        hintNum.className = 'field-hint invalid';
    }
});

// ── Validation de l'email en temps réel ──────────────────────────
const emailInput = document.getElementById('email');
const hintEmail  = document.getElementById('hint-email');

emailInput.addEventListener('input', function () {
    const val = this.value.trim();
    if (val === '') {
        this.classList.remove('valid', 'invalid');
        hintEmail.className = 'field-hint neutral';
        hintEmail.textContent = 'Format : nom@domaine.extension';
        return;
    }
    if (PATTERN_EMAIL.test(val)) {
        this.classList.add('valid'); this.classList.remove('invalid');
        hintEmail.className = 'field-hint valid';
        hintEmail.textContent = '✓ Email valide';
    } else {
        this.classList.add('invalid'); this.classList.remove('valid');
        hintEmail.className = 'field-hint invalid';
        // Message précis selon l'erreur
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
});

// ── Bloquer la soumission si invalide ────────────────────────────
document.getElementById('addForm').addEventListener('submit', function (e) {
    const num   = numInput.value.trim();
    const email = emailInput.value.trim();
    let ok = true;

    if (!PATTERN_NUM.test(num)) {
        numInput.classList.add('invalid');
        hintNum.className = 'field-hint invalid';
        hintNum.textContent = '✗ Numéro invalide : doit contenir au moins un chiffre';
        ok = false;
    }
    if (!PATTERN_EMAIL.test(email)) {
        emailInput.classList.add('invalid');
        hintEmail.className = 'field-hint invalid';
        hintEmail.textContent = '✗ Email invalide : format attendu exemple@mail.com';
        ok = false;
    }

    if (!ok) {
        e.preventDefault(); // Bloquer l'envoi
        // Scroller vers le premier champ en erreur
        document.querySelector('.invalid').scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
});
</script>
</body>
</html>
