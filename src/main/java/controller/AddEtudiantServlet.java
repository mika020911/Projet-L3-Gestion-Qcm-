package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.EtudiantDAO;
import model.Etudiant;

@WebServlet("/AddEtudiantServlet")
public class AddEtudiantServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupération des données du formulaire
        String num    = request.getParameter("num");
        String nom    = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String niveau = request.getParameter("niveau");
        String email  = request.getParameter("email");

        try {
            // Utilisation du DAO (pas de SQL dans le servlet)
            Etudiant e = new Etudiant();
            e.setNum(num);
            e.setNom(nom);
            e.setPrenom(prenom);
            e.setNiveau(niveau);
            e.setEmail(email);

            EtudiantDAO dao = new EtudiantDAO();
            dao.addEtudiant(e);

            request.getSession().setAttribute("msg", "success");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "error");
        }

        response.sendRedirect("AjouterEtudiant.jsp");
    }
}