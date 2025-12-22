package com.tour.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    
    // Cấu hình cho WampServer (MySQL)
    // Lưu ý: WampServer mặc định user là 'root', pass để trống
    private static final String USER = "root";
    private static final String PASS = ""; 
    private static final String URL = "jdbc:mysql://localhost:3306/TourBookingDB?useUnicode=true&characterEncoding=UTF-8";

    public Connection getConnection() {
        Connection conn = null;
        try {
            // 1. Gọi Driver MySQL (khác với SQL Server nhé)
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. Mở kết nối
            conn = DriverManager.getConnection(URL, USER, PASS);
            // System.out.println("Kết nối MySQL thành công!"); 
        } catch (Exception e) {
            System.out.println("Lỗi kết nối: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
    
    // Test thử
    public static void main(String[] args) {
        new DBContext().getConnection();
        System.out.println("Chạy xong hàm main");
    }
}