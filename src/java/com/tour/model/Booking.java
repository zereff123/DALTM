package com.tour.model;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int userId;
    private int tourId;
    private String userFullName; 
    private String userPhone;    
    private String tourName;     
    private Timestamp bookingDate;
    private String status;
    
    // --- THUỘC TÍNH MỚI (TÙY CHỌN DỊCH VỤ) ---
    private double totalPrice; // Tổng tiền (bao gồm option)
    private String orderNotes; // Ghi chú các dịch vụ đã chọn

    public Booking() {
    }

    // CONSTRUCTOR ĐẦY ĐỦ (10 Tham số)
    public Booking(int bookingId, int userId, int tourId, String userFullName, String userPhone, String tourName, Timestamp bookingDate, String status, double totalPrice, String orderNotes) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.tourId = tourId;
        this.userFullName = userFullName;
        this.userPhone = userPhone;
        this.tourName = tourName;
        this.bookingDate = bookingDate;
        this.status = status;
        this.totalPrice = totalPrice;
        this.orderNotes = orderNotes;
    }

    // Constructor rút gọn (để tránh lỗi code cũ nếu có)
    public Booking(int bookingId, int userId, int tourId, String userFullName, String userPhone, String tourName, Timestamp bookingDate, String status) {
        this(bookingId, userId, tourId, userFullName, userPhone, tourName, bookingDate, status, 0, "");
    }

    // --- Getters and Setters ---
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }

    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }

    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }

    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getOrderNotes() { return orderNotes; }
    public void setOrderNotes(String orderNotes) { this.orderNotes = orderNotes; }
}