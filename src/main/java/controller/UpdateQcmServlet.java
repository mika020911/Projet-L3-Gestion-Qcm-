package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.QcmDAO;
import model.Qcm;




@WebServlet("/UpdateQcmServlet")
public class UpdateQcmServlet extends HttpServlet {

    // 👉 1. GET = afficher formulaire
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

    // 👉 2. POST = faire update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
           Qcm q = new Qcm();

            q.setNum(Integer.parseInt( request.getParameter( "num_question")));
            q.setQst(request.getParameter("question"));
            q.setR1(request.getParameter("reponse1"));
            q.setR2(request.getParameter("reponse2"));
            q.setR3(request.getParameter("reponse3"));
            q.setR4(request.getParameter("reponse4"));
            q.setBr(Integer.parseInt(request.getParameter("bonne_reponse")));

            QcmDAO dao = new QcmDAO();
            dao.update(q);

            response.sendRedirect(request.getContextPath() + "/ListeQcmServlet");

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}