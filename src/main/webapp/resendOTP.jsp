<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, java.security.SecureRandom" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.mail.PasswordAuthentication" %>

<%
    // Get session and email
    HttpSession userSession = request.getSession();
    String email = (String) userSession.getAttribute("email");
    
    // If no email in session, redirect to login
    if (email == null || email.isEmpty()) {
        response.sendRedirect("login.jsp?error=Session expired. Please login again.");
        return;
    }

    // Check if resend is allowed (prevent abuse)
    Long lastResendTime = (Long) userSession.getAttribute("lastResendTime");
    if (lastResendTime != null && System.currentTimeMillis() - lastResendTime < 30000) {
        response.sendRedirect("verifyOTP.jsp?error=Please wait 30 seconds before requesting a new OTP");
        return;
    }

    // Generate new 6-digit OTP
    SecureRandom random = new SecureRandom();
    int otp = 100000 + random.nextInt(900000);
    
    // Update session with new OTP
    userSession.setAttribute("otp", String.valueOf(otp));
    userSession.setAttribute("otpGeneratedTime", System.currentTimeMillis());
    userSession.setAttribute("lastResendTime", System.currentTimeMillis());

    // Email configuration
    final String username = "otpsendermessage@gmail.com";
    final String password = "tsqomkanhqigptsg";
    String subject = "Your New OTP Code";
    String messageText = "Your new OTP is: " + otp + "\nValid for 10 minutes";

    try {
        // SMTP properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        // Create session with authentication
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        // Create and send email
        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(username, "OTP Service"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject(subject);
        message.setText(messageText);
        Transport.send(message);

        // Redirect back with success message
        response.sendRedirect("verifyOTP.jsp?success=New OTP has been sent to " + email);
        
    } catch (Exception e) {
        // Log the error and redirect
        e.printStackTrace();
        response.sendRedirect("verifyOTP.jsp?error=Failed to resend OTP. Please try again.");
    }
%>