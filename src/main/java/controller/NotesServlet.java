package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.ExamenDAO;
import model.Examen;

@WebServlet("/NotesServlet")
public class NotesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session admin
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        // Filtre optionnel par niveau
        String niveau = request.getParameter("niveau");
        // Filtre optionnel par étudiant
        String numEtudiant = request.getParameter("num_etudiant");

        try {
            ExamenDAO dao = new ExamenDAO();
            ArrayList<Examen> list;

            if (numEtudiant != null && !numEtudiant.trim().isEmpty()) {
                // Notes d'un seul étudiant
                list = dao.getByEtudiant(numEtudiant.trim());
                request.setAttribute("filtreEtudiant", numEtudiant.trim());
            } else {
                // Toutes les notes avec infos étudiant
                list = dao.getNotesAvecEtudiant();
            }

            // Filtrer par niveau côté Java si besoin
            if (niveau != null && !niveau.trim().isEmpty()) {
                ArrayList<Examen> filtree = new ArrayList<>();
                for (Examen ex : list) {
                    if (niveau.trim().equals(ex.getNiveau())) {
                        filtree.add(ex);
                    }
                }
                list = filtree;
                request.setAttribute("filtreNiveau", niveau.trim());
            }

            request.setAttribute("liste", list);
            request.getRequestDispatcher("ListeNotes.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}