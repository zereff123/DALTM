<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cổng Thông Tin Hướng Dẫn Viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #eef2f7; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(to right, #11998e, #38ef7d); }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4 shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-map-signs me-2"></i>GUIDE PORTAL</a>
            <div class="ms-auto d-flex align-items-center">
                <span class="text-white me-3">Xin chào, ${sessionScope.account.fullName}</span>
                <a href="logout" class="btn btn-light btn-sm rounded-pill text-success fw-bold">Đăng Xuất</a>
            </div>
        </div>
    </nav>

    <div class="container">
        
        <div class="card border-0 shadow-sm mb-3">
            <div class="card-body p-3">
                <form action="guide" method="get" class="row g-3 align-items-center">
                    <div class="col-auto">
                        <label class="col-form-label fw-bold"><i class="fas fa-filter text-primary"></i> Lọc theo Tour:</label>
                    </div>
                    <div class="col-md-6">
                        <select name="filterTourId" class="form-select" onchange="this.form.submit()">
                            <option value="0">--- Hiển thị tất cả khách hàng ---</option>
                            <c:forEach items="${listAllTours}" var="t">
                                <option value="${t.id}" ${t.id == selectedTourId ? 'selected' : ''}>
                                    ${t.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto">
                        <span class="text-muted small">(*Chọn tour để xem danh sách khách tương ứng)</span>
                    </div>
                </form>
            </div>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h5 class="text-success fw-bold mb-0"><i class="fas fa-users"></i> Danh Sách Khách Hàng</h5>
                <span class="badge bg-secondary">Số lượng: ${listB.size()}</span>
            </div>
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-success">
                        <tr>
                            <th>Tour</th>
                            <th>Ngày Khởi Hành</th>
                            <th>Tên Khách</th>
                            <th>Số Điện Thoại</th>
                            <th>Trạng Thái</th>
                            <th class="text-center">Tác Vụ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listB}" var="b">
                            <tr>
                                <td class="fw-bold text-dark">${b.tourName}</td>
                                <td><fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td><i class="fas fa-user-circle text-secondary"></i> ${b.userFullName}</td>
                                <td><a href="tel:${b.userPhone}" class="text-decoration-none fw-bold">${b.userPhone}</a></td>
                                <td><span class="badge bg-success">Đã xác nhận</span></td>
                                <td class="text-center">
                                    <a href="chat?partnerId=${b.userId}" class="btn btn-primary btn-sm rounded-pill shadow-sm">
                                        <i class="fas fa-comment-dots"></i> Chat ngay
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listB}">
                            <tr><td colspan="6" class="text-center py-4 text-muted">Không tìm thấy khách hàng nào.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100;">
        <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header bg-success text-white">
                <i class="fas fa-comment-dots me-2"></i>
                <strong class="me-auto" id="toastSender">Thông báo mới</strong>
                <small>Vừa xong</small>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body fw-bold" id="toastContent">
                Bạn có tin nhắn mới!
            </div>
            <div class="toast-footer bg-light p-2 text-end">
                <a href="#" id="toastLink" class="btn btn-sm btn-success">Xem ngay</a>
            </div>
        </div>
    </div>

    <audio id="notifSound" src="https://assets.mixkit.co/active_storage/sfx/2869/2869-preview.mp3"></audio>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // --- WEBSOCKET GLOBAL NOTIFICATION FOR GUIDE ---
        <c:if test="${sessionScope.account != null}">
            var myId = ${sessionScope.account.id};
            // Nhớ thay IP đúng của bạn
            var socket = new WebSocket("ws://10.15.73.207:8080/TourRealtimeSystem/chat?userId=" + myId); 

            socket.onmessage = function(event) {
                var msg = event.data;
                // Format nhận về: SENDER_ID:SENDER_NAME:CONTENT
                var parts = msg.split(":");
                if (parts.length >= 3) {
                    var senderId = parts[0];
                    var senderName = parts[1];
                    var content = parts.slice(2).join(":");

                    // 1. Phát âm thanh
                    var audio = document.getElementById("notifSound");
                    audio.play().catch(e => console.log("Cần tương tác để phát âm thanh"));

                    // 2. Hiển thị Toast thông báo
                    document.getElementById("toastSender").innerText = "Tin nhắn từ " + senderName;
                    document.getElementById("toastContent").innerText = content;
                    document.getElementById("toastLink").href = "chat?partnerId=" + senderId;

                    var toastEl = document.getElementById('liveToast');
                    var toast = new bootstrap.Toast(toastEl);
                    toast.show();
                }
            };
        </c:if>
    </script>
    </body>
</html>