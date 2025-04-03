package com.example.employee.Dao;

import com.example.employee.Model.Client;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ClientDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";

    public boolean addClient(Client client) {
        boolean success = false;
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // SQL query to insert client into the database
            String sql = "INSERT INTO client (client_name, contact_person_name, contact_person_email, contact_person_phone, client_relationship_date) VALUES (?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);

            // Set parameters for the query
            statement.setString(1, client.getClientName());
            statement.setString(2, client.getContactPerson());
            statement.setString(3, client.getClientEmail());
            statement.setString(4, client.getClientPhone());
            statement.setString(5, client.getStartDate());

            // Execute the query and check if it was successful
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return success;
    }
}
