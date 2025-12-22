package com.tour.model;

public class User {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private String role; // ADMIN hoặc CUSTOMER

    public User() {}

    public User(int id, String username, String password, String fullName, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
    }

    // Getters và Setters
    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getFullName() { return fullName; }
    public String getRole() { return role; }
    
    public void setRole(String role) { this.role = role; }
}