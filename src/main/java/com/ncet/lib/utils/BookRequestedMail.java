package com.ncet.lib.utils;

import java.util.Properties;
import java.util.ResourceBundle;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

public class BookRequestedMail {

//	 SendMail.sendEmail(student.getGmail(),emailSubject, emailBody);
    public static void sendEmail(String toAddress, String subjcet, String name,String transIdMsg) {
        // Load SMTP properties from the properties file
        ResourceBundle rb = ResourceBundle.getBundle("smtp");

        // Extract SMTP server details
        String host = rb.getString("mail.smtp.host");
        String port = rb.getString("mail.smtp.port");
        String auth = rb.getString("mail.smtp.auth");
        String starttls = rb.getString("mail.smtp.starttls.enable");
        String fromEmail = rb.getString("mail.from");
        String password = rb.getString("mail.password");

        // Set SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", auth);
        properties.put("mail.smtp.starttls.enable", starttls);

        // Create a session with an authenticator
        Authenticator authInstance = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        Session session = Session.getInstance(properties, authInstance);

        try {
            // Create a new email message
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
            msg.setSubject(subjcet);

            // Create the email content with embedded image
            MimeMultipart multipart = new MimeMultipart("related");

            // HTML part
            BodyPart messageBodyPart = new MimeBodyPart();
            String htmlText = "<!DOCTYPE html>"
                    + "<html>"
                    + "<head>"
                    + "<style>"
                    + "body {font-family: Arial, sans-serif;}"
                    + ".container {padding: 20px; text-align: center;}"
                    + ".banner {width: 100%; max-width: 600px; margin: 0 auto; display: block;}"
                    + ".content {background-color: #f9f9f9; padding: 20px; border-radius: 8px;}"
                    + ".tid-msg {font-size: 24px; font-weight: bold; color: #333;}"
                    + ".footer {margin-top: 20px; font-size: 12px; color: #777;}"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class='container'>"
                    + "<img src='cid:bannerImage' alt='National College of Engineering and Technology-logo' class='banner'/>"
                    + "<div class='content'>"
                    + "<h3>"+"Hello "+name+"</h3>"
                    +"<p class='tid-msg'>"+transIdMsg+"</p>"
                    +"<p>Please get your book at Library Admin</p>"
                    +"<p>Keep Learnig will make shining the world</p>"
                    + "</div>"
                    + "<div class='footer'>"
                    + "<p>&copy; National College of Engineering and Technology - All Rights Reserved</p>"
                    + "</div>"
                    + "</div>"
                    + "</body>"
                    + "</html>";
            messageBodyPart.setContent(htmlText, "text/html; charset=utf-8");
            multipart.addBodyPart(messageBodyPart);

            // Image part
            messageBodyPart = new MimeBodyPart();
            String imagePath = "C:/Users/Shiva_Yad_007/eclipse-workspace/JSP/02-JSP-LibraryProject-Demo/src/main/webapp/img/NCET-Banner.png"; // Replace with the relative path to your image
            DataSource fds = new FileDataSource(imagePath);
            messageBodyPart.setDataHandler(new DataHandler(fds));
            messageBodyPart.setHeader("Content-ID", "<bannerImage>");
            multipart.addBodyPart(messageBodyPart);

            // Set the complete message parts
            msg.setContent(multipart);

            // Send the email
            Transport.send(msg);

            System.out.println("Email sent successfully");

        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

}
