package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Qcm;

public class QcmDAO {

    // ========== Helper : mapper un ResultSet vers un objet Qcm ==========
    private Qcm map(ResultSet rs) throws SQLException {
        Qcm q = new Qcm();
        q.setNum(rs.getInt("num_question"));
        q.setQst(rs.getString("question"));
        q.setR1(rs.getString("reponse1"));
        q.setR2(rs.getString("reponse2"));
        q.setR3(rs.getString("reponse3"));
        q.setR4(rs.getString("reponse4"));
        q.setBr(rs.getInt("bonne_reponse"));
        q.setTheme(rs.getString("theme"));
        q.setNiveau(rs.getString("niveau"));
        return q;
    }

    // ========== Ajouter ==========
    public void addQcm(Qcm q) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "INSERT INTO qcm (num_question, question, reponse1, reponse2, reponse3, reponse4, bonne_reponse, theme, niveau) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, q.getNum());
            ps.setString(2, q.getQst());
            ps.setString(3, q.getR1());
            ps.setString(4, q.getR2());
            ps.setString(5, q.getR3());
            ps.setString(6, q.getR4());
            ps.setInt(7, q.getBr());
            ps.setString(8, q.getTheme());
            ps.setString(9, q.getNiveau());
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ========== 10 questions aléatoires filtrées par NIVEAU ==========
    // Utilisé pour l'examen étudiant
    public ArrayList<Qcm> getRandomQcmByNiveau(String niveau, int limit) throws Exception {
        ArrayList<Qcm> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM qcm WHERE niveau = ? ORDER BY RAND() LIMIT ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, niveau);
            ps.setInt(2, limit);
            rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ========== Lister tous ==========
    public ArrayList<Qcm> getAll() throws Exception {
        ArrayList<Qcm> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM qcm ORDER BY niveau, theme, num_question";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ========== Lister par niveau ==========
    public ArrayList<Qcm> getByNiveau(String niveau) throws Exception {
        ArrayList<Qcm> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM qcm WHERE niveau = ? ORDER BY theme, num_question";
            ps = conn.prepareStatement(sql);
            ps.setString(1, niveau);
            rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ========== Lister par theme ==========
    public ArrayList<Qcm> getByTheme(String theme) throws Exception {
        ArrayList<Qcm> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM qcm WHERE theme = ? ORDER BY niveau, num_question";
            ps = conn.prepareStatement(sql);
            ps.setString(1, theme);
            rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ========== Supprimer ==========
    public void delete(int num) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "DELETE FROM qcm WHERE num_question = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, num);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ========== Modifier ==========
    public void update(Qcm q) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "UPDATE qcm SET question=?, reponse1=?, reponse2=?, reponse3=?, reponse4=?, bonne_reponse=?, theme=?, niveau=? "
                       + "WHERE num_question=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, q.getQst());
            ps.setString(2, q.getR1());
            ps.setString(3, q.getR2());
            ps.setString(4, q.getR3());
            ps.setString(5, q.getR4());
            ps.setInt(6, q.getBr());
            ps.setString(7, q.getTheme());
            ps.setString(8, q.getNiveau());
            ps.setInt(9, q.getNum()); // WHERE
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ========== Trouver par ID ==========
    public Qcm findById(int num) throws Exception {
        Qcm q = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM qcm WHERE num_question = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, num);
            rs = ps.executeQuery();
            if (rs.next()) q = map(rs);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return q;
    }

    // ========== Rechercher ==========
    public ArrayList<Qcm> search(String motCle) throws Exception {
        ArrayList<Qcm> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM qcm WHERE question LIKE ? OR num_question LIKE ? OR theme LIKE ? OR niveau LIKE ?";
            ps = conn.prepareStatement(sql);
            String mc = "%" + motCle + "%";
            ps.setString(1, mc);
            ps.setString(2, mc);
            ps.setString(3, mc);
            ps.setString(4, mc);
            rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }
}