<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, javax.mail.*, javax.mail.internet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Login</title>
    <style>
        /* Basic styling for the page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            margin: 100px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
            border-radius: 8px;
        }
        input[type="email"] {
            padding: 10px;
            margin-bottom: 20px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
        }
         button { background: #4CAF50; color: white; border: none; padding: 10px 15px; 
               border-radius: 4px; cursor: pointer; }
        
    </style>
</head>
<body>

    <div class="container">
        <h2>Client Login</h2>
        <form action="sendOTP.jsp" method="post">
            <label for="email">Enter your Email:</label>
            <input type="email" id="email" name="email" required>
            <input type="submit" value="Send OTP">
        </form>
 <a href='index.jsp'><button style="margin-left: 300px;">Click Back</button></a>
       
        <%
            // Display error message if any unsuccessful login attempt
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error"><%= errorMessage %></p>
        <% } %>
    </div>

</body>
</html>
