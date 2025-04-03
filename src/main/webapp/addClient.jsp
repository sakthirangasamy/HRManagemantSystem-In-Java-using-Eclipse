<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.employee.Model.Client" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Client</title>
     <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Public Sans', sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
        }

        .container {
            background-color: white;
            padding: 30px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px;
            margin-left: 500px;
            border-radius: 8px;
            height: 530px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"], input[type="date"], input[type="email"],textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .message {
            padding: 10px;
            margin-top: 20px;
            color: white;
            text-align: center;
            border-radius: 5px;
        }

        .success {
            background-color: #4CAF50;
        }

        .error {
            background-color: #f44336;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>
    <div class="container">
        <h1>Add New Client</h1>
        <form action="addClientServlet" method="POST">
            <label for="clientName">Client Name</label>
            <input type="text" id="clientName" name="clientName" required><br><br>

            <label for="contactPerson">Contact Person</label>
            <input type="text" id="contactPerson" name="contactPerson" required><br><br>

            <label for="clientEmail">Client Email</label>
            <input type="email" id="clientEmail" name="clientEmail" required><br><br>

            <label for="clientPhone">Client Phone</label>
            <input type="text" id="clientPhone" name="clientPhone" required><br><br>

            <label for="startDate">Client RelationShip Date</label>
            <input type="date" id="startDate" name="startDate" required><br><br>

            <button type="submit">Add Client</button>
        </form>
    </div>
</body>
</html>
