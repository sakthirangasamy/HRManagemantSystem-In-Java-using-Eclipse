<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Client</title>
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Public Sans', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .container {
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 50%;
        }

        h1 {
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input[type="text"], input[type="email"], input[type="tel"], input[type="date"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
        }

        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<jsp:include page="admininclude.jsp"/>

    <div class="container">
        <h1>Update Client</h1>

        <% 
            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
            String dbUser = "root";
            String dbPass = "root";
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            String clientId = request.getParameter("clientId"); // Get client ID from the request

            if (clientId != null) {
                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    // SQL query to get client details by client ID
                    String sql = "SELECT * FROM client WHERE client_id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, Integer.parseInt(clientId)); // Set client ID in the query
                    resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        // Retrieve client data from result set
                        String clientName = resultSet.getString("client_name");
                        String contactPersonName = resultSet.getString("contact_person_name");
                        String contactPersonEmail = resultSet.getString("contact_person_email");
                        String contactPersonPhone = resultSet.getString("contact_person_phone");
                        String startDate = resultSet.getString("client_relationship_date");

        %>
        <!-- Update form -->
        <form action="updateClient.jsp" method="post">
            <input type="hidden" name="clientId" value="<%= clientId %>"> <!-- Hidden field for clientId -->
            <label for="clientName">Client Name</label>
            <input type="text" id="clientName" name="clientName" value="<%= clientName %>" required />

            <label for="contactPersonName">Contact Person Name</label>
            <input type="text" id="contactPersonName" name="contactPersonName" value="<%= contactPersonName %>" required />

            <label for="contactPersonEmail">Contact Person Email</label>
            <input type="email" id="contactPersonEmail" name="contactPersonEmail" value="<%= contactPersonEmail %>" required />

            <label for="contactPersonPhone">Contact Person Phone</label>
            <input type="tel" id="contactPersonPhone" name="contactPersonPhone" value="<%= contactPersonPhone %>" required />

            <label for="startDate">Start Date</label>
            <input type="date" id="startDate" name="startDate" value="<%= startDate %>" required />

            <button type="submit" class="btn">Update Client</button>
        </form>
        <% 
                    } else {
                        out.println("<p>Client not found.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }

            // Handle form submission to update the client
            String updatedClientId = request.getParameter("clientId");
            if (updatedClientId != null) {
                // Retrieve updated values from the form
                String updatedClientName = request.getParameter("clientName");
                String updatedContactPersonName = request.getParameter("contactPersonName");
                String updatedContactPersonEmail = request.getParameter("contactPersonEmail");
                String updatedContactPersonPhone = request.getParameter("contactPersonPhone");
                String updatedStartDate = request.getParameter("startDate");

                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    // SQL query to update client data
                    String updateSql = "UPDATE client SET client_name = ?, contact_person_name = ?, contact_person_email = ?, contact_person_phone = ?, client_relationship_date = ? WHERE client_id = ?";
                    statement = connection.prepareStatement(updateSql);
                    statement.setString(1, updatedClientName);
                    statement.setString(2, updatedContactPersonName);
                    statement.setString(3, updatedContactPersonEmail);
                    statement.setString(4, updatedContactPersonPhone);
                    statement.setString(5, updatedStartDate);
                    statement.setInt(6, Integer.parseInt(updatedClientId));

                    int rowsAffected = statement.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<script>alert('Client updated successfully!'); window.location='viewClients.jsp';</script>");
                    } else {
                        out.println("<script>alert('Failed to update client.'); window.location='viewClients.jsp';</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
