package com.tour.dao;

import com.tour.model.Tour;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {

    // 1. LẤY TẤT CẢ TOUR
    public List<Tour> getAllTours() {
        List<Tour> list = new ArrayList<>();
        String query = "SELECT * FROM Tours ORDER BY start_date DESC";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Tour(
                    rs.getInt("tour_id"),
                    rs.getString("tour_name"),
                    rs.getDouble("price"),
                    rs.getInt("max_capacity"),
                    rs.getInt("current_capacity"),
                    rs.getString("location"),
                    rs.getString("description"),
                    rs.getString("itinerary"),
                    rs.getTimestamp("start_date"),
                    rs.getString("image_url"),
                    rs.getString("transport") 
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. LẤY CHI TIẾT 1 TOUR
    public Tour getTourById(int id) {
        String query = "SELECT * FROM Tours WHERE tour_id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Tour(
                    rs.getInt("tour_id"),
                    rs.getString("tour_name"),
                    rs.getDouble("price"),
                    rs.getInt("max_capacity"),
                    rs.getInt("current_capacity"),
                    rs.getString("location"),
                    rs.getString("description"),
                    rs.getString("itinerary"),
                    rs.getTimestamp("start_date"),
                    rs.getString("image_url"),
                    rs.getString("transport")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 3. THÊM TOUR MỚI
    public void insertTour(Tour t) {
        String query = "INSERT INTO Tours (tour_name, price, max_capacity, current_capacity, location, description, itinerary, start_date, image_url, transport) VALUES (?, ?, ?, 0, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, t.getName());
            ps.setDouble(2, t.getPrice());
            ps.setInt(3, t.getMaxCapacity());
            ps.setString(4, t.getLocation());
            ps.setString(5, t.getDescription());
            ps.setString(6, t.getItinerary());
            ps.setTimestamp(7, t.getStartDate());
            ps.setString(8, t.getImageUrl());
            ps.setString(9, t.getTransport()); 
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // 4. CẬP NHẬT TOUR (SỬA LỖI KHÔNG UPDATE ĐƯỢC)
    public void updateTour(Tour t) {
        // Query có 10 dấu hỏi (9 set + 1 where)
        String query = "UPDATE Tours SET tour_name=?, price=?, max_capacity=?, location=?, description=?, itinerary=?, start_date=?, image_url=?, transport=? WHERE tour_id=?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            
            ps.setString(1, t.getName());
            ps.setDouble(2, t.getPrice());
            ps.setInt(3, t.getMaxCapacity());
            ps.setString(4, t.getLocation());
            ps.setString(5, t.getDescription());
            ps.setString(6, t.getItinerary());
            ps.setTimestamp(7, t.getStartDate());
            ps.setString(8, t.getImageUrl());
            
            // --- ĐÂY LÀ ĐOẠN QUAN TRỌNG NHẤT ---
            ps.setString(9, t.getTransport()); // transport là tham số thứ 9
            ps.setInt(10, t.getId());          // tour_id (WHERE) là tham số thứ 10
            // ------------------------------------
            
            int rows = ps.executeUpdate();
            System.out.println("DAO Update Result: " + rows + " row(s) updated."); // Debug log
            
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    // 5. XÓA TOUR
    public void deleteTour(int id) {
        String query = "DELETE FROM Tours WHERE tour_id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    // 6. XỬ LÝ ĐẶT VÉ (Giữ nguyên logic cũ của bạn)
    public boolean bookingTour(int tourId) {
        String checkQuery = "SELECT current_capacity, max_capacity FROM Tours WHERE tour_id = ?";
        String updateQuery = "UPDATE Tours SET current_capacity = current_capacity + 1 WHERE tour_id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement psCheck = conn.prepareStatement(checkQuery);
            psCheck.setInt(1, tourId);
            ResultSet rs = psCheck.executeQuery();
            if (rs.next()) {
                int current = rs.getInt("current_capacity");
                int max = rs.getInt("max_capacity");
                if (current < max) {
                    PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
                    psUpdate.setInt(1, tourId);
                    psUpdate.executeUpdate();
                    return true;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    
    // 7. HỦY ĐẶT VÉ (Cho Manager)
    public void cancelBookingTour(int tourId) {
        String query = "UPDATE Tours SET current_capacity = current_capacity - 1 WHERE tour_id = ? AND current_capacity > 0";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, tourId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}