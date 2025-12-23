<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${tour != null ? 'Cập Nhật Tour' : 'Thêm Tour Mới'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">${tour != null ? 'CẬP NHẬT THÔNG TIN TOUR' : 'THÊM TOUR MỚI'}</h4>
                    </div>
                    <div class="card-body">
                        <form action="admin-tours" method="post" enctype="multipart/form-data">
                            
                            <c:if test="${tour != null}">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${tour.id}">
                                <input type="hidden" name="oldImage" value="${tour.imageUrl}">
                            </c:if>
                            
                            <c:if test="${tour == null}">
                                <input type="hidden" name="action" value="insert">
                            </c:if>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên Tour</label>
                                <input type="text" name="name" class="form-control" value="${tour.name}" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Giá Vé (VNĐ)</label>
                                    <input type="number" name="price" class="form-control" value="${tour != null ? tour.price : ''}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Số Chỗ Tối Đa</label>
                                    <input type="number" name="maxCapacity" class="form-control" value="${tour != null ? tour.maxCapacity : ''}" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Địa Điểm</label>
                                    <input type="text" name="location" class="form-control" value="${tour.location}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Ngày Giờ Khởi Hành</label>
                                    <c:set var="dateVal" value="${tour.startDate.toString().substring(0, 16).replace(' ', 'T')}" />
                                    <input type="datetime-local" name="startDate" class="form-control" value="${tour != null ? dateVal : ''}" required>
                                </div>
                            </div>
                                
                            <div class="mb-3">
                                <label class="form-label fw-bold">Phương Tiện Di Chuyển</label>
                                <select name="transport" class="form-select" required>
                                    <option value="Xe Giường Nằm" ${tour.transport == 'Xe Giường Nằm' ? 'selected' : ''}>Xe Giường Nằm</option>
                                    <option value="Xe Ghế Ngồi" ${tour.transport == 'Xe Ghế Ngồi' ? 'selected' : ''}>Xe Ghế Ngồi</option>
                                    <option value="Máy Bay" ${tour.transport == 'Máy Bay' ? 'selected' : ''}>Máy Bay</option>
                                    <option value="Tàu Hỏa" ${tour.transport == 'Tàu Hỏa' ? 'selected' : ''}>Tàu Hỏa</option>
                                    <option value="Du Thuyền" ${tour.transport == 'Du Thuyền' ? 'selected' : ''}>Du Thuyền</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Hình Ảnh</label>
                                <input type="file" name="image" class="form-control" accept="image/*">
                                <c:if test="${tour != null}">
                                    <div class="mt-2">
                                        <small class="text-muted">Ảnh hiện tại:</small><br>
                                        <img src="${tour.imageUrl}" style="height: 100px; border-radius: 5px; border: 1px solid #ddd;">
                                    </div>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Mô Tả Chi Tiết</label>
                                <textarea name="description" class="form-control" rows="3" required>${tour.description}</textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold text-success">Lịch Trình Dự Kiến</label>
                                <textarea name="itinerary" class="form-control" rows="6" placeholder="Ví dụ:&#10;Ngày 1: Đón khách...&#10;Ngày 2: Tham quan..." required>${tour.itinerary}</textarea>
                            </div>
                            
                            <div class="text-end">
                                <a href="admin-tours" class="btn btn-secondary me-2">Hủy Bỏ</a>
                                <button type="submit" class="btn btn-primary fw-bold">Lưu Lại</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>