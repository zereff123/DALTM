package com.tour.model;

import java.sql.Timestamp; // Dùng Timestamp để lưu cả ngày và giờ

public class Tour {
    private int id;
    private String name;
    private double price;
    private int maxCapacity;
    private int currentCapacity;
    // Các trường mới thêm
    private String location;
    private String description;
    private Timestamp startDate;
    private String imageUrl;

    public Tour() {}

    public Tour(int id, String name, double price, int maxCapacity, int currentCapacity, String location, String description, Timestamp startDate, String imageUrl) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.maxCapacity = maxCapacity;
        this.currentCapacity = currentCapacity;
        this.location = location;
        this.description = description;
        this.startDate = startDate;
        this.imageUrl = imageUrl;
    }

    // --- GETTER & SETTER ---
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getMaxCapacity() { return maxCapacity; }
    public int getCurrentCapacity() { return currentCapacity; }
    public String getLocation() { return location; }
    public String getDescription() { return description; }
    public Timestamp getStartDate() { return startDate; }
    public String getImageUrl() { return imageUrl; }
}