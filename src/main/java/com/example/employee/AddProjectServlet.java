package com.example.employee;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.employee.Dao.ProjectDAO;
import com.example.employee.Model.Project;

@WebServlet("/addProjectServlet")
public class AddProjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieving form parameters
        String projectName = request.getParameter("name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        int clientId = Integer.parseInt(request.getParameter("client_id"));
        int employeeId = Integer.parseInt(request.getParameter("employee_id")); // New line to get employee_id

        // Creating a Project object and setting its properties
        Project project = new Project();
        project.setName(projectName);
        project.setStartDate(startDate);
        project.setEndDate(endDate);
        project.setStatus(status);
        project.setDescription(description);
        project.setClientId(clientId);
        project.setEmployeeId(employeeId);  // Setting the employee_id in the Project object

        // Passing the Project object to the DAO for insertion
        ProjectDAO dao = new ProjectDAO();
        boolean success = dao.addProject(project);

        // Setting success or error messages
        if (success) {
            request.setAttribute("success", "Project added successfully!");
        } else {
            request.setAttribute("error", "Failed to add project!");
        }

        // Forwarding to the addProject.jsp page
        RequestDispatcher rd = request.getRequestDispatcher("addProject.jsp");
        rd.forward(request, response);
    }
}
