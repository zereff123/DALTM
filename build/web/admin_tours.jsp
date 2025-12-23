<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Tour Du Lịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="manager">ADMIN DASHBOARD</a>
            <div class="d-flex">
                <a href="manager" class="nav-link text-white me-3">Đơn Hàng</a>
                <a href="admin-tours" class="nav-link text-warning fw-bold me-3">Quản Lý Tour</a>
                <a href="home" class="nav-link text-white">Về Trang Chủ</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="text-primary fw-bold">Danh Sách Tour</h2>
            <a href="admin-tours?action=new" class="btn btn-success fw-bold"><i class="fas fa-plus"></i> Thêm Tour Mới</a>
        </div>

        <div class="card shadow border-0">
            <div class="card-body">
                <table class="table table-hover align-middle text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Hình Ảnh</th>
                            <th>Tên Tour</th>
                            <th>Giá Vé</th>
                            <th>Ngày Đi</th>
                            <th>Số Chỗ</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listT}" var="t">
                            <tr>
                                <td>${t.id}</td>
                                <td>
                                    <img src="${t.imageUrl}" alt="img" style="width: 80px; height: 50px; object-fit: cover; border-radius: 5px;">
                                </td>
                                <td class="text-start fw-bold">${t.name}</td>
                                <td class="text-danger fw-bold">
                                    <fmt:formatNumber value="${t.price}" pattern="#,###"/> đ
                                </td>
                                <td><fmt:formatDate value="${t.startDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>${t.currentCapacity} / ${t.maxCapacity}</td>
                                <td>
                                    <a href="admin-tours?action=edit&id=${t.id}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                    <a href="admin-tours?action=delete&id=${t.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa tour này? Tất cả đơn đặt vé của tour này cũng sẽ bị xóa!');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>