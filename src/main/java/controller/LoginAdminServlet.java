package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginAdminServlet")
public class LoginAdminServlet extends HttpServlet {

    // ⚠️ En production : stocker le mot de passe hashé en base de données
    private static final String CODE_ADMIN = "Admin01";
    private static final String PASSWORD   = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code_admin = request.getParameter("code_admin");
        String password   = request.getParameter("mdp");

        if (CODE_ADMIN.equals(code_admin) && PASSWORD.equals(password)) {

            HttpSession session = request.getSession();
            session.setAttribute("admin", "admin");
            response.sendRedirect("DashboardServlet");

        } else {
            // Retour à la page login avec message d'erreur
            request.getSession().setAttribute("loginError", "Code ou mot de passe incorrect.");
            response.sendRedirect("AdminPage.jsp");
        }
    }
}