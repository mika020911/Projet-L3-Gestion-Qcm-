package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.QcmDAO;
import model.Qcm;

@WebServlet("/ExamenServlet")
public class ExamenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            QcmDAO dao = new QcmDAO();

            // 🔥 10 questions aléatoires
            ArrayList<Qcm> list = dao.getRandomQcm(10);

            // session pour correction
            HttpSession session = request.getSession(true);
            session.setAttribute("qcmList", list);

            // request pour affichage JSP
            request.setAttribute("liste", list);

            // forward UNIQUE
            request.getRequestDispatcher("Examen.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}