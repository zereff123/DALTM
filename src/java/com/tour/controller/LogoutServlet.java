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
        
        // 1. Lấy phiên làm việc hiện tại
        HttpSession session = request.getSession();
        
        // 2. HỦY HOÀN TOÀN SESSION CŨ (Xóa sạch tài khoản, rác, lịch sử...)
        // Lệnh này an toàn hơn removeAttribute rất nhiều
        session.invalidate(); 
        
        // 3. Tạo một Session MỚI TINH để lưu thông báo
        // (Vì session cũ đã bị hủy ở bước 2 rồi, không lưu vào đó được nữa)
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("successMsg", "Đã đăng xuất thành công!");
        
        // 4. Chuyển hướng về trang LOGIN
        // (Để hiện cái khung màu xanh chúng ta vừa code bên login.jsp)
        response.sendRedirect("login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}