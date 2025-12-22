package com.tour.dao;

import com.tour.model.Tour;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {

    // 1. Hàm lấy danh sách tour (CẬP NHẬT: Lấy đủ thông tin mới)
    public List<Tour> getAllTours() {
        List<Tour> list = new ArrayList<>();
        String query = "SELECT * FROM Tours"; 
        try {
            Connection conn = new DBContext().getConnection(); 
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // PHẢI DÙNG CONSTRUCTOR ĐẦY ĐỦ (9 THAM SỐ)
                list.add(new Tour(
                    rs.getInt("tour_id"),
                    rs.getString("tour_name"),
                    rs.getDouble("price"),
                    rs.getInt("max_capacity"),
                    rs.getInt("current_capacity"),
                    rs.getString("location"),       // Mới
                    rs.getString("description"),    // Mới
                    rs.getTimestamp("start_date"),  // Mới
                    rs.getString("image_url")       // Mới
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 2. Hàm xử lý đặt tour
    public boolean bookingTour(int tourId) {
        // Kiểm tra logic trước khi đặt
        String checkQuery = "SELECT current_capacity, max_capacity FROM Tours WHERE tour_id = ?";
        String updateQuery = "UPDATE Tours SET current_capacity = current_capacity + 1 WHERE tour_id = ?";
        
        try {
            Connection conn = new DBContext().getConnection();
            
            // Bước A: Kiểm tra số lượng
            PreparedStatement psCheck = conn.prepareStatement(checkQuery);
            psCheck.setInt(1, tourId);
            ResultSet rs = psCheck.executeQuery();
            
            if (rs.next()) {
                int current = rs.getInt("current_capacity");
                int max = rs.getInt("max_capacity");
                if (current >= max) {
                    return false; // Hết chỗ
                }
            }
            
            // Bước B: Update tăng lên 1
            PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
            psUpdate.setInt(1, tourId);
            int result = psUpdate.executeUpdate();
            
            conn.close();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Hàm lấy chi tiết 1 tour (để gửi WebSocket và xem chi tiết)
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
                    rs.getTimestamp("start_date"),
                    rs.getString("image_url")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}