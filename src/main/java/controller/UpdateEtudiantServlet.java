package controller;

import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;
import model.Etudiant;

@WebServlet("/UpdateEtudiantServlet")
public class UpdateEtudiantServlet extends HttpServlet {

    // ── Mêmes règles que AddEtudiantServlet ──────────────────────────────
    // Numéro : au moins un chiffre, caractères autorisés : lettres chiffres - _ .
    private static final Pattern PATTERN_NUM =
        Pattern.compile("^(?=.*[0-9])[A-Za-z0-9\\-_.]+$");

    // Email : format standard nom@domaine.extension
    private static final Pattern PATTERN_EMAIL =
        Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    // GET : afficher le formulaire pré-rempli
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        String num = request.getParameter("num_etudiant");

        try {
            EtudiantDAO dao = new EtudiantDAO();
            Etudiant e = dao.findById(num);

            request.setAttribute("etudiant", e);
            request.getRequestDispatcher("EditEtudiant.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // POST : valider puis mettre à jour
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String num    = request.getParameter("num_etudiant") != null ? request.getParameter("num_etudiant").trim() : "";
        String nom    = request.getParameter("nom")          != null ? request.getParameter("nom").trim()          : "";
        String prenom = request.getParameter("prenom")       != null ? request.getParameter("prenom").trim()       : "";
        String niveau = request.getParameter("niveau")       != null ? request.getParameter("niveau").trim()       : "";
        String email  = request.getParameter("email")        != null ? request.getParameter("email").trim()        : "";

        // ── Validation ───────────────────────────────────────────────────
        if (!PATTERN_NUM.matcher(num).matches()) {
            request.getSession().setAttribute("editMsg", "error");
            request.getSession().setAttribute("editMsgDetail",
                "Numéro invalide : il doit contenir au moins un chiffre (ex: 0001, 002-H).");
            response.sendRedirect("UpdateEtudiantServlet?num_etudiant=" + num);
            return;
        }

        if (!PATTERN_EMAIL.matcher(email).matches()) {
            request.getSession().setAttribute("editMsg", "error");
            request.getSession().setAttribute("editMsgDetail",
                "Email invalide : utilisez le format exemple@domaine.com");
            response.sendRedirect("UpdateEtudiantServlet?num_etudiant=" + num);
            return;
        }

        if (nom.isEmpty() || prenom.isEmpty() || niveau.isEmpty()) {
            request.getSession().setAttribute("editMsg", "error");
            request.getSession().setAttribute("editMsgDetail", "Tous les champs sont obligatoires.");
            response.sendRedirect("UpdateEtudiantServlet?num_etudiant=" + num);
            return;
        }

        // ── Mise à jour en base ──────────────────────────────────────────
        try {
            Etudiant e = new Etudiant();
            e.setNum(num);
            e.setNom(nom);
            e.setPrenom(prenom);
            e.setNiveau(niveau);
            e.setEmail(email);

            EtudiantDAO dao = new EtudiantDAO();
            dao.update(e);

            request.getSession().setAttribute("editMsg", "success");
            request.getSession().setAttribute("editMsgDetail",
                "Étudiant " + nom + " " + prenom + " modifié avec succès !");

            response.sendRedirect(request.getContextPath() + "/ListeEtudiantServlet");

        } catch (Exception ex) {
            ex.printStackTrace();
            request.getSession().setAttribute("editMsg", "error");
            request.getSession().setAttribute("editMsgDetail",
                "Erreur base de données : " + ex.getMessage());
            response.sendRedirect("UpdateEtudiantServlet?num_etudiant=" + num);
        }
    }
}