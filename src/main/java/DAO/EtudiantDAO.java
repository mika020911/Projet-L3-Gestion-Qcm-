package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Etudiant;

public class EtudiantDAO {

    // ===== Ajouter =====
    public void addEtudiant(Etudiant e) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "INSERT INTO etudiant VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, e.getNum());
            ps.setString(2, e.getNom());
            ps.setString(3, e.getPrenom());
            ps.setString(4, e.getNiveau());
            ps.setString(5, e.getEmail());
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ===== Lister tous =====
    public ArrayList<Etudiant> getAll() throws Exception {
        ArrayList<Etudiant> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM etudiant";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setNum(rs.getString("num_etudiant"));
                e.setNom(rs.getString("nom"));
                e.setPrenom(rs.getString("prenom"));
                e.setNiveau(rs.getString("niveau"));
                e.setEmail(rs.getString("email"));
                list.add(e);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ===== Supprimer =====
    public void delete(String num) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "DELETE FROM etudiant WHERE num_etudiant = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, num);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ===== Modifier =====
    public void update(Etudiant e) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "UPDATE etudiant SET nom=?, prenom=?, niveau=?, email=? WHERE num_etudiant=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, e.getNom());
            ps.setString(2, e.getPrenom());
            ps.setString(3, e.getNiveau());
            ps.setString(4, e.getEmail());
            ps.setString(5, e.getNum());
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ===== Trouver par ID =====
    public Etudiant findById(String num) throws Exception {
        Etudiant e = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM etudiant WHERE num_etudiant = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, num);
            rs = ps.executeQuery();
            if (rs.next()) {
                e = new Etudiant();
                e.setNum(rs.getString("num_etudiant"));
                e.setNom(rs.getString("nom"));
                e.setPrenom(rs.getString("prenom"));
                e.setNiveau(rs.getString("niveau"));
                e.setEmail(rs.getString("email"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return e;
    }

    // ===== Login =====
    public boolean login(String num, String email) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM etudiant WHERE num_etudiant=? AND email=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, num);
            ps.setString(2, email);
            rs = ps.executeQuery();
            return rs.next();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // ===== Lister par niveau =====
    public ArrayList<Etudiant> getByNiveau(String niveau) throws Exception {
        ArrayList<Etudiant> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM etudiant WHERE niveau = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, niveau);
            rs = ps.executeQuery();
            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setNum(rs.getString("num_etudiant"));
                e.setNom(rs.getString("nom"));
                e.setPrenom(rs.getString("prenom"));
                e.setNiveau(rs.getString("niveau"));
                e.setEmail(rs.getString("email"));
                list.add(e);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ===== Compter par niveau =====
    public int countByNiveau(String niveau) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT COUNT(*) FROM etudiant WHERE niveau = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, niveau);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return 0;
    }

    // ===== Compter total =====
    public int countAll() throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT COUNT(*) FROM etudiant";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return 0;
    }

    // ===== Rechercher =====
    public ArrayList<Etudiant> search(String motCle) throws Exception {
        ArrayList<Etudiant> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "SELECT * FROM etudiant WHERE nom LIKE ? OR num_etudiant LIKE ? OR prenom LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + motCle + "%");
            ps.setString(2, "%" + motCle + "%");
            ps.setString(3, "%" + motCle + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Etudiant e = new Etudiant();
                e.setNum(rs.getString("num_etudiant"));
                e.setNom(rs.getString("nom"));
                e.setPrenom(rs.getString("prenom"));
                e.setNiveau(rs.getString("niveau"));
                e.setEmail(rs.getString("email"));
                list.add(e);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }
}