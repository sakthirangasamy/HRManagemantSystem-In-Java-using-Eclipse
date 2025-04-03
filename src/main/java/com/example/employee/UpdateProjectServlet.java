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

	@WebServlet("/updateProjectServlet")
	public class UpdateProjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("id"));
        String projectName = request.getParameter("name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        int clientId = Integer.parseInt(request.getParameter("client_id"));
        int employeeId = Integer.parseInt(request.getParameter("employee_id"));

        Project project = new Project();
        project.setId(projectId);
        project.setName(projectName);
        project.setStartDate(startDate);
        project.setEndDate(endDate);
        project.setStatus(status);
        project.setDescription(description);
        project.setClientId(clientId);
        project.setEmployeeId(employeeId);

        ProjectDAO projectDAO = new ProjectDAO();
        boolean success = projectDAO.updateProject(project);

        if (success) {
            request.setAttribute("success", "Project updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update project!");
        }

        RequestDispatcher rd = request.getRequestDispatcher("viewProjects.jsp");
        rd.forward(request, response);
    }
}
