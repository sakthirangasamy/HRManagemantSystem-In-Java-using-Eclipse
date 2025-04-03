package com.example.employee;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.employee.Dao.EmployeeDAO;
import com.example.employee.Dao.ProjectDAO;
import com.example.employee.Model.Employee;
import com.example.employee.Model.Project;
@WebServlet("/signupEmployeeServlet")
public class SignupEmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get employee details from the form
        String employeeName = request.getParameter("employeeName");
        String employeeDept = request.getParameter("employeeDept");
        String employeeEmail = request.getParameter("employeeEmail");
        String employeePhone = request.getParameter("employeePhone");
        String employeeDOJ = request.getParameter("employeeDOJ");

        // Get the project ID and bench status from the form
        String employeeProject = request.getParameter("employeeProject");
        boolean onBench = Boolean.parseBoolean(request.getParameter("employeeBench"));

        // Validation for unique email
        if (!isEmailUnique(employeeEmail)) {
            request.setAttribute("error", "Email already exists!");
            RequestDispatcher rd = request.getRequestDispatcher("addEmployee.jsp");
            rd.forward(request, response);
            return;
        }

        // Add employee to the database
        Employee employee = new Employee();
        employee.setEmployeeName(employeeName);
        employee.setEmployeeDept(employeeDept);
        employee.setEmployeeEmail(employeeEmail);
        employee.setEmployeePhone(employeePhone);
        employee.setEmployeeDateOfJoining(employeeDOJ);
        employee.setEmployeeProject(employeeProject);  // Set the project
        employee.setOnBench(onBench);  // Set the bench status

        EmployeeDAO dao = new EmployeeDAO();
        boolean success = dao.addEmployee(employee);

        // Fetch projects and set it to request
        ProjectDAO projectDAO = new ProjectDAO();
        List<Project> projects = projectDAO.getAllProjects();
        request.setAttribute("projects", projects);  // Pass the list of projects to the JSP

        // Redirect with success or error message
        if (success) {
            request.setAttribute("success", "Employee added successfully!");
        } else {
            request.setAttribute("error", "Failed to add employee!");
        }

        RequestDispatcher rd = request.getRequestDispatcher("addEmployee.jsp");
        rd.forward(request, response);
    }

    private boolean isEmailUnique(String email) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeemanagementsystem", "root", "root");
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM Employee WHERE employee_email = ?")) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) == 0;  // If count is 0, email is unique
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
