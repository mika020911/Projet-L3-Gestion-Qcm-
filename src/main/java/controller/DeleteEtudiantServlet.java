package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;

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

        try {
            EtudiantDAO dao = new EtudiantDAO();
            dao.delete(num);
            response.sendRedirect("ListeEtudiantServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}