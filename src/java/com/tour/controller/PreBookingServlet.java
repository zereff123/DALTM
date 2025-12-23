package com.tour.controller;

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

@WebServlet(name = "PreBookingServlet", urlPatterns = {"/pre-booking"})
public class PreBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // 2. Lấy ID tour từ trang chi tiết
        String idRaw = request.getParameter("id");
        if (idRaw != null) {
            int tourId = Integer.parseInt(idRaw);
            TourDAO dao = new TourDAO();
            Tour t = dao.getTourById(tourId);
            
            // 3. Gửi thông tin tour sang trang Xác nhận
            request.setAttribute("tour", t);
            request.getRequestDispatcher("confirm_booking.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}