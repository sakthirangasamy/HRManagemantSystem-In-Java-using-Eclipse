<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.employee.Model.Project" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Project</title>
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
            height: 750px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"], input[type="date"], textarea, select {
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
        <h1>Add Project</h1>

        <script type="text/javascript">
            // Check if there's an error or success message set
            <% String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success"); %>

            <% if (error != null) { %>
                alert("<%= error %>");
            <% } else if (success != null) { %>
                alert("<%= success %>");
            <% } %>
        </script>
        
        <!-- Project Addition Form -->
        <form action="addProjectServlet" method="POST">
            <div class="form-group">
                <label for="name">Project Name:</label>
                <input type="text" id="name" name="name" required />
            </div>

            <div class="form-group">
                <label for="start_date">Start Date:</label>
                <input type="date" id="start_date" name="start_date" required />
            </div>

            <div class="form-group">
                <label for="end_date">End Date:</label>
                <input type="date" id="end_date" name="end_date" required />
            </div>

            <div class="form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="">Select Status</option>
                    <option value="Active">Active</option>
                    <option value="Completed">Completed</option>
                    <option value="On Hold">On Hold</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <!-- Employee Selection -->
            <div class="form-group">
                <label for="employee_id">Employee ID:</label>
                <select id="employee_id" name="employee_id" required>
                    <option value="">Select Employee</option>
                    <%
                        // JDBC connection parameters for Employee
                        String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
                        String dbUsername = "root";
                        String dbPassword = "root";
                        String sql = "SELECT employee_name, employee_id FROM employee";
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Establishing connection to the database
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                            // Executing the query
                            stmt = conn.prepareStatement(sql);
                            rs = stmt.executeQuery();

                            // Loop through the result set and display employees in the dropdown
                            while (rs.next()) {
                                int employeeId = rs.getInt("employee_id");
                                String employeeName = rs.getString("employee_name");
                    %>
                                <option value="<%= employeeId %>"><%= employeeName %> -- <%= employeeId %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select><br><br>
            </div>

            <!-- Client Selection -->
            <div class="form-group">
                <label for="client_id">Client ID:</label>
                <select id="client_id" name="client_id" required>
                    <option value="">Select Client</option>
                    <%
                        // JDBC connection parameters for Client
                        String sqlClient = "SELECT client_id, client_name FROM client";
                        Connection connClient = null;
                        PreparedStatement stmtClient = null;
                        ResultSet rsClient = null;

                        try {
                            // Establishing connection to the database for client
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connClient = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                            // Executing the query
                            stmtClient = connClient.prepareStatement(sqlClient);
                            rsClient = stmtClient.executeQuery();

                            // Loop through the result set and display clients in the dropdown
                            while (rsClient.next()) {
                                int clientId = rsClient.getInt("client_id");
                                String clientName = rsClient.getString("client_name");
                    %>
                                <option value="<%= clientId %>"><%= clientName %> -- <%= clientId %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rsClient != null) rsClient.close();
                                if (stmtClient != null) stmtClient.close();
                                if (connClient != null) connClient.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select><br><br>
            </div>

            <button type="submit">Add Project</button>
        </form>
    </div>
</body>
</html>
