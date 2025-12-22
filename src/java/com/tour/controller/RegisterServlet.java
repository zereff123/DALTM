package com.tour.controller;

import com.tour.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // QUAN TRỌNG: Import Session

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy dữ liệu từ form
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");

        // 2. Xử lý null
        if (pass == null) pass = "";
        if (repass == null) repass = "";

        // 3. Debug kiểm tra
        System.out.println("--- CHECK ĐĂNG KÝ ---");
        System.out.println("Pass: [" + pass + "]");
        System.out.println("Repass: [" + repass + "]");

        // 4. KIỂM TRA MẬT KHẨU
        if (!pass.equals(repass)) {
            // -- SAI MẬT KHẨU --
            request.setAttribute("mess", "Mật khẩu nhập lại không khớp!");
            // Giữ lại dữ liệu
            request.setAttribute("user", user);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phone);
            
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // -- GỌI DAO ĐỂ LƯU VÀO DB --
            UserDAO dao = new UserDAO();
            boolean result = dao.register(user, pass, fullname, phone);
            
            if (result) {
                System.out.println(">> Đăng ký THÀNH CÔNG!");
                
                // --- MỚI THÊM: TẠO THÔNG BÁO THÀNH CÔNG ---
                HttpSession session = request.getSession();
                session.setAttribute("successMsg", "Đăng ký thành công! Vui lòng đăng nhập.");
                // ------------------------------------------
                
                response.sendRedirect("login");
            } else {
                System.out.println(">> Đăng ký THẤT BẠI (Trùng tên)!");
                request.setAttribute("mess", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}