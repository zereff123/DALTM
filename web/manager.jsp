<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đặt Tour</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card-header { background-color: #fff; border-bottom: 2px solid #0d6efd; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top mb-4">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-user-shield me-2"></i>ADMIN DASHBOARD</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="manager">Quản lý đơn hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="home">Về trang chủ</a>
                    </li>
                    <li class="nav-item ms-3">
                        <a class="btn btn-outline-light btn-sm" href="logout">Đăng Xuất</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-5"> <div class="card shadow border-0">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h4 class="text-primary mb-0"><i class="fas fa-list-alt"></i> Danh Sách Đơn Đặt Tour</h4>
                <span class="badge bg-secondary">Tổng số đơn: ${listB.size()}</span>
            </div>
            
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>Mã Đơn</th>
                                <th>Khách Hàng (SĐT)</th> <th>Tên Tour</th>
                                <th>Ngày Đặt</th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
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
                                    
                                    <td class="text-start fw-bold">${b.tourName}</td>
                                    <td>
                                        <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 'PENDING'}">
                                                <span class="badge bg-warning text-dark">⏳ Chờ duyệt</span>
                                            </c:when>
                                            <c:when test="${b.status == 'CONFIRMED'}">
                                                <span class="badge bg-success">✅ Đã duyệt</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">❌ Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${b.status == 'PENDING'}">
                                            <form action="manager" method="post" class="d-inline">
                                                <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                <input type="hidden" name="userId" value="${b.userId}">
                                                <input type="hidden" name="action" value="confirm">
                                                <button class="btn btn-success btn-sm"><i class="fas fa-check"></i></button>
                                            </form>
                                            <form action="manager" method="post" class="d-inline">
                                                <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                <input type="hidden" name="userId" value="${b.userId}">
                                                <input type="hidden" name="action" value="cancel">
                                                <button class="btn btn-danger btn-sm"><i class="fas fa-times"></i></button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Sửa lại IP của máy bạn ở đây
        var socket = new WebSocket("ws://26.70.226.190:8080/TourRealtimeSystem/ws");
        // Trang Manager chủ yếu là GỬI tin đi (qua Servlet), việc NHẬN tin ở đây không quá quan trọng
    </script>
</body>
</html>