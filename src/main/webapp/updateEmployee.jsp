<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Get updated employee details from the form
    String employeeId = request.getParameter("employeeId");
    String employeeName = request.getParameter("employeeName");
    String employeeDept = request.getParameter("employeeDept");
    String employeeEmail = request.getParameter("employeeEmail");
    String employeePhone = request.getParameter("employeePhone");
    String employeeDOJ = request.getParameter("employeeDOJ");

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
    String dbUser = "root";
    String dbPass = "root";
    Connection connection = null;
    PreparedStatement statement = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // SQL query to update employee details
        String sql = "UPDATE employee SET employee_name = ?, employee_dept = ?, employee_email = ?, employee_phone = ?, employee_date_of_joining = ? WHERE employee_id = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, employeeName);
        statement.setString(2, employeeDept);
        statement.setString(3, employeeEmail);
        statement.setString(4, employeePhone);
        statement.setString(5, employeeDOJ);
        statement.setString(6, employeeId);

        // Execute the update query
        int rowsAffected = statement.executeUpdate();

        if (rowsAffected > 0) {
            // Redirect to employee list page after successful update
            response.sendRedirect("viewEmployees.jsp");
        } else {
            out.println("Failed to update employee.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
