package com.ncet.lib.utils;

import java.util.Properties;
import java.util.ResourceBundle;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {
    public static void sendEmail(String toAddress, String subject, String message) {

        // Load SMTP properties from the properties file
        ResourceBundle rb = ResourceBundle.getBundle("smtp");

        // Extract SMTP server details
        String host = rb.getString("mail.smtp.host");
        String port = rb.getString("mail.smtp.port");
        String auth = rb.getString("mail.smtp.auth");
        String starttls = rb.getString("mail.smtp.starttls.enable");
        String username = rb.getString("mailFrom");
        String password = rb.getString("password");

        // Sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", auth);
        properties.put("mail.smtp.starttls.enable", starttls);

        // Creates a new session with an authenticator
        Authenticator auth1 = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };

        Session session = Session.getInstance(properties, auth1);

        try {
            // Creates a new email message
            Message msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(username));
            InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
            msg.setRecipients(Message.RecipientType.TO, toAddresses);
            msg.setSubject(subject);
            msg.setSentDate(new java.util.Date());
            msg.setText(message);

            // Sends the email
            Transport.send(msg);

            System.out.println("Email sent successfully.");

        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }
}
