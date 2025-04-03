
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.example.employee.Model.Client"%>
<!-- Import Client class -->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Client by ID</title>
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
	margin-left: 500px;
	margin-top: 10px;
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

.client-info {
	margin-top: 30px;
}

.client-info table {
	width: 100%;
	border-collapse: collapse;
}

.client-info th, .client-info td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.client-info th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<jsp:include page="admininclude.jsp" />
	<div class="container">
		<h1>View Client by ID</h1>

		<!-- Form to enter client ID -->
		<div class="form-container">
			<form action="viewClientById.jsp" method="get">
				<label for="clientId">Enter Client ID</label> <input type="text"
					id="clientId" name="clientId" placeholder="Enter Client ID"
					required />
				<button type="submit" class="button">View Client</button>
			</form>
		</div>

		<%
		// Get the clientId parameter from the request
		String clientId = request.getParameter("clientId");

		// If clientId is provided, fetch client details from the database
		Client client = null;

		if (clientId != null && !clientId.isEmpty()) {
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

				// SQL query to get client details by clientId
				String sql = "SELECT * FROM client WHERE client_id = ?";
				statement = connection.prepareStatement(sql);
				statement.setString(1, clientId);
				resultSet = statement.executeQuery();

				if (resultSet.next()) {
			// If client exists, create a Client object and set its properties
			client = new Client(resultSet.getInt("client_id"), resultSet.getString("client_name"),
					resultSet.getString("contact_person_name"), resultSet.getString("contact_person_email"),
					resultSet.getString("contact_person_phone"), resultSet.getString("client_relationship_date"));
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
				} catch (SQLException e) {
			e.printStackTrace();
				}
			}
		}

		// Display client details if available
		if (client != null) {
		%>
		<!-- Display the client details -->
		<div class="client-info">
			<h2>Client Details</h2>
			<table>
				<tr>
					<th>Client ID</th>
					<td><%=client.getClientId()%></td>
				</tr>
				<tr>
					<th>Client Name</th>
					<td><%=client.getClientName()%></td>
				</tr>
				<tr>
					<th>Contact Person</th>
					<td><%=client.getContactPerson()%></td>
				</tr>
				<tr>
					<th>Email</th>
					<td><%=client.getClientEmail()%></td>
				</tr>
				<tr>
					<th>Phone</th>
					<td><%=client.getClientPhone()%></td>
				</tr>
				<tr>
					<th>Start Date</th>
					<td><%=client.getStartDate()%></td>
				</tr>
			</table>
		</div>
		<%
		} else {
		%>
		<!-- If no client found with the given ID -->
		<p>
			Client not found with ID:
			<%=clientId%></p>
		<%
		}
		%>
	</div>
</body>
</html>
