package com.tour.model;
import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int userId;
    private int tourId;
    private String tourName;
    private Timestamp bookingDate;
    private String status;
    
    // --- MỚI THÊM: Để hiển thị thông tin khách ---
    private String userFullName; 
    private String userPhone;
    // ---------------------------------------------

    public Booking() {}

    // Constructor đầy đủ
    public Booking(int bookingId, int userId, int tourId, String tourName, Timestamp bookingDate, String status, String userFullName, String userPhone) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.tourId = tourId;
        this.tourName = tourName;
        this.bookingDate = bookingDate;
        this.status = status;
        this.userFullName = userFullName;
        this.userPhone = userPhone;
    }

    // Getter & Setter mới
    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }
    
    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }

    // Các Getter cũ giữ nguyên
    public int getBookingId() { return bookingId; }
    public int getUserId() { return userId; }
    public int getTourId() { return tourId; }
    public String getTourName() { return tourName; }
    public Timestamp getBookingDate() { return bookingDate; }
    public String getStatus() { return status; }
}