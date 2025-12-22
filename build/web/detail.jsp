<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tour.name} - Chi tiết Tour</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700;800&family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body { 
            background-color: #f8f9fa; 
            font-family: 'Nunito', sans-serif; /* Phông nội dung mềm mại */
        }
        
        /* Tiêu đề dùng Montserrat */
        h1, h2, h3, h4, h5, .navbar-brand, .price-tag, .btn {
            font-family: 'Montserrat', sans-serif;
        }

        /* Navbar Gradient */
        .navbar { background: linear-gradient(to right, #00c6ff, #0072ff); box-shadow: 0 4px 15px rgba(0,0,0,0.1); }

        /* Gallery Ảnh */
        .main-img { 
            width: 100%; height: 450px; object-fit: cover; border-radius: 15px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        /* Thông tin Highlights */
        .highlight-box {
            background: white; border-radius: 10px; padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px;
        }
        .icon-box i { font-size: 1.5rem; color: #0072ff; margin-bottom: 5px; }
        
        /* Sidebar Đặt vé (Trôi theo màn hình) */
        .booking-sidebar {
            position: sticky; top: 90px;
            background: white; border-radius: 15px; padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: 1px solid #eee;
        }
        
        .price-tag { font-size: 1.8rem; color: #2c3e50; font-weight: 800; }
        
        /* Real-time Counter */
        .seat-counter-box {
            background: #f1f3f5; border-radius: 10px; padding: 15px; margin: 15px 0;
            text-align: center; border: 1px dashed #adb5bd;
        }
        
        /* Buttons */
        .btn-book-now {
            background: linear-gradient(to right, #ff416c, #ff4b2b);
            border: none; color: white; font-weight: bold; padding: 12px;
            border-radius: 50px; box-shadow: 0 5px 15px rgba(255, 65, 108, 0.4);
            transition: 0.3s;
        }
        .btn-book-now:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(255, 65, 108, 0.6); color: white; }
        
        /* Animation */
        .highlight-update { animation: flash 1s; background-color: #fff3cd !important; color: #856404 !important; }
        @keyframes flash { 0% { background-color: #ffeeba; } 100% { background-color: transparent; } }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark sticky-top mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home"><i class="fas fa-chevron-left me-2"></i> Quay lại trang chủ</a>
            <span class="text-white fw-bold">Chi tiết trải nghiệm</span>
        </div>
    </nav>

    <div class="container mb-5">
        
        <div class="mb-4">
            <h1 class="fw-bold text-dark">${tour.name}</h1>
            <p class="text-muted mb-0"><i class="fas fa-map-marker-alt text-danger me-2"></i> ${tour.location}</p>
        </div>

        <div class="row">
            
            <div class="col-lg-8">
                <img src="${tour.imageUrl}" class="main-img mb-4" alt="Tour Image">
                
                <div class="highlight-box">
                    <div class="row text-center">
                        <div class="col-3 border-end">
                            <div class="icon-box"><i class="far fa-clock"></i></div>
                            <small class="text-muted">Thời gian</small>
                            <div class="fw-bold">3 Ngày 2 Đêm</div>
                        </div>
                        <div class="col-3 border-end">
                            <div class="icon-box"><i class="fas fa-car"></i></div>
                            <small class="text-muted">Di chuyển</small>
                            <div class="fw-bold">Xe Giường Nằm</div>
                        </div>
                        <div class="col-3 border-end">
                            <div class="icon-box"><i class="far fa-calendar-alt"></i></div>
                            <small class="text-muted">Khởi hành</small>
                            <div class="fw-bold text-primary">
                                <fmt:formatDate value="${tour.startDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="icon-box"><i class="fas fa-user-shield"></i></div>
                            <small class="text-muted">Bảo hiểm</small>
                            <div class="fw-bold">Trọn gói</div>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-4 rounded-3 shadow-sm mb-4">
                    <h4 class="fw-bold border-start border-5 border-primary ps-3 mb-3">Mô Tả Chi Tiết</h4>
                    <p style="line-height: 1.8; color: #555; font-size: 1.05rem;">
                        ${tour.description}
                    </p>
                    
                    <h5 class="fw-bold mt-4"><i class="fas fa-route text-success"></i> Lịch Trình Dự Kiến</h5>
                    <ul class="list-group list-group-flush mt-3">
                        <li class="list-group-item"><strong class="text-primary">Ngày 01:</strong> Đón khách - Tham quan địa điểm A - Ăn trưa.</li>
                        <li class="list-group-item"><strong class="text-primary">Ngày 02:</strong> Khám phá địa điểm B - Gala Dinner tối.</li>
                        <li class="list-group-item"><strong class="text-primary">Ngày 03:</strong> Mua sắm đặc sản - Trả khách về điểm hẹn.</li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="booking-sidebar">
                    <div class="text-muted small text-uppercase fw-bold ls-1 mb-1">Giá trọn gói / khách</div>
                    <div class="price-tag mb-3 text-primary">
                        <fmt:formatNumber value="${tour.price}" type="currency" currencySymbol=""/> VNĐ
                    </div>
                    
                    <hr>

                    <div class="seat-counter-box">
                        <label class="small text-muted mb-1">Tình trạng chỗ hiện tại (Real-time)</label>
                        <div class="d-flex justify-content-center align-items-center gap-2">
                            <i class="fas fa-chair text-secondary"></i>
                            <span id="seat-${tour.id}" class="fs-4 fw-bold ${tour.currentCapacity >= tour.maxCapacity ? 'text-danger' : 'text-success'}">
                                ${tour.currentCapacity} / ${tour.maxCapacity}
                            </span>
                        </div>
                        <div class="progress mt-2" style="height: 6px;">
                            <c:set var="percent" value="${(tour.currentCapacity * 100) / tour.maxCapacity}"/>
                            <div class="progress-bar ${percent >= 100 ? 'bg-danger' : 'bg-success'}" 
                                 role="progressbar" style="width: ${percent}%"></div>
                        </div>
                        <small class="text-danger mt-1 d-block fst-italic">*Dữ liệu cập nhật liên tục</small>
                    </div>

                    <c:if test="${sessionScope.account == null}">
                        <div class="alert alert-warning text-center small">
                            <i class="fas fa-lock"></i> Bạn cần đăng nhập để đặt vé
                        </div>
                        <a href="login" class="btn btn-outline-primary w-100 rounded-pill fw-bold">Đăng Nhập Ngay</a>
                    </c:if>

                    <c:if test="${sessionScope.account != null}">
                        <c:if test="${tour.currentCapacity < tour.maxCapacity}">
                            <form action="booking" method="post">
                                <input type="hidden" name="tour_id" value="${tour.id}">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold">Thông tin khách hàng:</label>
                                    <input type="text" class="form-control bg-light" value="${sessionScope.account.fullName}" readonly>
                                    <input type="text" class="form-control bg-light mt-2" value="${sessionScope.account.phoneNumber}" readonly>
                                </div>
                                <button type="submit" class="btn btn-book-now w-100 btn-lg">
                                    <i class="fas fa-paper-plane me-2"></i> XÁC NHẬN ĐẶT VÉ
                                </button>
                                <p class="text-center small text-muted mt-2">Không thanh toán ngay - Giữ chỗ miễn phí</p>
                            </form>
                        </c:if>
                        
                        <c:if test="${tour.currentCapacity >= tour.maxCapacity}">
                            <button class="btn btn-secondary w-100 btn-lg rounded-pill" disabled>
                                <i class="fas fa-ban"></i> ĐÃ HẾT CHỖ
                            </button>
                            <div class="text-center mt-2 small text-muted">Vui lòng chọn ngày khác hoặc tour khác</div>
                        </c:if>
                    </c:if>

                    <div class="mt-4 pt-3 border-top text-center">
                        <small class="text-muted">Cần hỗ trợ? Gọi ngay</small><br>
                        <strong class="text-dark fs-5"><i class="fas fa-phone-alt text-primary"></i> 1900 1234</strong>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

    <footer class="bg-dark text-light text-center py-4 mt-auto">
        <div class="container">
            <p class="mb-0 small opacity-75">&copy; 2024 Travel Booking System. Professional Edition.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // WebSocket Script
        var socket = new WebSocket("ws://26.70.226.190:8080/TourRealtimeSystem/ws");

        socket.onopen = function(event) {
            console.log("WebSocket Detail Page Connected!");
        };

        socket.onmessage = function(event) {
            var msg = event.data; 
            if (msg.startsWith("UPDATE:")) {
                var parts = msg.split(":");
                var tourId = parts[1];
                var newCount = parts[2];
                
                if (tourId == "${tour.id}") {
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
            }
        };
    </script>
</body>
</html>