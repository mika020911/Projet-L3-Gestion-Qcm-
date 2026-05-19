package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.QcmDAO;
import model.Qcm;

@WebServlet("/UpdateQcmServlet")
public class UpdateQcmServlet extends HttpServlet {

    // GET : afficher le formulaire pré-rempli
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        int num = Integer.parseInt(request.getParameter("num_question"));

        try {
            QcmDAO dao = new QcmDAO();
            Qcm q = dao.findById(num);

            request.setAttribute("qcm", q);
            request.getRequestDispatcher("EditQcm.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // POST : effectuer la mise à jour
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Qcm q = new Qcm();
            q.setNum(Integer.parseInt(request.getParameter("num_question")));
            q.setQst(request.getParameter("question"));
            q.setR1(request.getParameter("reponse1"));
            q.setR2(request.getParameter("reponse2"));
            q.setR3(request.getParameter("reponse3"));
            q.setR4(request.getParameter("reponse4"));
            q.setBr(Integer.parseInt(request.getParameter("bonne_reponse")));
            q.setTheme(request.getParameter("theme"));
            q.setNiveau(request.getParameter("niveau"));

            QcmDAO dao = new QcmDAO();
            dao.update(q);

            response.sendRedirect(request.getContextPath() + "/ListeQcmServlet");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}