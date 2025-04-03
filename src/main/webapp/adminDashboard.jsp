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

    <!-- Chart.js Library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* Content area */
        .content {
            margin-left: 270px;
            padding: 10px;
            background-color: #f9f9f9;
            min-height: 10px;
        }

        /* Dashboard container for cards */
        .container {
            display: flex;
            justify-content: space-between;
            padding: 30px;
            gap: 30px;
            flex-wrap: wrap;
        }

        /* Individual dashboard cards */
        .dashboard-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 10px;
            text-align: center;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            width: 250px;
            height: 100px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* Dashboard card hover effect */
        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: 0px 6px 30px rgba(0, 0, 0, 0.2);
        }

        /* Icon styling */
        .dashboard-card i {
            font-size: 25px;
            color: #444;
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

        /* Chart Styling */
        .chart-container {
            width: 100%;
            max-width: 800px;
            margin: 50px auto;
        }

        canvas {
            width: 100% !important;
            height: 400px !important;
        }
    </style>
</head>
<body>

    <jsp:include page="admininclude.jsp" />
    
    <!-- Content Section -->
    <div class="content">
        <!-- Dashboard Cards Section -->
        <div class="container">
            <%-- Database Connection and Query Execution --%>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                int employeeCount = 0;
                int projectCount = 0;
                int clientCount = 0;

                try {
                    // Establish connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");

                    // Employee count query
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT COUNT(*) FROM employee");
                    if (rs.next()) {
                        employeeCount = rs.getInt(1);
                    }

                    // Project count query
                    rs = stmt.executeQuery("SELECT COUNT(*) FROM project");
                    if (rs.next()) {
                        projectCount = rs.getInt(1);
                    }

                    // Client count query
                    rs = stmt.executeQuery("SELECT COUNT(*) FROM client");
                    if (rs.next()) {
                        clientCount = rs.getInt(1);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>

            <div class="dashboard-card">
                <i class="fas fa-users"></i>
                <p>Total Employees</p>
                <h3><%= employeeCount %></h3>
            </div>
            <div class="dashboard-card">
                <i class="fas fa-project-diagram"></i>
                <p>Total Projects</p>
                <h3><%= projectCount %></h3>
            </div>
            <div class="dashboard-card">
                <i class="fas fa-building"></i>
                <p>Total Clients</p>
                <h3><%= clientCount %></h3>
            </div>
        </div>

        <!-- Bar Chart Section -->
        <div class="chart-container">
            <canvas id="dashboardChart"></canvas>
        </div>

        <script>
            // Bar chart for Employee, Project, and Client counts
            var ctx = document.getElementById('dashboardChart').getContext('2d');
            var dashboardChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Employees', 'Projects', 'Clients'],
                    datasets: [{
                        label: 'Total Count',
                        data: [<%= employeeCount %>, <%= projectCount %>, <%= clientCount %>],
                        backgroundColor: ['#4CAF50', '#2196F3', '#FF9800'],
                        borderColor: ['#388E3C', '#1976D2', '#F57C00'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        </script>
    </div>

</body>
</html>
