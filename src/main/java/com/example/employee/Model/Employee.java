package com.example.employee.Model;

public class Employee {
    public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getEmployeeDept() {
		return employeeDept;
	}
	public void setEmployeeDept(String employeeDept) {
		this.employeeDept = employeeDept;
	}
	public String getEmployeeEmail() {
		return employeeEmail;
	}
	public void setEmployeeEmail(String employeeEmail) {
		this.employeeEmail = employeeEmail;
	}
	public String getEmployeePhone() {
		return employeePhone;
	}
	public void setEmployeePhone(String employeePhone) {
		this.employeePhone = employeePhone;
	}
	public String getEmployeeDateOfJoining() {
		return employeeDateOfJoining;
	}
	public void setEmployeeDateOfJoining(String employeeDateOfJoining) {
		this.employeeDateOfJoining = employeeDateOfJoining;
	}
	public String getEmployeeProject() {
		return employeeProject;
	}
	public void setEmployeeProject(String employeeProject) {
		this.employeeProject = employeeProject;
	}
	public boolean isOnBench() {
		return onBench;
	}
	public void setOnBench(boolean onBench) {
		this.onBench = onBench;
	}
	private int employeeId;
    private String employeeName;
    private String employeeDept;
    private String employeeEmail;
    private String employeePhone;
    private String employeeDateOfJoining;
    private String employeeProject;  // New field for project
    private boolean onBench;  
 
}
