package com.tour.controller;

import com.tour.dao.TourDAO;
import com.tour.model.Tour; // Import Model
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idRaw = request.getParameter("tour_id");
        
        try {
            int id = Integer.parseInt(idRaw);
            
            // 1. Gọi DAO xử lý DB
            TourDAO dao = new TourDAO();
            boolean success = dao.bookingTour(id);
            
            // 2. NẾU THÀNH CÔNG -> GỬI TÍN HIỆU WEBSOCKET
            if (success) {
                System.out.println("Đặt thành công tour ID: " + id);
                
                // Lấy thông tin mới nhất để gửi cho các client khác
                Tour t = dao.getTourById(id);
                if (t != null) {
                    // Gửi chuỗi: UPDATE:ID:SO_CHO_MOI
                    TourSocket.broadcast("UPDATE:" + t.getId() + ":" + t.getCurrentCapacity());
                }
            } else {
                System.out.println("Đặt thất bại hoặc hết chỗ!");
            }
            
            // 3. Quay lại trang chủ
            response.sendRedirect("home");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}