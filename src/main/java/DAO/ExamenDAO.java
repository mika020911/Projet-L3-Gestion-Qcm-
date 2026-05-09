package DAO;
import java.sql.*;
import java.util.ArrayList;

public class ExamenDAO {
	//=================SAVE===========================
	public void save(model.Examen ex) throws Exception {

	    Connection conn = utils.connectionDB.getConnection();

	    String sql = "INSERT INTO examen(num_etudiant, annee_universitaire, note) VALUES (?, ?, ?)";
	    PreparedStatement ps = conn.prepareStatement(sql);

	    ps.setString(1, ex.getNum_etudiant());
	    ps.setString(2, ex.getAnnee_Sco());
	    ps.setInt(3, ex.getNote());
	    
	    
	    ps.executeUpdate();
	}
	//==========================getAll======================================
	public ArrayList<model.Examen> getAll() throws Exception{
		
	    ArrayList<model.Examen> list = new ArrayList<>();
	    Connection conn = utils.connectionDB.getConnection();

	    String sql = "SELECT * FROM examen ORDER BY num_exam DESC";
	    PreparedStatement ps = conn.prepareStatement(sql);

	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	        model.Examen ex = new model.Examen();

	        ex.setNum_exam(rs.getInt("num_exam"));
	        ex.setNum_etudiant(rs.getString("num_etudiant"));
	        ex.setAnnee_Sco(rs.getString("annee_universitaire"));
	        ex.setNote(rs.getInt("note"));

	        list.add(ex);
	    }

	    return list;
	    

	}
	
	
}
