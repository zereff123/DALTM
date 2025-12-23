package com.tour.controller;

import com.tour.dao.TourDAO;
import com.tour.model.Tour;
import com.tour.model.User;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "AdminTourServlet", urlPatterns = {"/admin-tours"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 50    
)
public class AdminTourServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";
        TourDAO dao = new TourDAO();

        try {
            switch (action) {
                case "new":
                    request.getRequestDispatcher("tour_form.jsp").forward(request, response);
                    break;
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Tour existingTour = dao.getTourById(id);
                    request.setAttribute("tour", existingTour);
                    request.getRequestDispatcher("tour_form.jsp").forward(request, response);
                    break;
                case "delete":
                    int idDel = Integer.parseInt(request.getParameter("id"));
                    dao.deleteTour(idDel);
                    response.sendRedirect("admin-tours");
                    break;
                default: 
                    List<Tour> list = dao.getAllTours();
                    request.setAttribute("listT", list);
                    request.getRequestDispatcher("admin_tours.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("DEBUG: Action received = " + action); // Log kiểm tra

        TourDAO dao = new TourDAO();
        
        try {
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            if (priceStr != null) {
                priceStr = priceStr.replace(".", "").replace(",", ""); 
            }
            double price = Double.parseDouble(priceStr);

            int max = Integer.parseInt(request.getParameter("maxCapacity"));
            String location = request.getParameter("location");
            String desc = request.getParameter("description");
            String itinerary = request.getParameter("itinerary");
            String transport = request.getParameter("transport");
            
            String dateStr = request.getParameter("startDate"); 
            if(dateStr != null && dateStr.length() == 16) dateStr += ":00";
            Timestamp startDate = Timestamp.valueOf(dateStr.replace("T", " "));

            String imageUrl = "";
            Part filePart = request.getPart("image");
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                fileName = System.currentTimeMillis() + "_" + fileName;
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "images/" + fileName;
            } else {
                imageUrl = request.getParameter("oldImage");
                if(imageUrl == null || imageUrl.isEmpty()) {
                    imageUrl = "https://via.placeholder.com/400x250?text=No+Image"; 
                }
            }

            if ("insert".equals(action)) {
                Tour t = new Tour(0, name, price, max, 0, location, desc, itinerary, startDate, imageUrl, transport);
                dao.insertTour(t);
                System.out.println("DEBUG: Inserted Tour " + name);
                
            } else if ("update".equals(action)) {
                // Lấy ID từ form (Quan trọng)
                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("DEBUG: Updating Tour ID = " + id);
                
                Tour t = new Tour(id, name, price, max, 0, location, desc, itinerary, startDate, imageUrl, transport);
                dao.updateTour(t);
            }
            
            response.sendRedirect("admin-tours");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-tours");
        }
    }
}