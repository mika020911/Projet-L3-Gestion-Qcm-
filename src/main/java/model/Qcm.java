package model;

public class Qcm {

    private int    num_question;
    private String question;
    private String reponse1;
    private String reponse2;
    private String reponse3;
    private String reponse4;
    private int    bonne_reponse;
    private String theme;   // ex: "Mathematiques", "Physique", "Histoire"
    private String niveau;  // ex: "L1", "L2", "L3", "M1", "M2"

    // ===== Getters & Setters =====

    public int getNum() { return num_question; }
    public void setNum(int num_question) { this.num_question = num_question; }

    public String getQst() { return question; }
    public void setQst(String question) { this.question = question; }

    public String getR1() { return reponse1; }
    public void setR1(String reponse1) { this.reponse1 = reponse1; }

    public String getR2() { return reponse2; }
    public void setR2(String reponse2) { this.reponse2 = reponse2; }

    public String getR3() { return reponse3; }
    public void setR3(String reponse3) { this.reponse3 = reponse3; }

    public String getR4() { return reponse4; }
    public void setR4(String reponse4) { this.reponse4 = reponse4; }

    public int getBr() { return bonne_reponse; }
    public void setBr(int bonne_reponse) { this.bonne_reponse = bonne_reponse; }

    public String getTheme() { return theme; }
    public void setTheme(String theme) { this.theme = theme; }

    public String getNiveau() { return niveau; }
    public void setNiveau(String niveau) { this.niveau = niveau; }
}