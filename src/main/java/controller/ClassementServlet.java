package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.ExamenDAO;
import model.Examen;

@WebServlet("/ClassementServlet")
public class ClassementServlet extends HttpServlet {

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

        try {
            ExamenDAO dao = new ExamenDAO();
            ArrayList<Examen> classement = dao.getClassement(niveau);

            request.setAttribute("classement", classement);
            request.setAttribute("filtreNiveau", niveau != null ? niveau : "");
            request.getRequestDispatcher("Classement.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}