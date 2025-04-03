<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <style>
        /* Basic styling for the body */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;  /* Light gray background */
        }

        /* Navbar container */
        .navbar {
            background-color: #333;
            overflow: hidden;
            position: sticky;
            top: 0;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add subtle shadow */
        }

        /* Navbar links */
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 18px;
        }

        /* Hover effect for navbar links */
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }

 
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <div class="navbar">
        <a href="admin.jsp">Admin</a>
        <a href="/employee">Employee</a>
        <a href="/client">Client</a>
    </div>

   
</body>
</html>