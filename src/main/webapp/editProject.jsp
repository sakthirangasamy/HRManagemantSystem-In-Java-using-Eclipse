<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.employee.Dao.ProjectDAO" %>
<%@ page import="com.example.employee.Model.Project" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.*" %>
<%@ page session="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Project</title>
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
            margin: 0 auto;
            border-radius: 8px;
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
        }

        button:hover {
            background-color: #45a049;
        }

        .error {
            color: red;
        }
    </style>
    <script type="text/javascript">
        // This function is to display the alert based on the request attribute
        function showAlert(message, type) {
            alert(message);
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Edit Project</h1>

        <% 
            // Check for error message or success message
            String errorMessage = (String) request.getAttribute("error");
            String successMessage = (String) request.getAttribute("success");

            // Show alert if there's an error or success message
            if (errorMessage != null) {
        %>
            <script type="text/javascript">
                showAlert("<%= errorMessage %>", "error");
            </script>
        <% 
            } else if (successMessage != null) {
        %>
            <script type="text/javascript">
                showAlert("<%= successMessage %>", "success");
            </script>
        <% 
            }
        %>

        <% 
            int projectId = Integer.parseInt(request.getParameter("id"));
            ProjectDAO projectDAO = new ProjectDAO();
            Project project = projectDAO.getProjectById(projectId);

            if (project == null) {
                response.sendRedirect("viewProjects.jsp");  // Redirect if the project is not found
            }
        %>
<jsp:include page="admininclude.jsp"/>
        <form action="editProject.jsp" method="POST">
            <input type="hidden" name="id" value="<%= project.getId() %>" />

            <div class="form-group">
                <label for="name">Project Name:</label>
                <input type="text" id="name" name="name" value="<%= project.getName() %>" required />
            </div>

            <div class="form-group">
                <label for="start_date">Start Date:</label>
                <input type="date" id="start_date" name="start_date" value="<%= project.getStartDate() %>" required />
            </div>

            <div class="form-group">
                <label for="end_date">End Date:</label>
                <input type="date" id="end_date" name="end_date" value="<%= project.getEndDate() %>" required />
            </div>

            <div class="form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="Active" <%= project.getStatus().equals("Active") ? "selected" : "" %>>Active</option>
                    <option value="Completed" <%= project.getStatus().equals("Completed") ? "selected" : "" %>>Completed</option>
                    <option value="On Hold" <%= project.getStatus().equals("On Hold") ? "selected" : "" %>>On Hold</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required><%= project.getDescription() %></textarea>
            </div>

            <div class="form-group">
                <label for="client_id">Client ID:</label>
                <select id="client_id" name="client_id" required>
                    <% 
                        String sql = "SELECT client_id, client_name FROM client";
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");
                             PreparedStatement stmt = conn.prepareStatement(sql);
                             ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            String selected = rs.getInt("client_id") == project.getClientId() ? "selected" : "";
                    %>
                        <option value="<%= rs.getInt("client_id") %>" <%= selected %>><%= rs.getString("client_name") %></option>
                    <% } } catch (SQLException e) { e.printStackTrace(); } %>
                </select>
            </div>

            <div class="form-group">
                <label for="employee_id">Employee ID:</label>
                <select id="employee_id" name="employee_id" required>
                    <% 
                        String sql2 = "SELECT employee_id, employee_name FROM employee";
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");
                             PreparedStatement stmt = conn.prepareStatement(sql2);
                             ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            String selected = rs.getInt("employee_id") == project.getEmployeeId() ? "selected" : "";
                    %>
                        <option value="<%= rs.getInt("employee_id") %>" <%= selected %>><%= rs.getString("employee_name") %></option>
                    <% } } catch (SQLException e) { e.printStackTrace(); } %>
                </select>
            </div>

            <button type="submit">Update Project</button>
        </form>

        <% 
            // Check if form was submitted
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Retrieve the updated project data from the form
                projectId = Integer.parseInt(request.getParameter("id"));
                String updatedName = request.getParameter("name");
                String updatedStartDate = request.getParameter("start_date");
                String updatedEndDate = request.getParameter("end_date");
                String updatedStatus = request.getParameter("status");
                String updatedDescription = request.getParameter("description");
                int updatedClientId = Integer.parseInt(request.getParameter("client_id"));
                int updatedEmployeeId = Integer.parseInt(request.getParameter("employee_id"));

                // Create the updated project object
                Project updatedProject = new Project();
                updatedProject.setId(projectId);
                updatedProject.setName(updatedName);
                updatedProject.setStartDate(updatedStartDate);
                updatedProject.setEndDate(updatedEndDate);
                updatedProject.setStatus(updatedStatus);
                updatedProject.setDescription(updatedDescription);
                updatedProject.setClientId(updatedClientId);
                updatedProject.setEmployeeId(updatedEmployeeId);

                // Attempt to update the project in the database
                ProjectDAO dao = new ProjectDAO();
                boolean success = dao.updateProject(updatedProject);

                if (success) {
                    // Set success message and redirect
                    request.setAttribute("success", "Project updated successfully!");
                    response.sendRedirect("viewProjects.jsp");
                } else {
                    // Show error if update failed
                    request.setAttribute("error", "Error updating project.");
                    request.getRequestDispatcher("updateProject.jsp?id=" + projectId).forward(request, response);
                }
            }
        %>
    </div>
</body>
</html>
