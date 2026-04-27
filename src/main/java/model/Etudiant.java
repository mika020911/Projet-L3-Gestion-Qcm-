package model;

public class Etudiant {
	private String num;
	private String nom ;
	private String prenom;
	private String niveau;
	private String email;
	
	//setter getter 
	
	public String getNum() {return num;}
	public void setNum(String num) {this.num = num;}
	
	public String getNom() {return nom; }
	public void setNom(String nom) {this.nom =nom;}
	
	public String getPrenom() {return prenom;}
	public void setPrenom(String prenom) {this.prenom = prenom;}
	
	public String getNiveau() {return niveau;}
	public void setNiveau(String niveau) {this.niveau = niveau;}
	
	public String getEmail () {return email;}
	public void setEmail(String email) {this.email = email;}
	
}
