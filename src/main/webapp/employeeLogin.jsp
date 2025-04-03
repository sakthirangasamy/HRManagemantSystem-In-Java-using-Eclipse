<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Login</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f5f5f5; }
        .container { max-width: 400px; margin: 50px auto; padding: 20px; 
                   background: white; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="email"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        button { background: #4CAF50; color: white; border: none; padding: 10px 15px; 
               border-radius: 4px; cursor: pointer; }
        .error { color: red; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Employee Login</h2>
        <form action="sendEmployeeOTP.jsp" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>
            <button type="submit">Send OTP</button>
        </form>
        <a href='index.jsp'><button style="margin-left: 300px;">Click Back</button></a>
        <%-- Display error message if any --%>
        <%
        String error = request.getParameter("error");
        if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <% } %>
    </div>
</body>
</html>