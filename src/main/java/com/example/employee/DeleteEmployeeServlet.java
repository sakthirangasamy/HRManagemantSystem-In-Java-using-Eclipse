package com.example.employee;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.employee.Dao.EmployeeDAO;

@WebServlet("/deleteEmployeeServlet")
public class DeleteEmployeeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        EmployeeDAO dao = new EmployeeDAO();

        boolean success = dao.deleteEmployee(employeeId);
        if (success) {
            response.sendRedirect("viewEmployees.jsp");  // Redirect to view employees page after successful deletion
        } else {
            request.setAttribute("error", "Failed to delete employee.");
            RequestDispatcher rd = request.getRequestDispatcher("viewEmployees.jsp");
            rd.forward(request, response);
        }
    }
}
