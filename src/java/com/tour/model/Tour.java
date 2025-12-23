package com.tour.model;

import java.sql.Timestamp;

public class Tour {
    private int id;
    private String name;
    private double price;
    private int maxCapacity;
    private int currentCapacity;
    private String location;
    private String description;
    private String itinerary; // <--- 1. THÊM THUỘC TÍNH MỚI
    private Timestamp startDate;
    private String imageUrl;
    private String transport;

    public Tour() {
    }

    // 2. CẬP NHẬT CONSTRUCTOR (Tổng 10 tham số)
    public Tour(int id, String name, double price, int maxCapacity, int currentCapacity, String location, String description, String itinerary, Timestamp startDate, String imageUrl, String transport) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.maxCapacity = maxCapacity;
        this.currentCapacity = currentCapacity;
        this.location = location;
        this.description = description;
        this.itinerary = itinerary; // <--- GÁN GIÁ TRỊ
        this.startDate = startDate;
        this.imageUrl = imageUrl;
        this.transport = transport;
    }

    // 3. THÊM GETTER & SETTER CHO ITINERARY
    public String getItinerary() {
        return itinerary;
    }

    public void setItinerary(String itinerary) {
        this.itinerary = itinerary;
    }

    // ... Các Getter/Setter cũ giữ nguyên ...
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getMaxCapacity() { return maxCapacity; }
    public void setMaxCapacity(int maxCapacity) { this.maxCapacity = maxCapacity; }
    public int getCurrentCapacity() { return currentCapacity; }
    public void setCurrentCapacity(int currentCapacity) { this.currentCapacity = currentCapacity; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Timestamp getStartDate() { return startDate; }
    public void setStartDate(Timestamp startDate) { this.startDate = startDate; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getTransport() { return transport; }
    public void setTransport(String transport) { this.transport = transport; }
}