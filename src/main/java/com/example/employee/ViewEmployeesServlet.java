package com.example.employee;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.employee.Dao.EmployeeDAO;
import com.example.employee.Model.Employee;

@WebServlet("/viewEmployeesServlet")
public class ViewEmployeesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetching the list of employees from the database
        EmployeeDAO dao = new EmployeeDAO();
        List<Employee> employees = dao.getAllEmployees();

        // Setting the list of employees in the request scope
        request.setAttribute("employees", employees);

        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewEmployees.jsp");
        dispatcher.forward(request, response);
    }
}

