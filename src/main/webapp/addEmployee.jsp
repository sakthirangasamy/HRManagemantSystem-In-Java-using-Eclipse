<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!-- Import List -->
<%@ page import="java.util.ArrayList"%>
<!-- Import ArrayList -->
<%@ page import="com.example.employee.Model.Project"%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Signup</title>
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap"
	rel="stylesheet">
<script type="text/javascript">
        // Check if there's an error or success message set
        <%String error = (String) request.getAttribute("error");
String success = (String) request.getAttribute("success");%>

        <%if (error != null) {%>
            alert("<%=error%>");
        <%} else if (success != null) {%>
            alert("<%=success%>
	");
<%}%>
	
</script>
<style>
/* Apply Public Sans font */
body {
	font-family: 'Public Sans', sans-serif;
	background-color: #f4f4f9;
	margin: 0;
	padding: 0;
}

/* Container to center the form */
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #f4f4f9;
}

/* Form styling */
form {
	background-color: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 500px;
}

/* Header styling */
h1 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

/* Label styling */
label {
	font-size: 16px;
	color: #555;
	margin-bottom: 5px;
	display: block;
}

/* Input field styling */
input[type="text"], input[type="email"], input[type="date"], select {
	width: 100%;
	padding: 12px;
	margin: 8px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

/* Button styling */
button {
	width: 100%;
	padding: 12px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	margin-top: 10px;
}

button:hover {
	background-color: #45a049;
}

/* Responsive styling for smaller screens */
@media ( max-width : 600px) {
	form {
		padding: 20px;
	}
	button {
		font-size: 14px;
	}
}
</style>
</head>
<body>
	<jsp:include page="admininclude.jsp" />
	<div class="container">
		<form action="signupEmployeeServlet" method="POST">
			<h1>Employee Signup Form</h1>

			<label for="employeeName">Employee Name:</label> <input type="text"
				id="employeeName" name="employeeName" required> <label
				for="employeeDept">Employee Department:</label> <input type="text"
				id="employeeDept" name="employeeDept"> <label
				for="employeeEmail">Employee Email:</label> <input type="email"
				id="employeeEmail" name="employeeEmail" required> <label
				for="employeePhone">Employee Phone:</label> <input type="text"
				id="employeePhone" name="employeePhone"> <label
				for="employeeDOJ">Employee Date of Joining:</label> <input
				type="date" id="employeeDOJ" name="employeeDOJ" required> <!-- Project Selection Dropdown -->
       <!-- Project Selection Dropdown -->
        <label for="employeeProject">Employee Project:</label>
        <select id="employeeProject" name="employeeProject" required>
            <option value="">Select Project</option>
            
            <%
                // JDBC connection parameters
                String dbURL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
                String dbUsername = "root";
                String dbPassword = "root";

                // SQL query to get project details
                String sql = "SELECT id, name FROM project";
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Establishing connection to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                    // Executing the query
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    // Loop through the result set and display projects in the dropdown
                    while (rs.next()) {
                        int projectId = rs.getInt("id");
                        String projectName = rs.getString("name");
            %>
                        <option value="<%= projectName %>"><%= projectName %></option>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select><br><br>


			<!-- Bench Select Dropdown -->
			<label for="employeeBench">On Bench:</label> <select
				id="employeeBench" name="employeeBench" required>
				<option value="">Select</option>
				<option value="true">Yes</option>
				<option value="false">No</option>
			</select>
			<button type="submit">Submit</button>
		</form>
	</div>
</body>
</html>
