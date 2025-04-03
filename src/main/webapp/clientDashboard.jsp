<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<title>Client Dashboard</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.profile {
	background: #f5f5f5;
	padding: 20px;
	border-radius: 5px;
	margin-bottom: 20px;
}

table {
	width: 100%;
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

tr:hover {
	background-color: #f5f5f5;
}

.logout {
	color: white;
	background: #f44336;
	padding: 10px 15px;
	text-decoration: none;
	border-radius: 5px;
}
</style>
</head>
<body>
	<div class="header">
		<h1>Client Dashboard</h1>
		<a href="index.jsp" class="logout">Logout</a>
	</div>

	<div class="profile">
		<h2>Your Profile</h2>
		<%
		String email = (String) session.getAttribute("email");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");

			// Get client profile
			String clientSql = "SELECT * FROM client WHERE contact_person_email = ?";
			pstmt = conn.prepareStatement(clientSql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
		%>
	   <p><strong>Client ID:</strong> client-<%=String.format("%03d", rs.getInt("client_id"))%></p>
			<strong>Company Name:</strong>
			<%=rs.getString("client_name")%></p>
		<p>
			<strong>Contact Person Name:</strong>
			<%=rs.getString("contact_person_name")%></p>
		<p>
			<strong>Client Phone:</strong>
			<%=rs.getString("contact_person_phone")%></p>
		<p>
			<strong>Project Start Date:</strong>
			<%=rs.getString("client_relationship_date")%></p>

		<p>
			<strong>Email:</strong>
			<%=email%></p>
		<%
		}
		} catch (Exception e) {
		out.println("<p>Error loading profile: " + e.getMessage() + "</p>");
		} finally {
		try {
		if (rs != null)
			rs.close();
		} catch (Exception e) {
		}
		try {
		if (pstmt != null)
			pstmt.close();
		} catch (Exception e) {
		}
		try {
		if (conn != null)
			conn.close();
		} catch (Exception e) {
		}
		}
		%>
	</div>

	<h2>Your Projects</h2>
	<table>
		<tr>
			<th>Employee ID</th>
			<th>Employee Name</th>
			<th>Project Name</th>
			<th>Start Date</th>
			<th>End Date</th>
			<th>Status</th>
			<th>Description</th>
		</tr>
		<%
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");

			// Get projects for this client
			String projectSql = "SELECT e.employee_id, e.employee_name, " + "p.name, p.start_date, p.end_date, "
			+ "p.status, p.description, p.client_id " + "FROM project p "
			+ "JOIN employee e ON p.employee_id = e.employee_id "
			+ "WHERE p.client_id = (SELECT client_id FROM client WHERE contact_person_email = ?)";
			pstmt = conn.prepareStatement(projectSql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("employee_id")%></td>
			<td><%=rs.getString("employee_name")%></td> 
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getDate("start_date")%></td>
			<td><%=rs.getDate("end_date")%></td>
			<td><%=rs.getString("status")%></td>
			<td><%=rs.getString("description")%></td>
		</tr>
		<%
		}
		} catch (Exception e) {
		out.println("<tr><td colspan='7'>Error loading projects: " + e.getMessage() + "</td></tr>");
		} finally {
		try {
		if (rs != null)
			rs.close();
		} catch (Exception e) {
		}
		try {
		if (pstmt != null)
			pstmt.close();
		} catch (Exception e) {
		}
		try {
		if (conn != null)
			conn.close();
		} catch (Exception e) {
		}
		}
		%>
	</table>
</body>
</html>