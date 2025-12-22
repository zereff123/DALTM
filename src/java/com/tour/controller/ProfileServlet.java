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

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect("login");
            return;
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        // 1. XỬ LÝ CẬP NHẬT THÔNG TIN
        if ("updateInfo".equals(action)) {
            String fullName = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            
            boolean check = dao.updateProfile(user.getId(), fullName, phone);
            if (check) {
                // Cập nhật lại Session để hiển thị ngay tên mới
                user.setFullName(fullName);
                user.setPhoneNumber(phone);
                session.setAttribute("account", user);
                session.setAttribute("successMsg", "Cập nhật thông tin thành công!");
            } else {
                session.setAttribute("errorMsg", "Cập nhật thất bại!");
            }
        } 
        
        // 2. XỬ LÝ ĐỔI MẬT KHẨU
        else if ("changePass".equals(action)) {
            String oldPass = request.getParameter("oldPass");
            String newPass = request.getParameter("newPass");
            String confirmPass = request.getParameter("confirmPass");
            
            if (!newPass.equals(confirmPass)) {
                session.setAttribute("errorMsg", "Mật khẩu xác nhận không khớp!");
            } else {
                boolean check = dao.changePassword(user.getId(), oldPass, newPass);
                if (check) {
                    session.setAttribute("successMsg", "Đổi mật khẩu thành công!");
                } else {
                    session.setAttribute("errorMsg", "Mật khẩu cũ không đúng!");
                }
            }
        }
        
        response.sendRedirect("profile");
    }
}