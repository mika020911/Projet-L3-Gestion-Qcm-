package model;

import java.util.Date;

public class Examen {
	
	private int num_exam ;
	private String num_etudiant;
	private String annee_scolaire;
	private int note;
	
// Setter Gettter

	public int getNum_exam() {
		return num_exam;
	}

	public void setNum_exam (int num_exam) {
		this.num_exam = num_exam;
	}
	
	public String getNum_etudiant () {
		return num_etudiant;
	}
	
	public void setNum_etudiant (String num_etudiant) {
		
		this.num_etudiant = num_etudiant;
	}
	public String getAnnee_Sco () {
		return annee_scolaire;
	}
	public void setAnnee_Sco (String annee_scolaire) {
		this.annee_scolaire = annee_scolaire;
	}
	public int getNote () {
		return note;
	}
	public void setNote (int  note) {
		this.note = note;
	}
	
}