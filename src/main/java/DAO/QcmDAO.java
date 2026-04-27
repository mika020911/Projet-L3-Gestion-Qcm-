package DAO;
import java.sql.*;
//import java.util.ArrayList;
import java.util.ArrayList;

public class QcmDAO {
	
    // Ajouter
    public void addQcm(model.Qcm q) throws Exception {
        Connection conn = utils.connectionDB.getConnection();

        String sql = "INSERT INTO qcm VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, q.getNum());
        ps.setString(2, q.getQst());
        ps.setString(3, q.getR1());
        ps.setString(4, q.getR2());
        ps.setString(5, q.getR3());
        ps.setString(6, q.getR4());
        ps.setInt(7, q.getBr());
        
        ps.executeUpdate();
    }
    // Lister
    public ArrayList<model.Qcm> getAll() throws Exception {
        ArrayList<model.Qcm> list = new ArrayList<>();
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT * FROM qcm";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            model.Qcm q = new model.Qcm();
            q.setNum(rs.getInt("num_question"));
            q.setQst(rs.getString("question"));
            q.setR1(rs.getString("reponse1"));
            q.setR2(rs.getString("reponse2"));
            q.setR3(rs.getString("reponse3"));
            q.setR4(rs.getString("reponse4"));
            q.setBr(rs.getInt("bonne_reponse"));
           

            list.add(q);
        }

        return list;
    }
    
    // -------------------------Rechercher-----------------------------------------
    public ArrayList<model.Qcm> search(String motCle) throws Exception {
        ArrayList<model.Qcm> list = new ArrayList<>();
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT * FROM qcm WHERE question LIKE ? OR num_question LIKE ? ";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, "%" + motCle + "%");
        ps.setString(2, "%" + motCle + "%");
        

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            model.Qcm e = new model.Qcm();
            e.setNum(rs.getInt("num_question"));
            e.setQst(rs.getString("question"));
            e.setR1(rs.getString("reponse1"));
            e.setR2(rs.getString("reponse2"));
            e.setR3(rs.getString("reponse3"));
            e.setR4(rs.getString("reponse4"));
            e.setBr(rs.getInt("bonne_reponse"));
            

            list.add(e);
        }

        return list;
    }
}
