package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;

@WebServlet("/loginEtudiantServlet")
public class loginEtudiantServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String num = request.getParameter("num_etudiant");
        String email = request.getParameter("email");

        try {

            EtudiantDAO dao = new EtudiantDAO();

            boolean ok = dao.login(num, email);

            if (ok) {

                // 🔥 SESSION
                HttpSession session = request.getSession();

                session.setAttribute("etudiant", num);

                response.sendRedirect("ExamenServlet");

            } else {

                response.getWriter().println("❌ Login incorrect");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}