package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;
import DAO.QcmDAO;
import model.Etudiant;
import model.Qcm;

@WebServlet("/ExamenServlet")
public class ExamenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session étudiant
        HttpSession session = request.getSession();
        String numEtudiant = (String) session.getAttribute("etudiant");

        if (numEtudiant == null) {
            response.sendRedirect("loginEtudiant.jsp");
            return;
        }

        try {
            // Récupérer le niveau de l'étudiant connecté
            EtudiantDAO etuDao = new EtudiantDAO();
            Etudiant etu = etuDao.findById(numEtudiant);

            if (etu == null) {
                response.sendRedirect("loginEtudiant.jsp");
                return;
            }

            String niveau = etu.getNiveau(); // ex: "M1"

            // Récupérer 10 questions aléatoires du niveau de l'étudiant
            QcmDAO qcmDao = new QcmDAO();
            ArrayList<Qcm> list = qcmDao.getRandomQcmByNiveau(niveau, 10);

            if (list.isEmpty()) {
                // Pas encore de questions pour ce niveau
                request.setAttribute("erreur", "Aucune question disponible pour le niveau " + niveau + ". Contactez l'administrateur.");
                request.getRequestDispatcher("Examen.jsp").forward(request, response);
                return;
            }

            // Stocker en session pour la correction
            session.setAttribute("qcmList", list);
            session.setAttribute("niveauExamen", niveau);

            // Passer à la JSP
            request.setAttribute("liste", list);
            request.setAttribute("niveau", niveau);
            request.getRequestDispatcher("Examen.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}