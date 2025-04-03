<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Employee Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h1 {
            font-size: 24px;
            color: #333;
        }

        .input-field {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #45a049;
        }

        .error-msg {
            color: red;
            font-size: 14px;
        }

        .login-footer {
            margin-top: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h1>Admin Login</h1>

        <!-- Login Form -->
        <form action="AdminLoginServlet" method="POST">
            <input type="text" name="username" class="input-field" placeholder="Username" required />
            <input type="password" name="password" class="input-field" placeholder="Password" required />
            <button type="submit" class="submit-btn">Login</button>
        </form>

        <!-- Error message (if any) -->
        <div class="error-msg">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </div>

        <div class="login-footer">
            <p>&copy; 2025 Employee Management System</p>
        </div>
    </div>

</body>
</html>
