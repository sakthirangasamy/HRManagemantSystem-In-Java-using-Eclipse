<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Employees</title>
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Public Sans', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .container {
          margin:10px 300px 0px ;
            padding-left:200px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 70%;
        }

        table {
    
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        .button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .button.delete {
            background-color: #f44336;
        }

        .button:hover {
            background-color: #45a049;
        }

        .button.delete:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>
    <div class="container">
        <h1>View All Employees</h1>

        <!-- Displaying the list of employees -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Date of Joining</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection parameters
                    String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
                    String dbUser = "root";
                    String dbPass = "root";
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        // Establishing database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        // Query to fetch employees
                        String sql = "SELECT * FROM employee";
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery(sql);

                        // Iterating through the result set and displaying employee data
                        while (resultSet.next()) {
                %>
                            <tr>
                                <td><%= resultSet.getString("employee_id") %></td>
                                <td><%= resultSet.getString("employee_name") %></td>
                                <td><%= resultSet.getString("employee_dept") %></td>
                                <td><%= resultSet.getString("employee_email") %></td>
                                <td><%= resultSet.getString("employee_phone") %></td>
                                <td><%= resultSet.getString("employee_date_of_joining") %></td>
                                <td>
                                    <!-- Update button -->
                                    <a href="editEmployee.jsp?employeeId=<%= resultSet.getString("employee_id") %>" class="button">Update</a>

                                    <!-- Delete button -->
                                      <!-- Delete button -->
                            <a href="deleteEmployeeServlet?employeeId=<%= resultSet.getString("employee_id") %>" class="button delete" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a> </td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close the resources
                        try {
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
