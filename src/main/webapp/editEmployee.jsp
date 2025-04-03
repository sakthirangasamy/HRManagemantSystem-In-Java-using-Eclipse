<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.example.employee.Model.Employee" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee</title>
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Public Sans', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .container {
            margin-left: 500px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 500px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .button:hover {
            background-color: #45a049;
        }

        .button.cancel {
            background-color: #f44336;
            text-align: center;
        }

        .button.cancel:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>
    <div class="container">
        <h1>Edit Employee</h1>

        <%
            // Get the employeeId parameter from the URL
            String employeeId = request.getParameter("employeeId");

            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
            String dbUser = "root";
            String dbPass = "root";
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            Employee employee = null;

            try {
                // Establishing database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                // SQL query to get employee details by employeeId
                String sql = "SELECT * FROM employee WHERE employee_id = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, employeeId);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    employee = new Employee();
                    employee.setEmployeeId(resultSet.getInt("employee_id"));
                    employee.setEmployeeName(resultSet.getString("employee_name"));
                    employee.setEmployeeDept(resultSet.getString("employee_dept"));
                    employee.setEmployeeEmail(resultSet.getString("employee_email"));
                    employee.setEmployeePhone(resultSet.getString("employee_phone"));
                    employee.setEmployeeDateOfJoining(resultSet.getString("employee_date_of_joining"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <% if (employee != null) { %>
            <!-- Edit employee form -->
            <form action="updateEmployee.jsp" method="post">
                <input type="hidden" name="employeeId" value="<%= employee.getEmployeeId() %>" />

                <label for="employeeName">Employee Name</label>
                <input type="text" id="employeeName" name="employeeName" value="<%= employee.getEmployeeName() %>" required />

                <label for="employeeDept">Department</label>
                <input type="text" id="employeeDept" name="employeeDept" value="<%= employee.getEmployeeDept() %>" required />

                <label for="employeeEmail">Email</label>
                <input type="email" id="employeeEmail" name="employeeEmail" value="<%= employee.getEmployeeEmail() %>" required />

                <label for="employeePhone">Phone</label>
                <input type="tel" id="employeePhone" name="employeePhone" value="<%= employee.getEmployeePhone() %>" required />

                <label for="employeeDOJ">Date of Joining</label>
                <input type="date" id="employeeDOJ" name="employeeDOJ" value="<%= employee.getEmployeeDateOfJoining() %>" required />

                <button type="submit" class="button">Update</button><br>
                <a href="viewEmployees.jsp" class="button cancel">Cancel</a>
            </form>
        <% } else { %>
            <p>Employee not found.</p>
        <% } %>

    </div>
</body>
</html>
