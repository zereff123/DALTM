/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tour.controller;

import com.tour.dao.BookingDAO;
import com.tour.model.Booking;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hoang Anh
 */
@WebServlet(name = "ManagerServlet", urlPatterns = {"/manager"})
public class ManagerServlet extends HttpServlet {

    // Xem danh sách
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO dao = new BookingDAO();
        List<Booking> list = dao.getAllBookings();
        request.setAttribute("listB", list);
        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }

    // Xử lý nút Duyệt/Hủy
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int userId = Integer.parseInt(request.getParameter("userId")); // Để biết thông báo cho ai
        String action = request.getParameter("action"); // "confirm" hoặc "cancel"
        
        String status = action.equals("confirm") ? "CONFIRMED" : "CANCELLED";
        
        BookingDAO dao = new BookingDAO();
        dao.updateStatus(bookingId, status);
        
        // --- GỬI THÔNG BÁO REALTIME CHO KHÁCH ---
        String msg = "NOTIFY:" + userId + ":Đơn #" + bookingId + " của bạn đã chuyển sang " + status;
        TourSocket.broadcast(msg);
        // ----------------------------------------
        
        response.sendRedirect("manager");
    }
}
