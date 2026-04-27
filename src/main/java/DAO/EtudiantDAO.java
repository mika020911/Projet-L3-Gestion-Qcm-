package DAO;

import java.sql.*;
import java.util.ArrayList;

public class EtudiantDAO {

    // Ajouter
    public void addEtudiant(model.Etudiant e) throws Exception {
        Connection conn = utils.connectionDB.getConnection();

        String sql = "INSERT INTO etudiant VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, e.getNum());
        ps.setString(2, e.getNom());
        ps.setString(3, e.getPrenom());
        ps.setString(4, e.getNiveau());
        ps.setString(5, e.getEmail());

        ps.executeUpdate();
    }

    // Lister
    public ArrayList<model.Etudiant> getAll() throws Exception {
        ArrayList<model.Etudiant> list = new ArrayList<>();
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT * FROM etudiant";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            model.Etudiant e = new model.Etudiant();
            e.setNum(rs.getString("num_etudiant"));
            e.setNom(rs.getString("nom"));
            e.setPrenom(rs.getString("prenom"));
            e.setNiveau(rs.getString("niveau"));
            e.setEmail(rs.getString("email"));

            list.add(e);
        }

        return list;
    }

    // ----------------------------------Supprimer--------------------------------
    public void delete(String num) throws Exception {
        Connection conn = utils.connectionDB.getConnection();

        String sql = "DELETE FROM etudiant WHERE num_etudiant = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, num);

        ps.executeUpdate();
    }
    
    //update
    public void update(model.Etudiant e) throws Exception {
        Connection conn = utils.connectionDB.getConnection();

        String sql = "UPDATE etudiant SET nom=?, prenom=?, niveau=?, email=? WHERE num_etudiant=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, e.getNom());
        ps.setString(2, e.getPrenom());
        ps.setString(3, e.getNiveau());
        ps.setString(4, e.getEmail());
        ps.setString(5, e.getNum());

        ps.executeUpdate();
        
        
    }
    
    //--------------------------------------- FindById -----------------------------------
    public model.Etudiant findById(String num) throws Exception {
        model.Etudiant e = null;

        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT * FROM etudiant WHERE num_etudiant = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, num);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            e = new model.Etudiant();
            e.setNum(rs.getString("num_etudiant"));
            e.setNom(rs.getString("nom"));
            e.setPrenom(rs.getString("prenom"));
            e.setNiveau(rs.getString("niveau"));
            e.setEmail(rs.getString("email"));
        }

        return e;
    }
    
    //-----------------------GetByNiveau----------------------------------------
    
    public ArrayList<model.Etudiant> getByNiveau(String niveau) throws Exception {
        ArrayList<model.Etudiant> list = new ArrayList<>();
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT * FROM etudiant WHERE niveau = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, niveau);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            model.Etudiant e = new model.Etudiant();
            e.setNum(rs.getString("num_etudiant"));
            e.setNom(rs.getString("nom"));
            e.setPrenom(rs.getString("prenom"));
            e.setNiveau(rs.getString("niveau"));
            e.setEmail(rs.getString("email"));

            list.add(e);
        }

        return list;
    }
    
    //--------------------------Effectif par niveau--------------------------
    public int countByNiveau(String niveau) throws Exception {
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT COUNT(*) FROM etudiant WHERE niveau = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, niveau);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }
    
    //--------------------------EFFECTIF TOTAL ------------------------------------
    public int countAll() throws Exception {
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT COUNT(*) FROM etudiant";
        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }
    
    // -------------------------Rechercher-----------------------------------------
    public ArrayList<model.Etudiant> search(String motCle) throws Exception {
        ArrayList<model.Etudiant> list = new ArrayList<>();
        Connection conn = utils.connectionDB.getConnection();

        String sql = "SELECT * FROM etudiant WHERE nom LIKE ? OR num_etudiant LIKE ? OR prenom LIKE ?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, "%" + motCle + "%");
        ps.setString(2, "%" + motCle + "%");
        ps.setString(3, "%" + motCle + "%");

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            model.Etudiant e = new model.Etudiant();
            e.setNum(rs.getString("num_etudiant"));
            e.setNom(rs.getString("nom"));
            e.setPrenom(rs.getString("prenom"));
            e.setNiveau(rs.getString("niveau"));
            e.setEmail(rs.getString("email"));

            list.add(e);
        }

        return list;
    }
}
