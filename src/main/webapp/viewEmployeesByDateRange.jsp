<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.employee.Model.Employee" %>
<%@ page import="java.util.List" %>  <!-- Import List -->
<%@ page import="java.util.ArrayList" %>  <!-- Import ArrayList -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Employees by Date Range</title>
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
            margin-top: 10px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 700px;
        }

        input[type="date"] {
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
            width: 50%;
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
        <h1>View Employees by Date Range</h1>

        <!-- Form to input start date and end date -->
        <form action="viewEmployeesByDateRange.jsp" method="get">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required>

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>

            <button type="submit" class="button">View Employees</button>
        </form>

        <%
            // Get startDate and endDate parameters from the request
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            // Fetch employees if dates are provided
            List<Employee> employees = new ArrayList<>();
            
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                // Database connection parameters
                String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
                String dbUser = "root";
                String dbPass = "root";
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;

                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    // SQL query to get employees joined within the date range
                    String sql = "SELECT * FROM employee WHERE employee_date_of_joining BETWEEN ? AND ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, startDate);
                    statement.setString(2, endDate);
                    resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        Employee employee = new Employee();
                        employee.setEmployeeId(resultSet.getInt("employee_id"));
                        employee.setEmployeeName(resultSet.getString("employee_name"));
                        employee.setEmployeeDept(resultSet.getString("employee_dept"));
                        employee.setEmployeeEmail(resultSet.getString("employee_email"));
                        employee.setEmployeePhone(resultSet.getString("employee_phone"));
                        employee.setEmployeeDateOfJoining(resultSet.getString("employee_date_of_joining"));
                        employees.add(employee);
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

            // Display the employees within the date range
            if (!employees.isEmpty()) {
        %>
        <div class="employee-info">
            <h2>Employees Joined Between <%= startDate %> and <%= endDate %></h2>
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
                    for (Employee employee : employees) {
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
        <p>No employees found for the given date range.</p>
        <% 
            }
        %>
    </div>
</body>
</html>
