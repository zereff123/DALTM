package com.tour.dao;

import com.tour.model.User;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    // 1. Hàm kiểm tra đăng nhập
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
                    rs.getString("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu sai tên hoặc mật khẩu
    }

    // 2. Hàm đăng ký tài khoản mới
    public boolean register(String user, String pass, String fullname) {
        String query = "INSERT INTO Users (username, password, full_name, role) VALUES (?, ?, ?, 'CUSTOMER')";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, fullname);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace(); // Thường lỗi do trùng username
        }
        return false;
    }
}