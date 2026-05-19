package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.QcmDAO;
import model.Qcm;

@WebServlet("/AddQcmServlet")
public class AddQcmServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int    num    = Integer.parseInt(request.getParameter("num_question"));
            String qst    = request.getParameter("question");
            String rep1   = request.getParameter("reponse1");
            String rep2   = request.getParameter("reponse2");
            String rep3   = request.getParameter("reponse3");
            String rep4   = request.getParameter("reponse4");
            int    bRep   = Integer.parseInt(request.getParameter("bonne_reponse"));
            String theme  = request.getParameter("theme");
            String niveau = request.getParameter("niveau");

            Qcm q = new Qcm();
            q.setNum(num);
            q.setQst(qst);
            q.setR1(rep1);
            q.setR2(rep2);
            q.setR3(rep3);
            q.setR4(rep4);
            q.setBr(bRep);
            q.setTheme(theme);
            q.setNiveau(niveau);

            QcmDAO dao = new QcmDAO();
            dao.addQcm(q);

            request.getSession().setAttribute("msg", "success");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "error");
        }

        response.sendRedirect("AjouterQcm.jsp");
    }
}