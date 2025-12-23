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
        
        request.setCharacterEncoding("UTF-8"); // Quan trọng để nhận tiếng Việt
        
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("account");
            
            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            int tourId = Integer.parseInt(request.getParameter("tour_id"));
            
            // --- NHẬN DỮ LIỆU TÙY CHỌN TỪ FORM ---
            double finalPrice = Double.parseDouble(request.getParameter("finalPrice"));
            String orderNotes = request.getParameter("orderNotes");
            // ------------------------------------
            
            TourDAO tourDao = new TourDAO();
            boolean success = tourDao.bookingTour(tourId);
            
            if (success) {
                BookingDAO bookingDao = new BookingDAO();
                
                // 1. Lưu vào DB (Gọi hàm mới có 4 tham số)
                bookingDao.insertBooking(user.getId(), tourId, finalPrice, orderNotes);
                
                Tour t = tourDao.getTourById(tourId);
                
                // 2. GỬI WEBSOCKET
                if (t != null) {
                    TourSocket.broadcast("UPDATE:" + t.getId() + ":" + t.getCurrentCapacity());
                    
                    int newBookingId = bookingDao.getLatestBookingId(user.getId());
                    String msgAdmin = "NEW_BOOKING:" + newBookingId + ":" + user.getFullName() + ":" + 
                                      user.getPhoneNumber() + ":" + t.getName() + ":" + tourId + ":" + user.getId();
                    TourSocket.broadcast(msgAdmin);
                }

                session.setAttribute("successMsg", "Đặt vé thành công! Tổng tiền: " + String.format("%,.0f", finalPrice) + " VNĐ");
                response.sendRedirect("home");
                
            } else {
                session.setAttribute("errorMsg", "Rất tiếc! Tour này vừa hết chỗ.");
                response.sendRedirect("home"); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}