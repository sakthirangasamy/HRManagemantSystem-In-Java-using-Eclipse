<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.example.employee.Model.Project" %> <!-- Import Project class -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Project by ID</title>
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
            margin-top:10px;
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

        .project-info {
            margin-top: 30px;
        }

        .project-info table {
            width: 100%;
            border-collapse: collapse;
        }

        .project-info th, .project-info td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .project-info th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>
    <div class="container">
        <h1>View Project by ID</h1>

        <!-- Form to enter project ID -->
        <div class="form-container">
            <form action="viewProjectDetailsByClient.jsp" method="get">
                <label for="projectId">Enter Project ID</label>
                <input type="text" id="projectId" name="projectId" placeholder="Enter Project ID" required />
                <button type="submit" class="button">View Project</button>
            </form>
        </div>

        <% 
            // Get the projectId parameter from the request
            String projectId = request.getParameter("projectId");

            // If projectId is provided, fetch project details from the database
            Project project = null;
            String clientName = null; // Variable to store client name

            if (projectId != null && !projectId.isEmpty()) {
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

                    // SQL query to get project details by projectId and client name by clientId
                    String sql = "SELECT p.*, c.client_name FROM project p " +
                                 "JOIN client c ON p.client_id = c.client_id " +
                                 "WHERE p.id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, projectId);
                    resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        // If project exists, create a Project object and set its properties
                        project = new Project();
                        project.setId(resultSet.getInt("p.id"));
                        project.setName(resultSet.getString("p.name"));
                        project.setStartDate(resultSet.getString("p.start_date"));
                        project.setEndDate(resultSet.getString("p.end_date"));
                        project.setStatus(resultSet.getString("p.status"));
                        project.setDescription(resultSet.getString("p.description"));
                        project.setClientId(resultSet.getInt("p.client_id"));
                        project.setEmployeeId(resultSet.getInt("p.employee_id"));
                        
                        // Get client name
                        clientName = resultSet.getString("c.client_name");
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

            // Display project details if available
            if (project != null) {
        %>
        <!-- Display the project details -->
        <div class="project-info">
            <h2>Project Details</h2>
            <table>
                <tr>
                    <th>Project ID</th>
                    <td><%= project.getId() %></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><%= project.getName() %></td>
                </tr>
                <tr>
                    <th>Start Date</th>
                    <td><%= project.getStartDate() %></td>
                </tr>
                <tr>
                    <th>End Date</th>
                    <td><%= project.getEndDate() %></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><%= project.getStatus() %></td>
                </tr>
                <tr>
                    <th>Description</th>
                    <td><%= project.getDescription() %></td>
                </tr>
                <tr>
                    <th>Client ID</th>
                    <td><%= project.getClientId() %></td>
                </tr>
                <tr>
                    <th>Client Name</th>
                    <td><%= clientName %></td> <!-- Display Client Name -->
                </tr>
            </table>
        </div>
        <% 
            } else {
        %>
        <!-- If no project found with the given ID -->
        <p>Project not found with ID: <%= projectId %></p>
        <% 
            }
        %>
    </div>
</body>
</html>
