package com.tour.controller;

import com.tour.dao.MessageDAO;
import com.tour.dao.UserDAO;
import com.tour.model.Message;
import com.tour.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User me = (User) session.getAttribute("account");
        
        if (me == null) {
            response.sendRedirect("login");
            return;
        }

        String partnerIdRaw = request.getParameter("partnerId");
        if (partnerIdRaw != null) {
            int partnerId = Integer.parseInt(partnerIdRaw);
            
            // Lấy thông tin người mình đang chat cùng
            UserDAO userDAO = new UserDAO();
            User partner = userDAO.getUserById(partnerId); // Cần thêm hàm này trong UserDAO nếu chưa có
            
            // Lấy lịch sử tin nhắn
            MessageDAO msgDAO = new MessageDAO();
            List<Message> history = msgDAO.getConversation(me.getId(), partnerId);
            
            request.setAttribute("partner", partner);
            request.setAttribute("history", history);
            request.getRequestDispatcher("chat.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}