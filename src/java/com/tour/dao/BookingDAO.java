package com.tour.dao;

import com.tour.model.Booking;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // 1. Lấy lịch sử đặt vé của 1 người (Dùng cho Trang Lịch Sử)
    // Cập nhật: Join thêm bảng Users để lấy đủ thông tin cho đúng Constructor
    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String query = "SELECT b.*, t.tour_name, u.full_name, u.phone_number " +
                       "FROM Bookings b " +
                       "JOIN Tours t ON b.tour_id = t.tour_id " +
                       "JOIN Users u ON b.user_id = u.user_id " +
                       "WHERE b.user_id = ? " +
                       "ORDER BY b.booking_date DESC";
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
                    rs.getString("tour_name"),
                    rs.getTimestamp("booking_date"),
                    rs.getString("status"),
                    rs.getString("full_name"),   // Tên khách
                    rs.getString("phone_number") // SĐT khách
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Lấy TẤT CẢ đơn đặt vé (Dùng cho Trang Manager)
    // Cập nhật: Đã chuẩn
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
                    rs.getString("tour_name"),
                    rs.getTimestamp("booking_date"),
                    rs.getString("status"),
                    rs.getString("full_name"),   // Tên khách
                    rs.getString("phone_number") // SĐT khách
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Cập nhật trạng thái đơn (Duyệt/Hủy) - Giữ nguyên
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
    
    // 4. Thêm mới đơn đặt hàng - Giữ nguyên
    public void insertBooking(int userId, int tourId) {
        String query = "INSERT INTO Bookings(user_id, tour_id, status) VALUES (?, ?, 'PENDING')";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, tourId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}