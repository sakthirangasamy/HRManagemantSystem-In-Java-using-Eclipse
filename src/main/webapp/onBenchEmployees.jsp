<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.employee.Model.Employee" %> <!-- Import Employee class -->
<%@ page import="java.util.List"%>
<!-- Import List -->
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bench Employees</title>
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Public Sans', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .container {
            margin-left: 400px;
            margin-top: 30px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 700px;
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
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>

    <div class="container">
        <h1>View Employees on Bench</h1>

        <%
            // Fetch all employees who are on the bench from the database
            List<Employee> benchEmployees = new ArrayList<>();
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

                // SQL query to get employees who are on the bench (assuming 'on_bench' column is 0 for false and 1 for true)
                String sql = "SELECT * FROM employee WHERE on_bench = 1";  // Check for on_bench = 1 (true)
                statement = connection.prepareStatement(sql);
                resultSet = statement.executeQuery();

                // Loop through the result set and add employees to the list
                while (resultSet.next()) {
                    Employee employee = new Employee();
                    employee.setEmployeeId(resultSet.getInt("employee_id"));
                    employee.setEmployeeName(resultSet.getString("employee_name"));
                    employee.setEmployeeDept(resultSet.getString("employee_dept"));
                    employee.setEmployeeEmail(resultSet.getString("employee_email"));
                    employee.setEmployeePhone(resultSet.getString("employee_phone"));
                    employee.setEmployeeDateOfJoining(resultSet.getString("employee_date_of_joining"));
                    employee.setOnBench(resultSet.getBoolean("on_bench"));
                    benchEmployees.add(employee);
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

            // If benchEmployees list has data, display it
            if (!benchEmployees.isEmpty()) {
        %>

        <!-- Display the bench employee details -->
        <div class="employee-info">
            <h2>Employees on Bench</h2>
            <table>
                <tr>
                    <th>Employee ID</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Date of Joining</th>
                </tr>

                <% 
                    for (Employee employee : benchEmployees) {
                %>
                    <tr>
                        <td><%= employee.getEmployeeId() %></td>
                        <td><%= employee.getEmployeeName() %></td>
                        <td><%= employee.getEmployeeDept() %></td>
                        <td><%= employee.getEmployeeEmail() %></td>
                        <td><%= employee.getEmployeePhone() %></td>
                        <td><%= employee.getEmployeeDateOfJoining() %></td>
                    </tr>
                <% 
                    }
                %>
            </table>
        </div>

        <% 
            } else {
        %>
        <!-- If no bench employees are found -->
        <p>No employees found on the bench.</p>
        <% 
            }
        %>
    </div>
</body>
</html>
