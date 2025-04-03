<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.servlet.http.HttpSession" %>
<%
    // Get parameters from form submission
    String userOTP = request.getParameter("otp");
    
    // Get session attributes
    HttpSession session1 = request.getSession();
    String sessionOTP = (String) session.getAttribute("otp");
    String email = (String) session.getAttribute("email");
    Integer attempts = (Integer) session.getAttribute("attempts");
    if (attempts == null) attempts = 0;
    
    // Validate OTP
    if (userOTP == null || userOTP.isEmpty()) {
        response.sendRedirect("verifyOTP.jsp?error=Please enter OTP");
    } 
    else if (sessionOTP == null || email == null) {
        response.sendRedirect("clientLogin.jsp?error=Session expired. Please login again.");
    }
    else if (!userOTP.equals(sessionOTP)) {
        attempts++;
        session1.setAttribute("attempts", attempts);
        
        if (attempts >= 5) {
            // Lock account for 5 minutes
            long lockTime = System.currentTimeMillis() + (5 * 60 * 1000);
            session1.setAttribute("lockedUntil", lockTime);
            response.sendRedirect("verifyOTP.jsp");
        } else {
            response.sendRedirect("verifyOTP.jsp?error=Invalid OTP. Please try again.");
        }
    }
    else {
        // Successful verification
        session1.removeAttribute("otp");
        session1.removeAttribute("attempts");
        session1.removeAttribute("lockedUntil");
        session1.setAttribute("authenticated", true);
        response.sendRedirect("clientDashboard.jsp");
    }
%>