package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;
import DAO.ExamenDAO;

@WebServlet("/DeleteEtudiantServlet")
public class DeleteEtudiantServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Vérification session admin
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        String num = request.getParameter("num_etudiant");

        // Vérifier que le paramètre n'est pas vide
        if (num == null || num.trim().isEmpty()) {
            session.setAttribute("msg", "error");
            session.setAttribute("msgDetail", "Numéro étudiant manquant.");
            response.sendRedirect("ListeEtudiantServlet");
            return;
        }

        try {
            // ÉTAPE 1 : supprimer d'abord les examens liés à cet étudiant
            // (évite l'erreur de clé étrangère FK)
            ExamenDAO examenDao = new ExamenDAO();
            examenDao.deleteByEtudiant(num.trim());

            // ÉTAPE 2 : supprimer l'étudiant
            EtudiantDAO etudiantDao = new EtudiantDAO();
            etudiantDao.delete(num.trim());

            session.setAttribute("msg", "success");
            session.setAttribute("msgDetail", "Étudiant " + num + " supprimé avec succès.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "error");
            session.setAttribute("msgDetail", "Erreur lors de la suppression : " + e.getMessage());
        }

        response.sendRedirect("ListeEtudiantServlet");
    }
}