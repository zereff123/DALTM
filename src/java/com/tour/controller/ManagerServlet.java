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

@WebServlet(name = "ManagerServlet", urlPatterns = {"/manager"})
public class ManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        BookingDAO dao = new BookingDAO();
        request.setAttribute("listB", dao.getAllBookings());
        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int tourId = Integer.parseInt(request.getParameter("tourId")); 

        BookingDAO bookingDao = new BookingDAO();
        TourDAO tourDao = new TourDAO();

        if ("confirm".equals(action)) {
            // 1. Duyệt đơn
            bookingDao.updateStatus(bookingId, "CONFIRMED");
            
            // 2. Gửi tín hiệu cho User thấy ngay
            TourSocket.broadcast("STATUS_UPDATE:" + bookingId + ":CONFIRMED");
            
        } else if ("cancel".equals(action)) {
            // 1. Hủy đơn & Trả chỗ
            bookingDao.updateStatus(bookingId, "CANCELLED");
            tourDao.cancelBookingTour(tourId);
            
            // 2. Gửi tín hiệu cho User thấy ngay
            TourSocket.broadcast("STATUS_UPDATE:" + bookingId + ":CANCELLED");
            
            // 3. Gửi tín hiệu cập nhật lại số chỗ ngồi (cho trang Home)
            try {
                Tour t = tourDao.getTourById(tourId);
                if (t != null) {
                    TourSocket.broadcast("UPDATE:" + t.getId() + ":" + t.getCurrentCapacity());
                }
            } catch (Exception e) { e.printStackTrace(); }
        }
        
        response.sendRedirect("manager");
    }
}