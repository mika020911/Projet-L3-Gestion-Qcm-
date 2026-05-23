package model;

public class Examen {

    // Champs de base
    private int    num_exam;
    private String num_etudiant;
    private String annee_scolaire;
    private int    note;

    // Champs enrichis (JOIN avec étudiant)
    private String nom;
    private String prenom;
    private String niveau;

    // Champs pour le classement (agrégats)
    private double moyenne;
    private int    meilleureNote;
    private int    nbExamens;

    // ===== Getters & Setters base =====

    public int getNum_exam() { return num_exam; }
    public void setNum_exam(int num_exam) { this.num_exam = num_exam; }

    public String getNum_etudiant() { return num_etudiant; }
    public void setNum_etudiant(String num_etudiant) { this.num_etudiant = num_etudiant; }

    public String getAnnee_Sco() { return annee_scolaire; }
    public void setAnnee_Sco(String annee_scolaire) { this.annee_scolaire = annee_scolaire; }

    public int getNote() { return note; }
    public void setNote(int note) { this.note = note; }

    // ===== Getters & Setters enrichis =====

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getNiveau() { return niveau; }
    public void setNiveau(String niveau) { this.niveau = niveau; }

    // ===== Getters & Setters classement =====

    public double getMoyenne() { return moyenne; }
    public void setMoyenne(double moyenne) { this.moyenne = moyenne; }

    public int getMeilleureNote() { return meilleureNote; }
    public void setMeilleureNote(int meilleureNote) { this.meilleureNote = meilleureNote; }

    public int getNbExamens() { return nbExamens; }
    public void setNbExamens(int nbExamens) { this.nbExamens = nbExamens; }

    // ===== Helpers =====

    // Mention selon la moyenne
    public String getMention() {
        if (moyenne >= 9)  return "Très Bien";
        if (moyenne >= 7)  return "Bien";
        if (moyenne >= 5)  return "Assez Bien";
        if (moyenne >= 3)  return "Passable";
        return "Insuffisant";
    }

    // Couleur CSS selon la mention
    public String getMentionColor() {
        if (moyenne >= 9)  return "#22c55e";
        if (moyenne >= 7)  return "#4f6ef7";
        if (moyenne >= 5)  return "#f59e0b";
        if (moyenne >= 3)  return "#f97316";
        return "#ef4444";
    }
}