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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int score = 0;
        int total = 0;

        try {
            // 🔥 récupérer les questions depuis la session
            ArrayList<Qcm> list =
                (ArrayList<Qcm>) request.getSession().getAttribute("qcmList");

            for (Qcm q : list) {

                // récupérer réponse utilisateur
                String rep = request.getParameter("q_" + q.getNum());

                if (rep != null) {
                    total++;

                    // comparer avec bonne réponse
                    if (Integer.parseInt(rep) == q.getBr()) {
                        score++;
                    }
                }
            }

            // 👉 calcul note sur 20
            int note = score;

            // 👉 étudiant 
            HttpSession session = request.getSession();

            String num_etudiant =
                (String) session.getAttribute("etudiant");

            // 👉 créer examen
            Examen ex = new Examen();
            ex.setNum_etudiant(num_etudiant);
            ex.setAnnee_Sco("2025-2026");
            ex.setNote(note);

            // 👉 sauvegarde DB
            ExamenDAO dao = new ExamenDAO();
            dao.save(ex);
            
            //emai etudiant
            EtudiantDAO etuDao = new EtudiantDAO();

            Etudiant etu = etuDao.findById(num_etudiant);

            String email = etu.getEmail();


            String from = "mikaeddys@gmail.com";

            String password = "ljjozhcymlebsjkm";

            Properties prop = new Properties();

            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");

            Session mailSession = Session.getInstance(prop,
                    new Authenticator() {

                        protected PasswordAuthentication getPasswordAuthentication() {

                            return new PasswordAuthentication(from, password);
                        }
                    });

            Message message = new MimeMessage(mailSession);

            message.setFrom(new InternetAddress(from));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(email)
            );

            message.setSubject("Résultat Examen");

            message.setText(
                    "Bonjour " + etu.getNom() + ",\n\n"
                    + "Votre score est : " + score + "/" + total + "\n"
                    + "Votre note est : " + note + "/10\n\n"
                    + "Bonne continuation."
            );

            Transport.send(message);

            // =========================================

            response.getWriter().println(
                    "<h1>Examen terminé</h1>"
                    + "<h2>Email envoyé à : " + email + "</h2>"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Erreur : " + e.getMessage()
            );
        }
    }
}
