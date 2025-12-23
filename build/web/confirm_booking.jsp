<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Nhận Đặt Tour</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0 fw-bold"><i class="fas fa-clipboard-check"></i> XÁC NHẬN ĐƠN HÀNG</h4>
                    </div>
                    <div class="card-body p-4">
                        
                        <h6 class="text-primary fw-bold border-bottom pb-2 mb-3">I. THÔNG TIN KHÁCH HÀNG</h6>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="small text-muted">Họ và tên:</label>
                                <div class="fw-bold">${sessionScope.account.fullName}</div>
                            </div>
                            <div class="col-md-6">
                                <label class="small text-muted">Số điện thoại:</label>
                                <div class="fw-bold">${sessionScope.account.phoneNumber}</div>
                            </div>
                        </div>

                        <h6 class="text-primary fw-bold border-bottom pb-2 mb-3 mt-4">II. CHI TIẾT DỊCH VỤ</h6>
                        <table class="table table-bordered">
                            <tr>
                                <td class="bg-light" style="width: 150px;"><strong>Tên Tour</strong></td>
                                <td>${tour.name}</td>
                            </tr>
                            <tr>
                                <td class="bg-light"><strong>Khởi hành</strong></td>
                                <td><fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            </tr>
                            <tr>
                                <td class="bg-light"><strong>Phương tiện</strong></td>
                                <td class="fw-bold text-success"><i class="fas fa-bus"></i> Xe Giường Nằm (Tiêu chuẩn)</td>
                            </tr>
                            <tr>
                                <td class="bg-light"><strong>Giá gốc</strong></td>
                                <td><fmt:formatNumber value="${tour.price}" pattern="#,###"/> VNĐ</td>
                            </tr>
                        </table>

                        <div class="alert alert-light border">
                            <h6 class="fw-bold"><i class="fas fa-plus-circle text-success"></i> Dịch vụ nâng cao (Tùy chọn):</h6>
                            
                            <div class="form-check mt-2">
                                <input class="form-check-input addon-checkbox" type="checkbox" value="500000" id="optRoom" data-name="Phòng đơn riêng tư">
                                <label class="form-check-label" for="optRoom">
                                    Yêu cầu phòng đơn khách sạn (+500,000 VNĐ)
                                </label>
                            </div>

                            <div class="form-check mt-2">
                                <input class="form-check-input addon-checkbox" type="checkbox" value="100000" id="optInsur" data-name="Bảo hiểm cao cấp">
                                <label class="form-check-label" for="optInsur">
                                    Gói bảo hiểm du lịch cao cấp (+100,000 VNĐ)
                                </label>
                            </div>
                        </div>
                        <div class="alert alert-warning d-flex justify-content-between align-items-center mt-3">
                            <span class="fw-bold">TỔNG CỘNG THANH TOÁN:</span>
                            <span class="fs-3 fw-bold text-danger">
                                <span id="displayTotal"><fmt:formatNumber value="${tour.price}" pattern="#,###"/></span> VNĐ
                            </span>
                        </div>

                        <form action="booking" method="post" class="mt-4" id="bookingForm">
                            <input type="hidden" name="tour_id" value="${tour.id}">
                            
                            <input type="hidden" name="finalPrice" id="inputFinalPrice" value="${tour.price}">
                            <input type="hidden" name="orderNotes" id="inputOrderNotes" value="">

                            <div class="d-flex gap-2">
                                <a href="detail?id=${tour.id}" class="btn btn-outline-secondary w-50 fw-bold">
                                    <i class="fas fa-arrow-left"></i> Quay Lại
                                </a>
                                <button type="submit" class="btn btn-success w-50 fw-bold py-2">
                                    <i class="fas fa-check-circle"></i> CHỐT ĐƠN & ĐẶT VÉ
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const basePrice = ${tour.price}; // Giá gốc
        const checkboxes = document.querySelectorAll('.addon-checkbox');
        const displayTotal = document.getElementById('displayTotal');
        const inputFinalPrice = document.getElementById('inputFinalPrice');
        const inputOrderNotes = document.getElementById('inputOrderNotes');

        function updateCalculation() {
            let currentTotal = basePrice;
            let notes = [];

            // Chỉ còn tính tiền Checkbox
            checkboxes.forEach(cb => {
                if (cb.checked) {
                    currentTotal += parseInt(cb.value);
                    notes.push(cb.getAttribute('data-name'));
                }
            });

            // Update hiển thị
            displayTotal.innerText = currentTotal.toLocaleString('vi-VN');
            inputFinalPrice.value = currentTotal;
            
            if (notes.length > 0) {
                inputOrderNotes.value = notes.join(", ");
            } else {
                inputOrderNotes.value = "Tiêu chuẩn";
            }
        }

        checkboxes.forEach(cb => cb.addEventListener('change', updateCalculation));
    </script>

</body>
</html>