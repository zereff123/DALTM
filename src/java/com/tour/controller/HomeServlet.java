package com.tour.controller;

import com.tour.dao.TourDAO;
import com.tour.model.Tour;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Định nghĩa đường dẫn là /home
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Gọi DAO lấy dữ liệu
        TourDAO dao = new TourDAO();
        List<Tour> list = dao.getAllTours();
        
        // 2. Đẩy dữ liệu sang JSP
        request.setAttribute("listT", list);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}