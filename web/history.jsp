<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đặt Tour</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .status-change { animation: flashStatus 1.5s ease-in-out; }
        @keyframes flashStatus { 0% { opacity: 0.5; transform: scale(1.1); } 100% { opacity: 1; transform: scale(1); } }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top mb-4">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-plane-departure me-2"></i>TRAVEL BOOKING</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-white active" href="history">Lịch sử đặt vé</a></li>
                    <li class="nav-item"><a class="btn btn-outline-light btn-sm ms-3" href="logout">Đăng Xuất</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="fas fa-check-circle me-2"></i> <strong>${sessionScope.successMsg}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="successMsg" scope="session"/>
        </c:if>

        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h4 class="text-primary mb-0"><i class="fas fa-history"></i> Lịch Sử Đặt Tour Của Bạn</h4>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Mã Đơn</th>
                            <th>Tên Tour</th>
                            <th>Ngày Đặt</th>
                            <th>Trạng Thái</th>
                            <th>Hỗ Trợ</th> </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listB}" var="b">
                            <tr>
                                <td class="text-center fw-bold">#${b.bookingId}</td>
                                <td>${b.tourName}</td>
                                <td class="text-center"><fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                
                                <td class="text-center" id="status-cell-${b.bookingId}">
                                    <c:choose>
                                        <c:when test="${b.status == 'PENDING'}">
                                            <span class="badge bg-warning text-dark p-2">⏳ Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.status == 'CONFIRMED'}">
                                            <span class="badge bg-success p-2">✅ Đã xác nhận</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger p-2">❌ Đã hủy</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center">
    <a href="chat?partnerId=11" class="btn btn-outline-primary btn-sm rounded-pill">
        <i class="fas fa-headset"></i> Chat với Hướng dẫn viên
    </a>
</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listB}">
                            <tr><td colspan="5" class="text-center py-4 text-muted">Bạn chưa đặt tour nào cả. <a href="home">Đặt ngay!</a></td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="text-center mt-3"><a href="home" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại trang chủ</a></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        var socket = new WebSocket("ws://10.15.73.207:8080/TourRealtimeSystem/ws"); // Thay IP

        socket.onmessage = function(event) {
            var msg = event.data;
            if (msg.startsWith("STATUS_UPDATE:")) {
                var parts = msg.split(":");
                var bookingId = parts[1];
                var newStatus = parts[2];
                
                var cell = document.getElementById("status-cell-" + bookingId);
                if (cell) {
                    var html = "";
                    if (newStatus === "CONFIRMED") {
                        html = '<span class="badge bg-success p-2 status-change">✅ Đã xác nhận</span>';
                    } else if (newStatus === "CANCELLED") {
                        html = '<span class="badge bg-danger p-2 status-change">❌ Đã hủy</span>';
                    }
                    cell.innerHTML = html;
                }
            }
        };
    </script>
</body>
</html>