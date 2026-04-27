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

        try {
            EtudiantDAO dao = new EtudiantDAO();

            int total = dao.countAll();
            int l1 = dao.countByNiveau("L1");
            int l2 = dao.countByNiveau("L2");
            int l3 = dao.countByNiveau("L3");
            int m1 = dao.countByNiveau("M1");
            int m2 = dao.countByNiveau("M2");
            

            request.setAttribute("total", total);
            request.setAttribute("l1", l1);
            request.setAttribute("l2", l2);
            request.setAttribute("l3", l3);
            request.setAttribute("m1", m1);
            request.setAttribute("m2", m2);

            request.getRequestDispatcher("Dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
