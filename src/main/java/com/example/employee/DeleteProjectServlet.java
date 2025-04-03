package com.example.employee;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.employee.Dao.ProjectDAO;

@WebServlet("/deleteProjectServlet")
public class DeleteProjectServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get project ID from request
        int projectId = Integer.parseInt(request.getParameter("id"));

        // Create ProjectDAO instance to interact with the database
        ProjectDAO projectDAO = new ProjectDAO();
        
        // Delete the project from the database
        boolean success = projectDAO.deleteProject(projectId);

        if (success) {
            request.setAttribute("success", "Project deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete project!");
        }

        // Redirect to the projects list page
        RequestDispatcher rd = request.getRequestDispatcher("viewProjects.jsp");
        rd.forward(request, response);
    }
}
