package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.QcmDAO;

@WebServlet("/DeleteQcmServlet")
public class DeleteQcmServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Vérification session admin
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        int num = Integer.parseInt(request.getParameter("num_question"));

        try {
            QcmDAO dao = new QcmDAO();
            dao.delete(num);
            response.sendRedirect("ListeQcmServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}