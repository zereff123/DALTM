package com.tour.dao;

import com.tour.model.User;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    // 1. Kiểm tra đăng nhập
    public User checkLogin(String user, String pass) {
        String query = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("full_name"),
                    rs.getString("role"),
                    rs.getString("phone_number")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. Đăng ký tài khoản (CHUẨN 4 THAM SỐ)
    public boolean register(String user, String pass, String fullname, String phone) {
        String query = "INSERT INTO Users (username, password, full_name, phone_number, role) VALUES (?, ?, ?, ?, 'CUSTOMER')";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, fullname);
            ps.setString(4, phone);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 3. Cập nhật thông tin cá nhân (Tên, SĐT)
    public boolean updateProfile(int userId, String fullName, String phone) {
        String query = "UPDATE Users SET full_name = ?, phone_number = ? WHERE user_id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, userId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // 4. Đổi mật khẩu
    public boolean changePassword(int userId, String oldPass, String newPass) {
        // Bước 1: Kiểm tra mật khẩu cũ có đúng không
        String checkQuery = "SELECT * FROM Users WHERE user_id = ? AND password = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, userId);
            ps.setString(2, oldPass);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Bước 2: Nếu đúng thì cập nhật mật khẩu mới
                String updateQuery = "UPDATE Users SET password = ? WHERE user_id = ?";
                PreparedStatement ps2 = conn.prepareStatement(updateQuery);
                ps2.setString(1, newPass);
                ps2.setInt(2, userId);
                ps2.executeUpdate();
                return true;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}