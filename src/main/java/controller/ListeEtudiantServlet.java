package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DAO.EtudiantDAO;
import model.Etudiant;

@WebServlet("/ListeEtudiantServlet")
public class ListeEtudiantServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String motCle = request.getParameter("motCle");

        ArrayList<Etudiant> list = new ArrayList<>();

        try {
            EtudiantDAO dao = new EtudiantDAO();

            System.out.println("motCle = [" + motCle + "]");

            if (motCle != null && !motCle.trim().isEmpty()) {
            	list = dao.search(motCle);
            } else {
                list = dao.getAll();
            }

            request.setAttribute("liste", list);
            request.getRequestDispatcher("ListeEtudiant.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}