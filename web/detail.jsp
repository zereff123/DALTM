<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${tour.name} - Chi tiết Tour</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-arrow-left"></i> Quay lại Danh sách</a>
        </div>
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card shadow border-0">
                    <img src="${tour.imageUrl}" class="card-img-top" alt="Tour Image" style="height: 400px; object-fit: cover;">
                </div>
            </div>

            <div class="col-md-6">
                <div class="card shadow border-0 p-4">
                    <h2 class="text-primary fw-bold">${tour.name}</h2>
                    <p class="text-muted"><i class="fas fa-map-marker-alt text-danger"></i> ${tour.location}</p>
                    
                    <hr>
                    
                    <div class="row mb-3">
                        <div class="col-6">
                            <strong><i class="far fa-calendar-alt"></i> Khởi hành:</strong><br>
                            <span class="text-primary"><fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                        </div>
                        <div class="col-6">
                            <strong><i class="fas fa-users"></i> Chỗ trống:</strong><br>
                            <span id="seat-${tour.id}" class="fw-bold fs-5 ${tour.currentCapacity >= tour.maxCapacity ? 'text-danger' : 'text-success'}">
                                ${tour.currentCapacity} / ${tour.maxCapacity}
                            </span>
                        </div>
                    </div>

                    <h3 class="text-success fw-bold mb-3">
                        <fmt:formatNumber value="${tour.price}" type="currency" currencySymbol=""/> VNĐ
                    </h3>

                    <p><strong>Mô tả:</strong><br> ${tour.description}</p>

                    <c:if test="${tour.currentCapacity < tour.maxCapacity}">
                        <form action="booking" method="post">
                            <input type="hidden" name="tour_id" value="${tour.id}">
                            <button type="submit" class="btn btn-primary btn-lg w-100 shadow">
                                <i class="fas fa-ticket-alt"></i> ĐẶT VÉ NGAY
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${tour.currentCapacity >= tour.maxCapacity}">
                        <button class="btn btn-secondary btn-lg w-100" disabled>HẾT CHỖ</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var socket = new WebSocket("ws://localhost:8080/TourRealtimeSystem/ws");
        socket.onmessage = function(event) {
            var msg = event.data; 
            if (msg.startsWith("UPDATE:")) {
                var parts = msg.split(":");
                var tourId = parts[1];
                var newCount = parts[2];
                
                // Chỉ cập nhật nếu đúng là tour đang xem
                if (tourId == "${tour.id}") {
                    var spanElement = document.getElementById("seat-" + tourId);
                    if (spanElement) {
                         var currentText = spanElement.innerText;
                         var maxCapacity = currentText.split("/")[1];
                         spanElement.innerText = newCount + " /" + maxCapacity;
                         spanElement.style.color = "red"; // Nháy đỏ báo hiệu
                    }
                }
            }
        };
    </script>
</body>
</html>