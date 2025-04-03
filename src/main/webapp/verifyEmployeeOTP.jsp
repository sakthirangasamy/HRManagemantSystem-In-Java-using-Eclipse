<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .container {
            width: 100%;
            max-width: 450px;
            padding: 20px;
        }
        
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }
        
        .logo {
            margin-bottom: 20px;
            color: #4CAF50;
            font-size: 24px;
            font-weight: bold;
        }
        
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        
        .email-display {
            font-weight: bold;
            color: #4CAF50;
            margin: 10px 0;
            word-break: break-all;
        }
        
        .attempts {
            color: #666;
            margin: 15px 0;
            font-size: 14px;
        }
        
        .error {
            color: #e74c3c;
            background-color: #fdecea;
            padding: 10px;
            border-radius: 5px;
            margin: 15px 0;
            font-size: 14px;
        }
        
        .success {
            color: #2ecc71;
            background-color: #e8f8f0;
            padding: 10px;
            border-radius: 5px;
            margin: 15px 0;
            font-size: 14px;
        }
        
        .locked {
            color: #8B0000;
            background-color: #ffebee;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
            font-weight: bold;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border 0.3s;
        }
        
        input[type="text"]:focus {
            border-color: #4CAF50;
            outline: none;
        }
        
        button, .button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        button:hover, .button:hover {
            background-color: #45a049;
        }
        
        .resend-option {
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }
        
        .resend-link {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
            margin-left: 5px;
        }
        
        .resend-link:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 480px) {
            .card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="logo">Employee Portal</div>
            
            <%
                // Get session attributes
                String email = (String) session.getAttribute("employeeEmail");
                String sessionOtp = (String) session.getAttribute("otp");
                Integer attempts = (Integer) session.getAttribute("attempts");
                if (attempts == null) attempts = 0;
                Long lockedUntil = (Long) session.getAttribute("lockedUntil");
                
                // Check if email exists in session
                if (email == null || email.isEmpty()) {
                    response.sendRedirect("employeeLogin.jsp");
                    return;
                }
                
                // Check if account is locked
                if (lockedUntil != null && lockedUntil > System.currentTimeMillis()) {
                    long remainingSeconds = (lockedUntil - System.currentTimeMillis()) / 1000;
                    long minutes = remainingSeconds / 60;
                    long seconds = remainingSeconds % 60;
            %>
                    <div class="locked">
                        <h3>Account Temporarily Locked</h3>
                        <p>Too many incorrect attempts. Please try again in:</p>
                        <p><%= minutes %>m <%= seconds %>s</p>
                    </div>
            <%
                    return;
                }
                
                // Display error message if previous attempt failed
                String errorMsg = request.getParameter("error");
                if (errorMsg != null) {
            %>
                    <div class="error"><%= errorMsg %></div>
            <%
                }
                
                // Display success message if OTP was resent
                String successMsg = request.getParameter("success");
                if (successMsg != null) {
            %>
                    <div class="success"><%= successMsg %></div>
            <%
                }
            %>

            <h2>Verify OTP</h2>
            <div class="email-display">Sent to <%= email %></div>
            <div class="attempts">Remaining attempts: <strong><%= 5 - attempts %></strong></div>
            
            <form action="validateEmployeeOTP.jsp" method="post">
                <div class="form-group">
                    <label for="otp">6-digit OTP</label>
                    <input type="text" id="otp" name="otp" pattern="\d{6}" 
                           title="Please enter 6-digit OTP" required 
                           placeholder="Enter your 6-digit code">
                </div>
                <button type="submit">Verify</button>
            </form>
            
            <div class="resend-option">
                Didn't receive OTP? 
                <a href="resendEmployeeOTP.jsp" class="resend-link">Resend OTP</a>
            </div>
        </div>
    </div>
</body>
</html>