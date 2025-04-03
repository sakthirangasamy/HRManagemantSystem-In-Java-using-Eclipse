<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
    <!-- Link to Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    
    <title>Employee Management System</title>
    
    <!-- Link to Google Fonts (Public Sans) -->
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">

    <style>
        /* Basic styling for the body */
        body {
            font-family: 'Public Sans', sans-serif; /* Apply Public Sans font */
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        /* Sidebar container */
        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #333;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 20px;
            box-shadow: 4px 0 8px rgba(0, 0, 0, 0.1);
        }

        /* Sidebar links */
        .sidebar a {
            display: flex;
            align-items: center;
            color: white;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 12.8px;
            text-align: left;
            font-family: 'Public Sans', sans-serif; /* Use Public Sans for the links */
            transition: background-color 0.3s ease;
        }

        /* Sidebar icons */
        .sidebar a i {
            margin-right: 10px;
        }

        /* Hover effect for sidebar links */
        .sidebar a:hover {
            background-color: #444;
            color: #ffcc00;
        }

    

        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
            }

            .dashboard-card {
                width: 90%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Sidebar (Navigation) -->
    <div class="sidebar">
       
        <!-- Employee management links -->
        <a href="addEmployee.jsp"><i class="fas fa-user-plus"></i> Add Employee</a>
        <a href="viewEmployees.jsp"><i class="fas fa-users"></i> View All Employees</a>
        <a href="viewEmployeeById.jsp"><i class="fas fa-id-card"></i> View Employee by ID</a>
        <a href="viewEmployeeByEmail.jsp"><i class="fas fa-envelope"></i> View Employee by Email</a>
        <a href="viewEmployeesByDateRange.jsp"><i class="fas fa-calendar-alt"></i> View Employees by Date Range</a>
        <a href="onBenchEmployees.jsp"><i class="fas fa-briefcase"></i> On Bench Employees</a>
       
        <!-- Project management links -->
        <a href="addProject.jsp"><i class="fas fa-project-diagram"></i> Add Project</a>
        <a href="viewProjects.jsp"><i class="fas fa-eye"></i> View All Projects</a>
        <a href="viewProjectById.jsp"><i class="fas fa-search"></i> View Project by ID</a>
        <a href="viewProjectDetailsByClient.jsp"><i class="fas fa-building"></i> Client Info by Project</a>
       
        <!-- Client management links -->
        <a href="addClient.jsp"><i class="fas fa-building"></i> Add Client</a>
        <a href="viewClients.jsp"><i class="fas fa-users"></i> View All Clients</a>
        <a href="viewClientById.jsp"><i class="fas fa-id-card"></i> View Client by ID</a>
       
        <div class="navbar-right">
            <a href="index.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>



</body>
</html>
