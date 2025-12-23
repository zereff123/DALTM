<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đặt Tour - Admin Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body { background-color: #f0f2f5; font-family: 'Nunito', sans-serif; }
        h1, h2, h3, h4, h5, .navbar-brand { font-family: 'Montserrat', sans-serif; }
        
        .navbar { background: linear-gradient(to right, #2c3e50, #4ca1af); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .card-header { background-color: #fff; border-bottom: 2px solid #4ca1af; }
        .table thead { background-color: #2c3e50; color: white; }
        
        .new-row { 
            animation: highlightRow 2s ease-in-out; 
            background-color: #fff3cd !important; 
        }
        @keyframes highlightRow { 
            0% { background-color: #ffc107; transform: scale(1.02); } 
            100% { background-color: #fff3cd; transform: scale(1); } 
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top mb-4">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-user-shield me-2"></i>ADMIN DASHBOARD</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active fw-bold" href="manager">Quản lý đơn hàng</a>
                    </li>
                    
                    <li class="nav-item ms-3">
                        <a class="nav-link text-warning fw-bold border border-warning rounded px-3" href="admin-tours">
                            <i class="fas fa-suitcase-rolling"></i> Quản Lý Tour
                        </a>
                    </li>
                    <li class="nav-item ms-3"><a class="nav-link" href="home">Về trang chủ</a></li>
                    
                    <li class="nav-item ms-3">
                        <a class="btn btn-outline-light btn-sm rounded-pill" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-5"> 
        <div class="card shadow border-0 mb-5">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h4 class="text-dark mb-0 fw-bold"><i class="fas fa-list-alt text-primary"></i> Danh Sách Đơn Đặt Tour</h4>
                <span class="badge bg-secondary fs-6">Tổng số đơn: ${listB.size()}</span>
            </div>
            
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>Mã Đơn</th>
                                <th>Khách Hàng (SĐT)</th> 
                                <th>Tên Tour</th>
                                <th>Ngày Đặt</th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody id="booking-table-body">
                            <c:forEach items="${listB}" var="b">
                                <tr>
                                    <td class="fw-bold">#${b.bookingId}</td>
                                    
                                    <td class="text-start">
                                        <div class="fw-bold text-primary">
                                            <i class="fas fa-user"></i> ${b.userFullName}
                                        </div>
                                        <div class="small text-muted">
                                            <i class="fas fa-phone"></i> ${b.userPhone}
                                        </div>
                                    </td>
                                    
                                    <td class="text-start fw-bold text-dark">${b.tourName}</td>
                                    
                                    <td>
                                        <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 'PENDING'}">
                                                <span class="badge bg-warning text-dark p-2"><i class="fas fa-clock"></i> Chờ duyệt</span>
                                            </c:when>
                                            <c:when test="${b.status == 'CONFIRMED'}">
                                                <span class="badge bg-success p-2"><i class="fas fa-check-circle"></i> Đã duyệt</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger p-2"><i class="fas fa-times-circle"></i> Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td>
                                        <c:if test="${b.status == 'PENDING'}">
                                            <form action="manager" method="post" class="d-inline">
                                                <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                <input type="hidden" name="userId" value="${b.userId}">
                                                <input type="hidden" name="tourId" value="${b.tourId}"> 
                                                <input type="hidden" name="action" value="confirm">
                                                <button class="btn btn-success btn-sm" title="Duyệt đơn"><i class="fas fa-check"></i></button>
                                            </form>

                                            <form action="manager" method="post" class="d-inline ms-1">
                                                <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                <input type="hidden" name="userId" value="${b.userId}">
                                                <input type="hidden" name="tourId" value="${b.tourId}"> 
                                                <input type="hidden" name="action" value="cancel">
                                                <button class="btn btn-danger btn-sm" title="Từ chối / Hủy" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn này và trả lại chỗ?');">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty listB}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">Chưa có đơn đặt hàng nào.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // --- WEBSOCKET REAL-TIME ---
        var socket = new WebSocket("ws://10.15.73.207:8080/TourRealtimeSystem/ws");
        
        socket.onopen = function(event) {
            console.log("Admin Dashboard WebSocket Connected!");
        };

        socket.onmessage = function(event) {
            var msg = event.data;
            if (msg.startsWith("NEW_BOOKING:")) {
                var parts = msg.split(":");
                var bookingId = parts[1];
                var custName = parts[2];
                var custPhone = parts[3];
                var tourName = parts[4];
                var tourId = parts[5];
                var userId = parts[6];

                var newRow = `
                    <tr class="new-row">
                        <td class="fw-bold">#` + bookingId + ` <span class="badge bg-danger">MỚI</span></td>
                        <td class="text-start">
                            <div class="fw-bold text-primary"><i class="fas fa-user"></i> ` + custName + `</div>
                            <div class="small text-muted"><i class="fas fa-phone"></i> ` + custPhone + `</div>
                        </td>
                        <td class="text-start fw-bold text-dark">` + tourName + `</td>
                        <td>Vừa xong</td>
                        <td><span class="badge bg-warning text-dark p-2"><i class="fas fa-clock"></i> Chờ duyệt</span></td>
                        <td>
                            <form action="manager" method="post" class="d-inline">
                                <input type="hidden" name="bookingId" value="` + bookingId + `">
                                <input type="hidden" name="userId" value="` + userId + `">
                                <input type="hidden" name="tourId" value="` + tourId + `">
                                <input type="hidden" name="action" value="confirm">
                                <button class="btn btn-success btn-sm" title="Duyệt đơn"><i class="fas fa-check"></i></button>
                            </form>
                            <form action="manager" method="post" class="d-inline ms-1">
                                <input type="hidden" name="bookingId" value="` + bookingId + `">
                                <input type="hidden" name="userId" value="` + userId + `">
                                <input type="hidden" name="tourId" value="` + tourId + `">
                                <input type="hidden" name="action" value="cancel">
                                <button class="btn btn-danger btn-sm" title="Từ chối / Hủy" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn này và trả lại chỗ?');"><i class="fas fa-times"></i></button>
                            </form>
                        </td>
                    </tr>
                `;
                var tbody = document.getElementById("booking-table-body");
                tbody.insertAdjacentHTML('afterbegin', newRow);
            }
        };
    </script>
</body>
</html>