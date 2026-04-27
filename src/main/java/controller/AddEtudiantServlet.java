package controller;
import 	java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddEtudiantServlet")
public class AddEtudiantServlet extends HttpServlet {

	@Override
	protected void 	doPost ( HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException{
		
		
		//Recup donner form 
		String num = request.getParameter("num");
		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String niveau = request.getParameter("niveau");
		String email = request.getParameter("email");
		
		Connection conn =null;
		PreparedStatement ps = null;
		
		try {
			// connect.......
			conn = utils.connectionDB.getConnection();
			//REquest sql
			String sql = "INSERT into etudiant (num_etudiant, nom, prenom , niveau, email) VALUES(?,?,?,?,?)";
			ps = conn.prepareStatement (sql);
			
			ps.setString(1, num);
			ps.setString(2, nom);
			ps.setString(3, prenom);
			ps.setString(4, niveau);
			ps.setString(5, email);
			//exe
			
			ps.executeUpdate();
			// if success
			response.sendRedirect("AjouterEtudiant.jsp");
		 } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("Erreur : " + e.getMessage());
	        } finally {
	            try {
	                if (ps != null) ps.close();
	                if (conn != null) conn.close();
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
		}
}
