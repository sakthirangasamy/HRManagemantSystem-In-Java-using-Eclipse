<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" 
    import="java.util.*, java.sql.*, javax.mail.*, javax.mail.internet.*, java.security.SecureRandom" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send OTP</title>
</head>
<body>

<%
    String email = request.getParameter("email");
    
    if (email == null || email.isEmpty()) {
        out.println("<script>alert('Email is required!'); window.location.href='clientLogin.jsp';</script>");
        return;
    }

    // Database connection and validation
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/employeemanagementsystem", 
            "root", 
            "root");
        
        // Check if email exists in contact_person_email
        String sql = "SELECT contact_person_email FROM client WHERE contact_person_email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            out.println("<script>alert('Email not registered!'); window.location.href='clientLogin.jsp';</script>");
            return;
        }
        
        // Generate OTP
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000);
        
        // Store in session
        HttpSession userSession = request.getSession();
        userSession.setAttribute("otp", String.valueOf(otp));
        userSession.setAttribute("email", email);
        userSession.setAttribute("attempts", 0);
        userSession.setAttribute("lockedUntil", null);
        userSession.setAttribute("otpGeneratedTime", System.currentTimeMillis());
        
        // Send email
        final String username = "otpsendermessage@gmail.com";
        final String password = "tsqomkanhqigptsg";
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(username, "OTP Service"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Your OTP Code");
        message.setText("Your OTP is: " + otp + "\nValid for 10 minutes");
        
        Transport.send(message);
        response.sendRedirect("verifyOTP.jsp");
        
    } catch (Exception e) {
        out.println("<script>alert('Error sending OTP. Please try again.'); window.location.href='clientLogin.jsp';</script>");
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

</body>
</html>