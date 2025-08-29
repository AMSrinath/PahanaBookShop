package pahana.education.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pahana.education.util.EmailUtil;

import java.io.IOException;

public class SendEmailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String toEmail = request.getParameter("to");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        boolean isSent = EmailUtil.sendEmail(toEmail, subject, messageText);

        if (isSent) {
            response.getWriter().println("Email sent successfully!");
        } else {
            response.getWriter().println("Failed to send email.");
        }
    }
}
