package com.tour.controller;

import com.tour.dao.BookingDAO;
import com.tour.dao.TourDAO; // Import thêm TourDAO
import com.tour.model.Booking;
import com.tour.model.Tour;  // Import thêm Tour Model
import com.tour.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "GuideServlet", urlPatterns = {"/guide"})
public class GuideServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        // Chặn nếu không phải GUIDE
        if (user == null || !"GUIDE".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        // 1. Lấy danh sách tất cả các Tour để hiển thị vào Dropdown lọc
        TourDAO tourDao = new TourDAO();
        List<Tour> listTours = tourDao.getAllTours();
        request.setAttribute("listAllTours", listTours);

        // 2. Xử lý Lọc
        BookingDAO bookingDao = new BookingDAO();
        String tourIdRaw = request.getParameter("filterTourId");
        int tourId = 0; // Mặc định là 0 (Lấy tất cả)
        
        if (tourIdRaw != null && !tourIdRaw.isEmpty()) {
            try {
                tourId = Integer.parseInt(tourIdRaw);
            } catch (Exception e) {}
        }

        // Gọi hàm lọc vừa viết ở Bước 1
        List<Booking> listB = bookingDao.getBookingsByTour(tourId);

        // 3. Gửi dữ liệu sang JSP
        request.setAttribute("listB", listB);
        request.setAttribute("selectedTourId", tourId); // Để giữ trạng thái đã chọn
        
        request.getRequestDispatcher("guide_dashboard.jsp").forward(request, response);
    }
}