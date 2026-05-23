package controller;

import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.EtudiantDAO;
import model.Etudiant;

@WebServlet("/AddEtudiantServlet")
public class AddEtudiantServlet extends HttpServlet {

    // ── Règles de validation ──────────────────────────────────────────────
    //
    // Numéro étudiant : doit contenir AU MOINS un chiffre
    //   ✅ Accepté  : 0001 / 002-H / ETU-2024 / 12A / A1B2
    //   ❌ Refusé   : ABC / hello / --- (que des lettres ou symboles)
    //
    // Regex : au moins un chiffre [0-9] quelque part dans la chaîne
    // Le reste peut être lettres, chiffres, tirets, underscores, points
    private static final Pattern PATTERN_NUM =
        Pattern.compile("^(?=.*[0-9])[A-Za-z0-9\\-_.]+$");

    // Email : format standard nom@domaine.extension
    //   ✅ Accepté  : exemple@mail.com / jean.rakoto@univ-fianarantsoa.mg
    //   ❌ Refusé   : monmail / @mail / exemple@ / exemple@mail
    private static final Pattern PATTERN_EMAIL =
        Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String num    = request.getParameter("num")    != null ? request.getParameter("num").trim()    : "";
        String nom    = request.getParameter("nom")    != null ? request.getParameter("nom").trim()    : "";
        String prenom = request.getParameter("prenom") != null ? request.getParameter("prenom").trim() : "";
        String niveau = request.getParameter("niveau") != null ? request.getParameter("niveau").trim() : "";
        String email  = request.getParameter("email")  != null ? request.getParameter("email").trim()  : "";

        // ── Validation côté serveur ───────────────────────────────────────
        if (!PATTERN_NUM.matcher(num).matches()) {
            request.getSession().setAttribute("msg", "error");
            request.getSession().setAttribute("msgDetail",
                "Numéro invalide : il doit contenir au moins un chiffre (ex: 0001, 002-H, ETU2024).");
            response.sendRedirect("AjouterEtudiant.jsp");
            return;
        }

        if (!PATTERN_EMAIL.matcher(email).matches()) {
            request.getSession().setAttribute("msg", "error");
            request.getSession().setAttribute("msgDetail",
                "Email invalide : utilisez le format exemple@domaine.com");
            response.sendRedirect("AjouterEtudiant.jsp");
            return;
        }

        if (nom.isEmpty() || prenom.isEmpty() || niveau.isEmpty()) {
            request.getSession().setAttribute("msg", "error");
            request.getSession().setAttribute("msgDetail", "Tous les champs sont obligatoires.");
            response.sendRedirect("AjouterEtudiant.jsp");
            return;
        }

        // ── Insertion en base ─────────────────────────────────────────────
        try {
            Etudiant e = new Etudiant();
            e.setNum(num);
            e.setNom(nom);
            e.setPrenom(prenom);
            e.setNiveau(niveau);
            e.setEmail(email);

            EtudiantDAO dao = new EtudiantDAO();
            dao.addEtudiant(e);

            request.getSession().setAttribute("msg", "success");
            request.getSession().setAttribute("msgDetail", "Étudiant " + nom + " " + prenom + " ajouté avec succès !");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "error");
            request.getSession().setAttribute("msgDetail", "Erreur base de données : " + e.getMessage());
        }

        response.sendRedirect("AjouterEtudiant.jsp");
    }
}