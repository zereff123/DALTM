package com.tour.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy phiên làm việc hiện tại (Session)
        HttpSession session = request.getSession();
        
        // 2. Xóa thông tin tài khoản đã lưu (key là "account" như lúc Login)
        session.removeAttribute("account");
        
        // Hoặc dùng lệnh này để xóa sạch sành sanh mọi thứ trong session (an toàn hơn)
        // session.invalidate(); 
        
        // 3. Quay trở lại trang chủ
        response.sendRedirect("home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}