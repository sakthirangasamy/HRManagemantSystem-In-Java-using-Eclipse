<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Clients</title>
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Public Sans', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f9;
}

.container {
	margin: 50px auto 0px 225px;
	padding: 30px;
	background-color: #fff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	width: 105%;
}

h1 {
	text-align: center;
}

table {
	width: 77%;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #ddd;
}

th, td {
	padding: 12px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.btn {
	padding: 8px 12px;
	margin: 5px;
	text-decoration: none;
	color: white;
	border-radius: 5px;
}

.btn-update {
	background-color: #4CAF50;
}

.btn-delete {
	background-color: #f44336;
}
th:nth-child(7) {
	max-width: 200px;
}
</style>
</head>
<body>
	<jsp:include page="admininclude.jsp" />

	<div class="container">
		<h1>View Clients</h1>

		<%
		// Database connection parameters
		String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
		String dbUser = "root";
		String dbPass = "root";
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			// Establish database connection
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

			// SQL query to get all clients
			String sql = "SELECT * FROM client";
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			// Check if there are any clients
			if (resultSet != null) {
		%>
		<table>
			<thead>
				<tr>
					<th>Client ID</th>
					<th>Client Name</th>
					<th>Contact Person</th>
					<th style="min-width:50px;">Email</th>
					<th>Phone</th>
					<th>Client Date</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				// Loop through the result set and display each client in the table
				while (resultSet.next()) {
					// Get client_id from result set
					int clientId = resultSet.getInt("client_id");

					// Format client_id as client-001, client-002, etc.
					String formattedClientId = String.format("client-%03d", clientId);
				%>
				<tr>
					<td><%= formattedClientId %></td> <!-- Display formatted client ID -->
					<td><%= resultSet.getString("client_name") %></td>
					<td><%= resultSet.getString("contact_person_name") %></td>
					<td><%= resultSet.getString("contact_person_email") %></td>
					<td><%= resultSet.getString("contact_person_phone") %></td>
					<td><%= resultSet.getString("client_relationship_date") %></td>
					<td>
						<!-- Update and Delete buttons -->
						<a href="updateClient.jsp?clientId=<%= resultSet.getInt("client_id") %>"
						   class="btn btn-update">Update</a> 
						<a href="viewClients.jsp?deleteClientId=<%= resultSet.getInt("client_id") %>"
						   class="btn btn-delete"
						   onclick="return confirm('Are you sure you want to delete this client?');">Delete</a>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} else {
		%>
		<p>No clients found.</p>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		// Close resources
		try {
		if (resultSet != null)
			resultSet.close();
		if (statement != null)
			statement.close();
		if (connection != null)
			connection.close();
		} catch (Exception e) {
		e.printStackTrace();
		}

		// Check if a delete action is requested
		String deleteClientId = request.getParameter("deleteClientId");
		if (deleteClientId != null) {
		try {
		// Delete client from the database
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

		String deleteSql = "DELETE FROM client WHERE client_id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(deleteSql);
		preparedStatement.setInt(1, Integer.parseInt(deleteClientId));
		int rowsAffected = preparedStatement.executeUpdate();

		if (rowsAffected > 0) {
			out.println("<script>alert('Client deleted successfully!'); window.location='viewClients.jsp';</script>");
		}
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		try {
			if (connection != null)
				connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		}
		}
		}
		%>
	</div>
</body>
</html>
