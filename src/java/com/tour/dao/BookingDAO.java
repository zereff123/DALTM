package com.tour.dao;

import com.tour.model.Booking;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // 1. Lấy lịch sử đặt vé của 1 người
    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String query = "SELECT b.*, t.tour_name, u.full_name, u.phone_number " +
                       "FROM Bookings b " +
                       "JOIN Tours t ON b.tour_id = t.tour_id " +
                       "JOIN Users u ON b.user_id = u.user_id " +
                       "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("tour_id"),
                    rs.getString("full_name"),
                    rs.getString("phone_number"),
                    rs.getString("tour_name"),
                    rs.getTimestamp("booking_date"),
                    rs.getString("status"),
                    rs.getDouble("total_price"), // Lấy giá tổng
                    rs.getString("order_notes")  // Lấy ghi chú
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Lấy TẤT CẢ đơn đặt vé (Manager)
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String query = "SELECT b.*, t.tour_name, u.full_name, u.phone_number " +
                       "FROM Bookings b " +
                       "JOIN Tours t ON b.tour_id = t.tour_id " +
                       "JOIN Users u ON b.user_id = u.user_id " + 
                       "ORDER BY b.booking_date DESC";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("tour_id"),
                    rs.getString("full_name"),
                    rs.getString("phone_number"),
                    rs.getString("tour_name"),
                    rs.getTimestamp("booking_date"),
                    rs.getString("status"),
                    rs.getDouble("total_price"),
                    rs.getString("order_notes")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Lấy danh sách theo Tour (Guide)
    public List<Booking> getBookingsByTour(int tourId) {
        List<Booking> list = new ArrayList<>();
        String query = "SELECT b.*, t.tour_name, u.full_name, u.phone_number " + 
                       "FROM Bookings b " +
                       "JOIN Users u ON b.user_id = u.user_id " +
                       "JOIN Tours t ON b.tour_id = t.tour_id " +
                       "WHERE b.status = 'CONFIRMED' "; 
        
        if (tourId > 0) {
            query += " AND t.tour_id = ? ";
        }
        query += " ORDER BY b.booking_date DESC";

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            if (tourId > 0) {
                ps.setInt(1, tourId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("tour_id"),
                    rs.getString("full_name"),
                    rs.getString("phone_number"),
                    rs.getString("tour_name"),
                    rs.getTimestamp("booking_date"),
                    rs.getString("status"),
                    rs.getDouble("total_price"),
                    rs.getString("order_notes")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 4. Thêm mới đơn đặt hàng (INSERT CÓ GIÁ VÀ GHI CHÚ)
    public void insertBooking(int userId, int tourId, double total, String notes) {
        String query = "INSERT INTO Bookings(user_id, tour_id, status, total_price, order_notes) VALUES (?, ?, 'PENDING', ?, ?)";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, tourId);
            ps.setDouble(3, total);
            ps.setString(4, notes);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ... Các hàm updateStatus, getLatestBookingId giữ nguyên ...
    public void updateStatus(int bookingId, String newStatus) {
        String query = "UPDATE Bookings SET status = ? WHERE booking_id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, newStatus);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public int getLatestBookingId(int userId) {
        String query = "SELECT MAX(booking_id) FROM Bookings WHERE user_id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}