The HR Management System allows the admin to manage employees, projects, and clients. Additionally, it provides employee and client login functionalities using OTP-based authentication. The system includes various features like onboarding, releasing employees from projects, and managing the status of employees (e.g., on the bench, assigned to a project).

1. Employee Management
Employee Details: Each employee has details such as employee-id, name, department, email (which must be unique), phone number, date-of-joining, and an associated project-id.

Employee Operations: The admin can:

Add new employees.

View all employees.

View an employee by their employee-id or email.

View employees based on a specific date range of joining.

Update employee data (excluding employee-id and email).

Delete an employee.

Project Assignment: Each employee can be assigned to only one project at a time. The admin can onboard employees to projects, release employees from a project, and view project details associated with an employee.

Bench Employees: The admin can view all employees who are "on the bench" (i.e., not assigned to any project).

2. Project Management
Project Details: Each project has details such as project-id, project-name, start-date, end-date, and associated client-id.

Project Operations: The admin can:

Add new projects.

View all projects.

View project details by project-id.

View client details related to the project.

View employees associated with the project.

Update project details (excluding the project-id).

Delete a project.

Employee-Project Relationship: Employees are linked to projects via project-id. The admin can manage this relationship by onboarding or releasing employees from a project.

3. Client Management
Client Details: Each client has details such as client-id, client-name, contact-person-name, contact-person-email, contact-person-phone, contact-person-designation, and relationship-date.

Client Operations: The admin can:

Add new clients.

View all clients.

View projects associated with a client.

Update client information.

Delete a client.

4. Authentication (Login)
Employee Login: Employees can log in using their email. An OTP (One-Time Password) is sent to their email address. The employee must enter the OTP to gain access to the system. The system allows only five unsuccessful login attempts before locking the account for 5 minutes.

Client Login: Clients log in using their email address. Like employees, clients also receive an OTP for authentication, and they have a limit of 5 failed login attempts before their account is locked for 5 minutes.

Security Measures: After 5 unsuccessful login attempts, the user’s account (either employee or client) is locked for 5 minutes, ensuring security and preventing brute force attacks.

5. Admin Module
The admin has the following responsibilities:

Login: Admins can log in with a specific user-id and password.

Employee Management: Admin can add, update, view, and delete employees, as well as onboard or release employees from projects.

Project Management: Admin can add, view, update, and delete projects, and manage the project assignments of employees.

Client Management: Admin can add, view, update, and delete clients, and manage client-project associations.

6. Features Breakdown
Employee:

Login with OTP verification.

View personal details and project assignments.

Employee can only have one project at a time (either on the bench or assigned to a project).

View project-specific employee details (if assigned to a project).

Client:

Login with OTP verification.

View client details, project details, and project-specific employee details.

OTP System:

An OTP is generated when an employee or client tries to log in. It is sent to their email, and they must enter it within a specified time frame (e.g., 5 minutes) to gain access.

If an incorrect OTP is entered, it counts as a failed attempt. After 5 failed attempts, the account is locked for 5 minutes.

7. Admin Permissions:
The admin can perform several actions:

Add new employees, projects, and clients.

View and manage employee, project, and client records.

Update or delete existing records.

Assign or remove employees from projects.

View employees on the bench.

The admin is the central authority for managing the HR, project, and client data, as well as user authentication.

Application Flow
Login Process:

Employee/Client enters their email.

System sends an OTP to their email.

The user enters the OTP to log in.

After successful login, the user is directed to their respective dashboard (Employee Dashboard or Client Dashboard).

Admin Dashboard:

Admin can view a list of employees, projects, and clients.

Admin can add new entries, update existing ones, or delete records.

Admin can manage employee assignments to projects and release employees from projects.

Employee Dashboard:

Employees can view their personal details, department, project assignments, and more.

Client Dashboard:

Clients can view project details and employee assignments related to their projects.

Use Case Scenarios
Admin Adds an Employee: Admin logs into the admin module and uses the employee management section to input new employee details. The employee is then added to the database.

Admin Assigns an Employee to a Project: The admin selects an employee and a project and assigns the employee to the project by updating their project ID in the database.

Employee Views Their Project: An employee logs in using OTP, and the dashboard displays their project details.

Client Views Employees in a Project: A client logs in and views all employees associated with a specific project.

Employee Login with OTP: An employee enters their email, receives an OTP, and logs into the system. If they fail to log in 5 times, their account is locked for 5 minutes.

Admin Deletes a Project: The admin selects a project to delete. If the project is linked to employees, the admin must first release the employees from the project.

Technology Stack
Java (JSP/Servlets): Used for handling the logic, user authentication, and interaction with the database.

JDBC: Used to connect and interact with the MySQL database to fetch and store data.

MySQL: Database for storing employee, project, and client information.

HTML/CSS/JavaScript: For the frontend interface (form submission, validation, etc.).

Tomcat: Web server for deploying the Java-based web application.

