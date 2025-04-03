<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f5f5f5; }
        .header { background: #4CAF50; color: white; padding: 15px; display: flex; 
                justify-content: space-between; align-items: center; }
        .container { max-width: 1200px; margin: 20px auto; padding: 20px; background: white; 
                   border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .logout { color: white; text-decoration: none; }
    </style>
</head>
<body>
    <div class="header">
        <h2>Employee Dashboard</h2>
        <a href="index.jsp" class="logout">Logout</a>
    </div>
    
    <div class="container">
        <h3>Your Profile</h3>
        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Integer employeeId = (Integer) session.getAttribute("employeeId");
            if (employeeId == null) {
                response.sendRedirect("employeeLogin.jsp");
                return;
            }
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");
            
            // Get employee details
            String sql = "SELECT * FROM employee WHERE employee_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, employeeId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
        %>
                <table>
                    <tr>
                        <th>Employee ID</th>
                        <td><%= "EMP-" + String.format("%03d", rs.getInt("employee_id")) %></td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td><%= rs.getString("employee_name") %></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%= rs.getString("employee_email") %></td>
                    </tr>
                     <tr>
                        <th>Phone</th>
                        <td><%= rs.getString("employee_phone") %></td>
                    </tr>
                    <tr>
                        <th>Department</th>
                        <td><%= rs.getString("employee_dept") %></td>
                    </tr>
                    <tr>
                        <th>Date Of Joining</th>
                        <td><%= rs.getString("employee_date_of_joining") %></td>
                    </tr>
                </table>
        <%
            }
            
            // Get employee projects
            sql = "SELECT p.id, p.name, p.start_date, p.end_date, " +
                  "p.status, c.client_name FROM project p " +
                  "JOIN client c ON p.client_id = c.client_id " +
                  "WHERE p.employee_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, employeeId);
            rs = pstmt.executeQuery();
        %>
            <h3 style="margin-top: 30px;">Your Projects</h3>
            <table>
                <tr>
                    <th>Project ID</th>
                    <th>Project Name</th>
                    <th>Client</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                </tr>
        <%
            while (rs.next()) {
        %>
                <tr>
                    <td><%= "PROJ-" + String.format("%03d", rs.getInt("id")) %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("client_name") %></td>
                    <td><%= rs.getDate("start_date") %></td>
                    <td><%= rs.getDate("end_date") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
        <%
            }
        %>
            </table>
        <%
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        %>
    </div>
</body>
</html>