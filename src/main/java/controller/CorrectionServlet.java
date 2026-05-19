package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.Properties;

import DAO.ExamenDAO;
import DAO.EtudiantDAO;
import model.Etudiant;
import model.Examen;
import model.Qcm;

@WebServlet("/CorrectionServlet")
public class CorrectionServlet extends HttpServlet {

    // ⚠️ À déplacer dans un fichier config.properties en production
    private static final String MAIL_FROM     = "mikaeddys@gmail.com";
    private static final String MAIL_PASSWORD = "ljjozhcymlebsjkm";

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Vérification session
        String numEtudiant = (String) session.getAttribute("etudiant");
        if (numEtudiant == null) {
            response.sendRedirect("loginEtudiant.jsp");
            return;
        }

        int score = 0;
        int total = 0;

        try {
            ArrayList<Qcm> list = (ArrayList<Qcm>) session.getAttribute("qcmList");
            String niveauExamen  = (String) session.getAttribute("niveauExamen");

            // Correction des réponses
            for (Qcm q : list) {
                String rep = request.getParameter("q_" + q.getNum());
                if (rep != null) {
                    total++;
                    if (Integer.parseInt(rep) == q.getBr()) {
                        score++;
                    }
                }
            }

            int note = score; // note sur 10

            // Sauvegarder l'examen en base
            Examen ex = new Examen();
            ex.setNum_etudiant(numEtudiant);
            ex.setAnnee_Sco("2025-2026");
            ex.setNote(note);

            ExamenDAO examenDao = new ExamenDAO();
            examenDao.save(ex);

            // Récupérer l'étudiant pour l'email
            EtudiantDAO etuDao = new EtudiantDAO();
            Etudiant etu = etuDao.findById(numEtudiant);

            // Envoi de l'email de résultat
            envoyerEmail(etu.getEmail(), etu.getNom(), niveauExamen, score, total, note);

            // Invalider la session après l'examen
            session.invalidate();

            // Afficher page de confirmation simple
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println(
                "<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Examen terminé</title></head><body>"
                + "<h1>✅ Examen terminé !</h1>"
                + "<p>Bonjour <b>" + etu.getNom() + " " + etu.getPrenom() + "</b>,</p>"
                + "<p>Votre score : <b>" + score + " / " + total + "</b></p>"
                + "<p>Votre note  : <b>" + note + " / 10</b></p>"
                + "<p>📧 Un email de résultat a été envoyé à : <b>" + etu.getEmail() + "</b></p>"
                + "<br><a href='loginEtudiant.jsp'>🔙 Retour à l'accueil</a>"
                + "</body></html>"
            );

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur : " + e.getMessage());
        }
    }

    private void envoyerEmail(String email, String nom, String niveau,
                               int score, int total, int note)
            throws MessagingException {

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(prop, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MAIL_FROM, MAIL_PASSWORD);
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(MAIL_FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Résultat Examen - Niveau " + niveau);
        message.setText(
            "Bonjour " + nom + ",\n\n"
            + "Voici vos résultats pour l'examen de niveau " + niveau + " :\n\n"
            + "  Score : " + score + " / " + total + "\n"
            + "  Note  : " + note + " / 10\n\n"
            + "Bonne continuation."
        );

        Transport.send(message);
    }
}