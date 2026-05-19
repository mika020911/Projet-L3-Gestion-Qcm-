package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session admin
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        try {
            EtudiantDAO dao = new EtudiantDAO();

            request.setAttribute("total", dao.countAll());
            request.setAttribute("l1",    dao.countByNiveau("L1"));
            request.setAttribute("l2",    dao.countByNiveau("L2"));
            request.setAttribute("l3",    dao.countByNiveau("L3"));
            request.setAttribute("m1",    dao.countByNiveau("M1"));
            request.setAttribute("m2",    dao.countByNiveau("M2"));

            request.getRequestDispatcher("Dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}