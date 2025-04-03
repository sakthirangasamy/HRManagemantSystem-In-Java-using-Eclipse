<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.employee.Model.Project" %>
<%@ page import="com.example.employee.Dao.ProjectDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Projects</title>
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
            width: 70%;
            margin-top: 100px;
            border-radius: 8px;
            margin-left: 300px;
        }

        table {
            width: 96%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>

    <div class="container">
        <h1>Projects List</h1>

        <% 
            // Delete project logic
            String deleteId = request.getParameter("deleteId");
            if (deleteId != null && !deleteId.isEmpty()) {
                // Database deletion logic
                int projectIdToDelete = Integer.parseInt(deleteId);
                try {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");
                    String sql = "DELETE FROM project WHERE id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, projectIdToDelete);
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p>Project deleted successfully!</p>");
                    } else {
                        out.println("<p>Error deleting project. Please try again.</p>");
                    }
                    pstmt.close();
                    conn.close();
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
            
            // Fetch all projects from the database
            ProjectDAO projectDAO = new ProjectDAO();
            List<Project> projects = projectDAO.getAllProjects();
        %>

        <table>
            <thead>
                <tr>
                    <th>Project Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Description</th>
                    <th>Client ID</th>
                    <th>Employee ID</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Project project : projects) { %>
                    <tr>
                        <td><%= project.getName() %></td>
                        <td><%= project.getStartDate() %></td>
                        <td><%= project.getEndDate() %></td>
                        <td><%= project.getStatus() %></td>
                        <td><%= project.getDescription() %></td>
                        <td><%= project.getClientId() %></td>
                        <td><%= project.getEmployeeId() %></td>
                        <td class="action-buttons">
                            <a href="editProject.jsp?id=<%= project.getId() %>"><button>Edit</button></a>
                            <!-- Delete Link -->
                            <a href="viewProjects.jsp?deleteId=<%= project.getId() %>"
                               onclick="return confirm('Are you sure you want to delete this project?');">
                               <button>Delete</button>
                            </a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
