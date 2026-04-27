package controller;

import 	java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddQcmServlet")
public class AddQcmServlet extends HttpServlet{
	
	@Override
	protected void 	doPost ( HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{		
		
		//Recup donner form 
		int num = Integer.parseInt(request.getParameter("num_question"));
		String qst = request.getParameter("question");
		String rep1 = request.getParameter("reponse1");
		String rep2 = request.getParameter("reponse2");
		String rep3= request.getParameter("reponse3");
		String rep4= request.getParameter("reponse4");
		int B_rep = Integer.parseInt(request.getParameter("bonne_reponse"));	
		
		Connection conn =null;
		PreparedStatement ps = null;
		
		try {
			// connect.......
			conn = utils.connectionDB.getConnection();
			//REquest sql
			String sql = "INSERT into qcm (num_question, question,reponse1, reponse2, reponse3, reponse4, bonne_reponse) VALUES(?,?,?,?,?,?,?)";
			ps = conn.prepareStatement (sql);
			
			ps.setInt(1, num);
			ps.setString(2, qst);
			ps.setString(3, rep1);
			ps.setString(4, rep2);
			ps.setString(5, rep3);
			ps.setString(6, rep4);
			ps.setInt(7, B_rep);
			//exe
			
			ps.executeUpdate();
			// if success
			response.sendRedirect("AjouterQcm.jsp");
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
