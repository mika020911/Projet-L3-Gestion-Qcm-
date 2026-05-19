package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;

// CORRECTION : nom de classe en PascalCase (était loginEtudiantServlet)
@WebServlet("/loginEtudiantServlet")
public class loginEtudiantServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String num   = request.getParameter("num_etudiant");
        String email = request.getParameter("email");

        try {
            EtudiantDAO dao = new EtudiantDAO();
            boolean ok = dao.login(num, email);

            if (ok) {
                HttpSession session = request.getSession();
                session.setAttribute("etudiant", num);
                response.sendRedirect("ExamenServlet");
            } else {
                request.getSession().setAttribute("loginError", "Numéro étudiant ou email incorrect.");
                response.sendRedirect("loginEtudiant.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}