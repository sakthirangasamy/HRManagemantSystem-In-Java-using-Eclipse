<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.employee.Model.Employee" %> <!-- Import Employee class -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Employee by Email</title>
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
            margin-top: 10px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 400px;
        }

        .form-container {
            margin-bottom: 20px;
        }

        input[type="text"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
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

        .employee-info {
            margin-top: 30px;
        }

        .employee-info table {
            width: 100%;
            border-collapse: collapse;
        }

        .employee-info th, .employee-info td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .employee-info th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>
    <div class="container">
        <h1>View Employee by Email</h1>

        <!-- Form to enter employee email -->
        <div class="form-container">
            <form action="viewEmployeeByEmail.jsp" method="get">
                <label for="employeeEmail">Enter Employee Email</label>
                <input type="text" id="employeeEmail" name="employeeEmail" placeholder="Enter Employee Email" required />
                <button type="submit" class="button">View Employee</button>
            </form>
        </div>

        <%
            // Get the employeeEmail parameter from the request
            String employeeEmail = request.getParameter("employeeEmail");

            // If employeeEmail is provided, fetch employee details from the database
            Employee employee = null;

            if (employeeEmail != null && !employeeEmail.isEmpty()) {
                // Database connection parameters
                String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
                String dbUser = "root";
                String dbPass = "root";
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;

                try {
                    // Establishing database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    // SQL query to get employee details by employee_email
                    String sql = "SELECT * FROM employee WHERE employee_email = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, employeeEmail); // Search by employee_email
                    resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        // If employee exists, create an Employee object and set its properties
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
            }

            // Display employee details if available
            if (employee != null) {
        %>
        <!-- Display the employee details -->
        <div class="employee-info">
            <h2>Employee Details</h2>
            <table>
                <tr>
                    <th>Employee ID</th>
                    <td><%= employee.getEmployeeId() %></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><%= employee.getEmployeeName() %></td>
                </tr>
                <tr>
                    <th>Department</th>
                    <td><%= employee.getEmployeeDept() %></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= employee.getEmployeeEmail() %></td>
                </tr>
                <tr>
                    <th>Phone</th>
                    <td><%= employee.getEmployeePhone() %></td>
                </tr>
                <tr>
                    <th>Date of Joining</th>
                    <td><%= employee.getEmployeeDateOfJoining() %></td>
                </tr>
            </table>
        </div>
        <% 
            } else {
        %>
        <!-- If no employee found with the given email -->
        <p>Employee not found with email: <%= employeeEmail %></p>
        <% 
            }
        %>
    </div>
</body>
</html>
