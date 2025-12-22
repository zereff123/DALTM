/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tour.controller;

import com.tour.dao.BookingDAO;
import com.tour.model.Booking;
import com.tour.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hoang Anh
 */
@WebServlet(name = "HistoryServlet", urlPatterns = {"/history"})
public class HistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user != null) {
            BookingDAO dao = new BookingDAO();
            List<Booking> list = dao.getBookingsByUser(user.getId());
            request.setAttribute("listB", list);
            request.getRequestDispatcher("history.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }
}
