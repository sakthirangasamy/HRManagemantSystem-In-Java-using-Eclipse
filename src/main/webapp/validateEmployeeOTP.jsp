<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String userOTP = request.getParameter("otp");
    HttpSession session1 = request.getSession();
    
    // Check if account is locked
    Long lockedUntil = (Long) session1.getAttribute("lockedUntil");
    if (lockedUntil != null && System.currentTimeMillis() < lockedUntil) {
        long remainingSeconds = (lockedUntil - System.currentTimeMillis()) / 1000;
        response.sendRedirect("verifyEmployeeOTP.jsp?error=Account locked. Try again in " + 
                            remainingSeconds + " seconds");
        return;
    }

    // Validate OTP
    if (userOTP == null || !userOTP.matches("\\d{6}")) {
        response.sendRedirect("verifyEmployeeOTP.jsp?error=Invalid OTP format");
        return;
    }

    String sessionOTP = (String) session1.getAttribute("otp");
    String email = (String) session1.getAttribute("employeeEmail");
    
    if (sessionOTP == null || email == null) {
        response.sendRedirect("employeeLogin.jsp?error=Session expired. Please login again");
        return;
    }

    if (!userOTP.equals(sessionOTP)) {
        // Increment attempt count
        Integer attempts = (Integer) session1.getAttribute("attempts");
        if (attempts == null) attempts = 0;
        attempts++;
        session1.setAttribute("attempts", attempts);
        
        if (attempts >= 5) {
            // Lock account for 5 minutes
            session1.setAttribute("lockedUntil", System.currentTimeMillis() + (5 * 60 * 1000));
            response.sendRedirect("employeeLogin.jsp?error=Too many attempts. Account locked for 5 minutes.");
        } else {
            response.sendRedirect("verifyEmployeeOTP.jsp?error=Invalid OTP. Please try again.");
        }
        return;
    }

    // Successful login
    session1.removeAttribute("otp");
    session1.removeAttribute("attempts");
    session1.removeAttribute("lockedUntil");
    session1.setAttribute("authenticated", true);
    response.sendRedirect("employeeDashboard.jsp");
%>