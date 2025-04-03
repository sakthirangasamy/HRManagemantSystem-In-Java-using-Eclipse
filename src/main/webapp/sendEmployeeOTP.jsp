<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, javax.mail.*, javax.mail.internet.*, java.security.SecureRandom" %>
<%
    String email = request.getParameter("email");
    
    if (email == null || email.isEmpty()) {
        response.sendRedirect("employeeLogin.jsp?error=Email is required");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // 1. Check if employee exists
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");
        
        String sql = "SELECT employee_id, employee_email FROM employee WHERE employee_email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            response.sendRedirect("employeeLogin.jsp?error=Employee not found with this email");
            return;
        }

        // 2. Generate 6-digit OTP
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000);
        
        // 3. Store in session
        HttpSession session1 = request.getSession();
        session1.setAttribute("otp", String.valueOf(otp));
        session1.setAttribute("employeeEmail", email);
        session1.setAttribute("employeeId", rs.getInt("employee_id"));
        session1.setAttribute("attempts", 0);
        session1.setAttribute("lockedUntil", null);
        session1.setAttribute("otpGeneratedTime", System.currentTimeMillis());
        
        // 4. Send OTP email
        final String mailUser = "otpsendermessage@gmail.com";
        final String mailPass = "tsqomkanhqigptsg";
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(mailUser, mailPass);
            }
        });
        
        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(mailUser, "Employee Portal"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Your OTP Code");
            message.setText("Your OTP is: " + otp + "\nValid for 10 minutes");
            
            Transport.send(message);
            response.sendRedirect("verifyEmployeeOTP.jsp");
        } catch (MessagingException e) {
            response.sendRedirect("employeeLogin.jsp?error=Failed to send OTP. Please try again.");
        }
        
    } catch (Exception e) {
        response.sendRedirect("employeeLogin.jsp?error=System error. Please try again.");
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>