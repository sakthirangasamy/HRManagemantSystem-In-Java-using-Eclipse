package com.example.employee.Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.example.employee.Model.Project;

public class ProjectDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "root";

    // Method to establish a database connection
    private Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Method to add a new project
    public boolean addProject(Project project) {
        String sql = "INSERT INTO project (name, start_date, end_date, status, description, client_id, employee_id) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, project.getName());
            stmt.setString(2, project.getStartDate());
            stmt.setString(3, project.getEndDate());
            stmt.setString(4, project.getStatus());
            stmt.setString(5, project.getDescription());
            stmt.setInt(6, project.getClientId());
            stmt.setInt(7, project.getEmployeeId());  // Include employee_id

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get all projects
    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM project";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setName(rs.getString("name"));
                project.setStartDate(rs.getString("start_date"));
                project.setEndDate(rs.getString("end_date"));
                project.setStatus(rs.getString("status"));
                project.setDescription(rs.getString("description"));
                project.setClientId(rs.getInt("client_id"));
                project.setEmployeeId(rs.getInt("employee_id"));  // Fetch employee_id
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    // Method to delete a project by ID
    public boolean deleteProject(int projectId) {
        String sql = "DELETE FROM project WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, projectId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to update a project
    public boolean updateProject(Project project) {
        String sql = "UPDATE project SET name = ?, start_date = ?, end_date = ?, status = ?, description = ?, client_id = ?, employee_id = ? "
                     + "WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, project.getName());
            stmt.setString(2, project.getStartDate());
            stmt.setString(3, project.getEndDate());
            stmt.setString(4, project.getStatus());
            stmt.setString(5, project.getDescription());
            stmt.setInt(6, project.getClientId());
            stmt.setInt(7, project.getEmployeeId());  // Set employee_id
            stmt.setInt(8, project.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get a project by its ID
    public Project getProjectById(int projectId) {
        Project project = null;
        String sql = "SELECT * FROM project WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, projectId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                project = new Project();
                project.setId(rs.getInt("id"));
                project.setName(rs.getString("name"));
                project.setStartDate(rs.getString("start_date"));
                project.setEndDate(rs.getString("end_date"));
                project.setStatus(rs.getString("status"));
                project.setDescription(rs.getString("description"));
                project.setClientId(rs.getInt("client_id"));
                project.setEmployeeId(rs.getInt("employee_id"));  // Fetch employee_id
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return project;
    }
}
