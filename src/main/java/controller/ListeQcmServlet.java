package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.QcmDAO;
import model.Qcm;

@WebServlet("/ListeQcmServlet")
public class ListeQcmServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String motCle = request.getParameter("motCle");

        ArrayList<Qcm> list = new ArrayList<>();

        try {
            QcmDAO dao = new QcmDAO();

            System.out.println("motCle = [" + motCle + "]");

            if (motCle != null && !motCle.trim().isEmpty()) {
            	list = dao.search(motCle);
            } else {
                list = dao.getAll();
            }

            request.setAttribute("liste", list);
            request.getRequestDispatcher("ListeQcm.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}