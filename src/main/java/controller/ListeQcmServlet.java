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

        // Vérification session admin
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("AdminPage.jsp");
            return;
        }

        String motCle = request.getParameter("motCle");
        String niveau = request.getParameter("niveau");  // filtre niveau
        String theme  = request.getParameter("theme");   // filtre theme

        ArrayList<Qcm> list = new ArrayList<>();

        try {
            QcmDAO dao = new QcmDAO();

            if (motCle != null && !motCle.trim().isEmpty()) {
                list = dao.search(motCle);
            } else if (niveau != null && !niveau.trim().isEmpty()) {
                list = dao.getByNiveau(niveau);
            } else if (theme != null && !theme.trim().isEmpty()) {
                list = dao.getByTheme(theme);
            } else {
                list = dao.getAll();
            }

            // Repasser les filtres actifs à la vue pour pré-sélectionner les listes
            request.setAttribute("liste", list);
            request.setAttribute("filtreNiveau", niveau);
            request.setAttribute("filtreTheme", theme);

            request.getRequestDispatcher("ListeQcm.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}