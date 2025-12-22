package com.tour.controller;

import com.tour.dao.BookingDAO;
import com.tour.dao.TourDAO;
import com.tour.model.Tour;
import com.tour.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String idRaw = request.getParameter("tour_id");
        
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("account");
            
            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            int tourId = Integer.parseInt(idRaw);
            
            TourDAO tourDao = new TourDAO();
            boolean success = tourDao.bookingTour(tourId);
            
            if (success) {
                // 1. Lưu vào DB
                BookingDAO bookingDao = new BookingDAO();
                bookingDao.insertBooking(user.getId(), tourId);
                
                // 2. Gửi WebSocket
                Tour t = tourDao.getTourById(tourId);
                if (t != null) {
                    TourSocket.broadcast("UPDATE:" + t.getId() + ":" + t.getCurrentCapacity());
                }

                // 3. THÔNG BÁO THÀNH CÔNG
                // Thêm đường link <a> vào thông báo để ai thích thì bấm xem lịch sử
                session.setAttribute("successMsg", "Đặt vé thành công! <a href='history' class='fw-bold text-decoration-underline'>Xem lịch sử tại đây</a>");
                
                // 4. QUAY VỀ TRANG CHỦ (Thay vì history)
                response.sendRedirect("home");
                
            } else {
                // Thất bại
                session.setAttribute("errorMsg", "Rất tiếc! Tour này vừa hết chỗ.");
                response.sendRedirect("home"); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}