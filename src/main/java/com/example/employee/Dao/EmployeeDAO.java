package com.example.employee.Dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.employee.Model.Employee;

public class EmployeeDAO {
    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/employeemanagementsystem";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "root";

    // Method to establish a database connection
    private Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Method to add a new employee
    public boolean addEmployee(Employee employee) {
        String sql = "INSERT INTO employee (employee_name, employee_dept, employee_email, employee_phone, employee_date_of_joining, employee_project, on_bench) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, employee.getEmployeeName());
            stmt.setString(2, employee.getEmployeeDept());
            stmt.setString(3, employee.getEmployeeEmail());
            stmt.setString(4, employee.getEmployeePhone());
            stmt.setDate(5, Date.valueOf(employee.getEmployeeDateOfJoining())); // Assuming Date is in 'yyyy-MM-dd' format
            stmt.setString(6, employee.getEmployeeProject());  // Add project
            stmt.setBoolean(7, employee.isOnBench());          // Add bench status

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to fetch all employees
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM employee");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Employee employee = new Employee();
                employee.setEmployeeId(rs.getInt("employee_id"));
                employee.setEmployeeName(rs.getString("employee_name"));
                employee.setEmployeeDept(rs.getString("employee_dept"));
                employee.setEmployeeEmail(rs.getString("employee_email"));
                employee.setEmployeePhone(rs.getString("employee_phone"));
                employee.setEmployeeDateOfJoining(rs.getString("employee_date_of_joining"));
                employee.setEmployeeProject(rs.getString("employee_project"));  // Fetch project
                employee.setOnBench(rs.getBoolean("on_bench"));                  // Fetch bench status
                employees.add(employee);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    // Method to delete an employee by ID
    public boolean deleteEmployee(int employeeId) {
        String sql = "DELETE FROM employee WHERE employee_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, employeeId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to update an employee
    public boolean updateEmployee(Employee employee) {
        String sql = "UPDATE employee SET employee_name = ?, employee_dept = ?, employee_email = ?, employee_phone = ?, employee_date_of_joining = ?, employee_project = ?, on_bench = ? WHERE employee_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, employee.getEmployeeName());
            stmt.setString(2, employee.getEmployeeDept());
            stmt.setString(3, employee.getEmployeeEmail());
            stmt.setString(4, employee.getEmployeePhone());
            stmt.setDate(5, Date.valueOf(employee.getEmployeeDateOfJoining())); // Assuming Date is in 'yyyy-MM-dd' format
            stmt.setString(6, employee.getEmployeeProject());  // Update project
            stmt.setBoolean(7, employee.isOnBench());          // Update bench status
            stmt.setInt(8, employee.getEmployeeId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
