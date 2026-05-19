package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Examen;

public class ExamenDAO {

    // ===== Sauvegarder =====
    public void save(Examen ex) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "INSERT INTO examen(num_etudiant, annee_universitaire, note) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, ex.getNum_etudiant());
            ps.setString(2, ex.getAnnee_Sco());
            ps.setInt(3, ex.getNote());
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ===== Lister tous =====
    public ArrayList<Examen> getAll() throws Exception {
        ArrayList<Examen> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM examen ORDER BY num_exam DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Examen ex = new Examen();
                ex.setNum_exam(rs.getInt("num_exam"));
                ex.setNum_etudiant(rs.getString("num_etudiant"));
                ex.setAnnee_Sco(rs.getString("annee_universitaire"));
                ex.setNote(rs.getInt("note"));
                list.add(ex);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }
}