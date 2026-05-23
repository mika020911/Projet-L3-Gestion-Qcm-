package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Examen;

public class ExamenDAO {

    // ===== Supprimer tous les examens d'un étudiant =====
    public void deleteByEtudiant(String numEtudiant) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql = "DELETE FROM examen WHERE num_etudiant = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, numEtudiant);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

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

    // ===== Liste des notes avec infos étudiant (JOIN) =====
    // Retourne : num_etudiant, nom, prenom, niveau, annee_universitaire, note
    public ArrayList<Examen> getNotesAvecEtudiant() throws Exception {
        ArrayList<Examen> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql =
                "SELECT e.num_exam, e.num_etudiant, et.nom, et.prenom, et.niveau, " +
                "       e.annee_universitaire, e.note " +
                "FROM examen e " +
                "JOIN etudiant et ON e.num_etudiant = et.num_etudiant " +
                "ORDER BY e.annee_universitaire DESC, e.note DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Examen ex = new Examen();
                ex.setNum_exam(rs.getInt("num_exam"));
                ex.setNum_etudiant(rs.getString("num_etudiant"));
                ex.setNom(rs.getString("nom"));
                ex.setPrenom(rs.getString("prenom"));
                ex.setNiveau(rs.getString("niveau"));
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

    // ===== Classement par ordre de mérite =====
    // Moyenne des notes par étudiant, triée décroissante
    // Filtre optionnel par niveau (null = tous niveaux)
    public ArrayList<Examen> getClassement(String niveau) throws Exception {
        ArrayList<Examen> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql =
                "SELECT e.num_etudiant, et.nom, et.prenom, et.niveau, " +
                "       COUNT(e.num_exam)  AS nb_examens, " +
                "       MAX(e.note)        AS meilleure_note, " +
                "       ROUND(AVG(e.note), 2) AS moyenne " +
                "FROM examen e " +
                "JOIN etudiant et ON e.num_etudiant = et.num_etudiant ";

            if (niveau != null && !niveau.trim().isEmpty()) {
                sql += "WHERE et.niveau = ? ";
            }

            sql += "GROUP BY e.num_etudiant, et.nom, et.prenom, et.niveau " +
                   "ORDER BY moyenne DESC, meilleure_note DESC";

            ps = conn.prepareStatement(sql);
            if (niveau != null && !niveau.trim().isEmpty()) {
                ps.setString(1, niveau);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Examen ex = new Examen();
                ex.setNum_etudiant(rs.getString("num_etudiant"));
                ex.setNom(rs.getString("nom"));
                ex.setPrenom(rs.getString("prenom"));
                ex.setNiveau(rs.getString("niveau"));
                ex.setNbExamens(rs.getInt("nb_examens"));
                ex.setMeilleureNote(rs.getInt("meilleure_note"));
                ex.setMoyenne(rs.getDouble("moyenne"));
                list.add(ex);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    // ===== Notes d'un seul étudiant =====
    public ArrayList<Examen> getByEtudiant(String numEtudiant) throws Exception {
        ArrayList<Examen> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = utils.connectionDB.getConnection();
            String sql =
                "SELECT e.num_exam, e.num_etudiant, et.nom, et.prenom, et.niveau, " +
                "       e.annee_universitaire, e.note " +
                "FROM examen e " +
                "JOIN etudiant et ON e.num_etudiant = et.num_etudiant " +
                "WHERE e.num_etudiant = ? " +
                "ORDER BY e.num_exam DESC";
            ps = conn.prepareStatement(sql);
            ps.setString(1, numEtudiant);
            rs = ps.executeQuery();
            while (rs.next()) {
                Examen ex = new Examen();
                ex.setNum_exam(rs.getInt("num_exam"));
                ex.setNum_etudiant(rs.getString("num_etudiant"));
                ex.setNom(rs.getString("nom"));
                ex.setPrenom(rs.getString("prenom"));
                ex.setNiveau(rs.getString("niveau"));
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