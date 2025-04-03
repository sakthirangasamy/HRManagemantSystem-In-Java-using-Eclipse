package com.example.employee;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.employee.Dao.ClientDAO;
import com.example.employee.Model.Client;
@WebServlet("/addClientServlet")
public class AddClientServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String clientName = request.getParameter("clientName");
        String contactPerson = request.getParameter("contactPerson");
        String clientEmail = request.getParameter("clientEmail");
        String clientPhone = request.getParameter("clientPhone");
        String startDate = request.getParameter("startDate");

        // Create Client object with form data
        Client client = new Client(0, clientName, contactPerson, clientEmail, clientPhone, startDate);

        // Call DAO to insert client
        ClientDAO clientDAO = new ClientDAO();
        boolean success = clientDAO.addClient(client);

        // Redirect or show success/failure message
        if (success) {
            response.sendRedirect("addClient.jsp");  // On success, redirect to success page
        } else {
            response.sendRedirect("clientFailure.jsp");  // On failure, redirect to failure page
        }
    }
}
