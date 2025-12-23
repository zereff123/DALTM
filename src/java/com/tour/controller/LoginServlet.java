package com.tour.controller;

import com.tour.dao.UserDAO;
import com.tour.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    // GET: Mở trang login
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // POST: Xử lý form đăng nhập
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); // Đảm bảo xử lý tiếng Việt
        
        String u = request.getParameter("user");
        String p = request.getParameter("pass");
        
        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(u, p);
        
        if (user != null) {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = request.getSession();
            session.setAttribute("account", user);
            
            // --- PHÂN QUYỀN ĐIỀU HƯỚNG ---
            String role = user.getRole();
            
            if ("ADMIN".equals(role)) {
                // Nếu là Admin -> Vào trang quản lý
                response.sendRedirect("manager");
            } else if ("GUIDE".equals(role)) {
                // Nếu là Hướng dẫn viên -> Vào trang guide
                response.sendRedirect("guide");
            } else {
                // Nếu là Khách hàng -> Về trang chủ
                response.sendRedirect("home");
            }
            // -----------------------------
            
        } else {
            // Đăng nhập thất bại -> Báo lỗi
            request.setAttribute("mess", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}