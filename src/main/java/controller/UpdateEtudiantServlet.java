package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;
import model.Etudiant;

@WebServlet("/UpdateEtudiantServlet")
public class UpdateEtudiantServlet extends HttpServlet {

    // GET : afficher le formulaire pré-rempli
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session admin
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

    // POST : effectuer la mise à jour
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Etudiant e = new Etudiant();
            e.setNum(request.getParameter("num_etudiant"));
            e.setNom(request.getParameter("nom"));
            e.setPrenom(request.getParameter("prenom"));
            e.setNiveau(request.getParameter("niveau"));
            e.setEmail(request.getParameter("email"));

            EtudiantDAO dao = new EtudiantDAO();
            dao.update(e);

            response.sendRedirect(request.getContextPath() + "/ListeEtudiantServlet");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}