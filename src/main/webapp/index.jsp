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

        /* Style for the content area */
        .content {
            padding: 20px;
            max-width: 1000px;
            margin: 20px auto;
            height:450px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add shadow around content */
          font-size: 52px; /* Increased font size */
            animation: fadeIn 2s ease-out; /* Adding fade-in animation */
        }

        /* Style for the header */
        h1 {
            font-size: 100px;  /* Increased font size */
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Styling for paragraphs and links */
        p {
            font-size: 20px;  /* Increased font size */
            line-height: 1.6;
            text-align: center;
        }

        a {
            color: #007BFF; /* Bootstrap-like link color */
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Animation for fading in content */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Footer style */
        footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <div class="navbar">
        <a href="admin.jsp">Admin</a>
        <a href="employeeLogin.jsp">Employee</a>
        <a href="clientLogin.jsp">Client</a>
    </div>

    <!-- Content Area -->
    <div class="content">
        <h1>Welcome to Employee Management System</h1>
          </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Employee Management System. All Rights Reserved.</p>
    </footer>

</body>
</html>