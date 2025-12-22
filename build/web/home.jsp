<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Đặt Tour Du Lịch</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { box-shadow: 0 2px 4px rgba(0,0,0,.1); }
        .tour-card { transition: transform 0.3s; border: none; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .tour-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.15); }
        .status-badge { font-size: 0.8rem; padding: 5px 10px; border-radius: 20px; }
        .btn-booking { border-radius: 20px; padding: 8px 20px; font-weight: bold; }
        /* Hiệu ứng nháy khi có cập nhật */
        .highlight-update { animation: flash 1s; background-color: yellow !important; color: black !important; }
        @keyframes flash { 0% { background-color: yellow; } 100% { background-color: transparent; } }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-plane-departure me-2"></i>TRAVEL BOOKING</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <c:if test="${sessionScope.account == null}">
                        <li class="nav-item"><a class="nav-link text-white" href="login"><i class="fas fa-sign-in-alt"></i> Đăng Nhập</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="register"><i class="fas fa-user-plus"></i> Đăng Ký</a></li>
                    </c:if>
                    <c:if test="${sessionScope.account != null}">
                        <li class="nav-item d-flex align-items-center">
                            <span class="text-white me-3">Xin chào, <b>${sessionScope.account.fullName}</b></span>
                            <a class="btn btn-outline-light btn-sm" href="logout">Đăng Xuất</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="bg-white py-4 mb-4 shadow-sm">
        <div class="container text-center">
            <h1 class="display-5 fw-bold text-primary">Khám Phá Các Tour Hot Nhất</h1>
            <p class="lead text-muted">Hệ thống đặt vé thời gian thực - Nhanh chóng & Tiện lợi</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row">
            <c:forEach items="${listT}" var="o">
                <div class="col-md-4 mb-4">
                    <div class="card tour-card h-100">
                        <img src="${o.imageUrl}" class="card-img-top" alt="Tour Image" style="height: 250px; object-fit: cover;">
                        
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-primary">${o.name}</h5>
                            <p class="card-text text-muted">
                                <i class="fas fa-map-marker-alt text-danger"></i> ${o.location}
                            </p>
                            
                            <h4 class="text-success fw-bold">
                                <fmt:formatNumber value="${o.price}" type="currency" currencySymbol=""/> VNĐ
                            </h4>
                            
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div>
                                    <small class="text-muted">Chỗ trống:</small><br>
                                    <span id="seat-${o.id}" class="fs-5 fw-bold ${o.currentCapacity >= o.maxCapacity ? 'text-danger' : 'text-success'}">
                                        ${o.currentCapacity} / ${o.maxCapacity}
                                    </span>
                                </div>
                                
                                <div class="progress w-50" style="height: 10px;">
                                    <c:set var="percent" value="${(o.currentCapacity * 100) / o.maxCapacity}"/>
                                    <div class="progress-bar ${percent >= 100 ? 'bg-danger' : 'bg-success'}" 
                                         role="progressbar" style="width: ${percent}%"></div>
                                </div>
                            </div>
                            
                            <a href="detail?id=${o.id}" class="btn btn-outline-info w-100 mt-3">Xem Chi Tiết</a>
                        </div>

                        <div class="card-footer bg-white border-top-0 pb-3 text-center">
    
    <c:if test="${sessionScope.account == null}">
        <a href="login" class="btn btn-warning w-100 shadow-sm">
            <i class="fas fa-sign-in-alt"></i> Đăng nhập để đặt
        </a>
    </c:if>

    <c:if test="${sessionScope.account != null}">
        
        <c:if test="${o.currentCapacity < o.maxCapacity}">
            <form action="booking" method="post">
                <input type="hidden" name="tour_id" value="${o.id}">
                <button type="submit" class="btn btn-primary btn-booking w-100 shadow">
                    <i class="fas fa-check-circle"></i> Đặt Vé Ngay
                </button>
            </form>
        </c:if>
        
        <c:if test="${o.currentCapacity >= o.maxCapacity}">
            <button class="btn btn-secondary btn-booking w-100" disabled>
                <i class="fas fa-ban"></i> Đã Hết Chỗ
            </button>
        </c:if>
        
    </c:if>
</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0">&copy; 2024 Tour Booking Realtime System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // WebSocket Script
        var socket = new WebSocket("ws://localhost:8080/TourRealtimeSystem/ws");

        socket.onopen = function(event) {
            console.log("Kết nối WebSocket thành công!");
        };

        socket.onmessage = function(event) {
            var msg = event.data;
            console.log("Nhận tín hiệu: " + msg);

            if (msg.startsWith("UPDATE:")) {
                var parts = msg.split(":");
                var tourId = parts[1];
                var newCount = parts[2];

                var spanElement = document.getElementById("seat-" + tourId);
                
                if (spanElement) {
                    var currentText = spanElement.innerText; 
                    var maxCapacity = currentText.split("/")[1]; 

                    spanElement.innerText = newCount + " /" + maxCapacity;
                    
                    spanElement.classList.add("highlight-update");
                    setTimeout(() => {
                        spanElement.classList.remove("highlight-update");
                    }, 1000);
                    
                    if (parseInt(newCount) >= parseInt(maxCapacity.trim())) {
                        spanElement.classList.remove("text-success");
                        spanElement.classList.add("text-danger");
                    }
                }
            }
        };
    </script>
</body>
</html>