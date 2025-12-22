package com.tour.controller;

import com.tour.dao.TourDAO;
import com.tour.model.Tour;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TourDetailServlet", urlPatterns = {"/detail"})
public class TourDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idRaw = request.getParameter("id");
        try {
            int id = Integer.parseInt(idRaw);
            TourDAO dao = new TourDAO();
            Tour t = dao.getTourById(id);
            
            request.setAttribute("tour", t);
            request.getRequestDispatcher("detail.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.sendRedirect("home");
        }
    }
}