<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Booking - Khám Phá Việt Nam</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700;800&family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body { background-color: #f4f7f6; font-family: 'Nunito', sans-serif; }
        
        h1, h2, h3, h4, h5, .navbar-brand, .hero-title, .btn {
            font-family: 'Montserrat', sans-serif; letter-spacing: -0.5px;
        }
        
        /* Navbar */
        .navbar {
            background: linear-gradient(to right, #00c6ff, #0072ff);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .navbar-brand { font-weight: 800; font-size: 1.5rem; }

        /* Hero Banner */
        .hero-section {
            background: url('https://images.unsplash.com/photo-1504214208698-ea1916a2195a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') no-repeat center center;
            background-size: cover; height: 400px; position: relative;
            border-radius: 0 0 50px 50px; margin-bottom: 40px;
            display: flex; align-items: center; justify-content: center;
            color: white; text-align: center;
        }
        .hero-overlay {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.3), rgba(0,0,0,0.6));
            border-radius: 0 0 50px 50px;
        }
        .hero-content { position: relative; z-index: 1; }
        .hero-title { font-size: 3.5rem; font-weight: 800; text-shadow: 2px 4px 8px rgba(0,0,0,0.6); margin-bottom: 10px; }

        /* Card & Elements */
        .tour-card { border: none; border-radius: 20px; transition: 0.3s; background: white; overflow: hidden; box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .tour-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0,0,0,0.15); }
        .card-img-wrapper { position: relative; overflow: hidden; height: 220px; }
        .card-img-top { width: 100%; height: 100%; object-fit: cover; transition: 0.5s; }
        .tour-card:hover .card-img-top { transform: scale(1.1); }
        
        .price-tag {
            position: absolute; bottom: 10px; right: 10px;
            background: rgba(0,0,0,0.8); backdrop-filter: blur(5px);
            color: #fff; padding: 5px 15px; border-radius: 20px;
            font-weight: 700; font-size: 1.1rem; font-family: 'Montserrat', sans-serif;
        }

        .capacity-box { background: #f8f9fa; border-radius: 10px; padding: 10px; margin-top: 15px; }
        
        .btn-custom { border-radius: 50px; padding: 10px 0; font-weight: 700; text-transform: uppercase; font-size: 0.9rem; transition: 0.3s; }
        .btn-booking { background: linear-gradient(to right, #11998e, #38ef7d); border: none; color: white; }
        .btn-booking:hover { background: linear-gradient(to right, #0e8c82, #2dd66e); color: white; }
        
        .highlight-update { animation: flashUpdate 1.5s ease-in-out; background-color: #ffeeba !important; color: #856404 !important; border-radius: 5px; padding: 0 5px; }
        @keyframes flashUpdate { 0% { background-color: #fff3cd; transform: scale(1); } 50% { background-color: #ffc107; transform: scale(1.2); } 100% { background-color: transparent; transform: scale(1); } }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-paper-plane me-2"></i>TRAVEL BOOKING</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    
                    <c:if test="${sessionScope.account == null}">
                        <li class="nav-item"><a class="nav-link text-white fw-bold" href="login"><i class="fas fa-sign-in-alt"></i> Đăng Nhập</a></li>
                        <li class="nav-item"><a class="btn btn-light text-primary rounded-pill ms-2 fw-bold" href="register">Đăng Ký Ngay</a></li>
                    </c:if>

                    <c:if test="${sessionScope.account != null}">
                        <c:if test="${sessionScope.account.role == 'ADMIN'}">
                            <li class="nav-item me-2">
                                <a class="btn btn-outline-light rounded-pill btn-sm" href="manager"><i class="fas fa-user-shield"></i> Quản Lý</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.account.role == 'CUSTOMER'}">
                            <li class="nav-item me-2">
                                <a class="nav-link text-white fw-bold" href="history"><i class="fas fa-history"></i> Lịch Sử</a>
                            </li>
                        </c:if>

                        <li class="nav-item border-start ps-3 ms-2 d-flex align-items-center">
                            <a href="profile" class="btn btn-outline-light border-0 rounded-pill btn-sm me-2 fw-bold" title="Xem hồ sơ cá nhân">
                                <i class="fas fa-user-circle me-1"></i> ${sessionScope.account.fullName}
                            </a>
                            <a class="btn btn-sm btn-danger rounded-circle" href="logout" title="Đăng xuất">
                                <i class="fas fa-power-off"></i>
                            </a>
                        </li>
                        </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="hero-section">
        <div class="hero-overlay"></div>
        <div class="hero-content container">
            <h1 class="hero-title">Vẻ Đẹp Việt Nam</h1>
            <p class="lead mt-3 fw-bold">Trải nghiệm những hành trình tuyệt vời nhất cùng chúng tôi</p>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <div class="d-flex align-items-center">
                    <i class="fas fa-check-circle fa-2x me-3"></i>
                    <div>
                        <h5 class="alert-heading mb-1 fw-bold">Thành Công!</h5>
                        <span>${sessionScope.successMsg}</span>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="successMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMsg}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> <strong>${sessionScope.errorMsg}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMsg" scope="session"/>
        </c:if>
    </div>

    <div class="container mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark border-start border-5 border-primary ps-3">Danh Sách Tour Mới Nhất</h3>
        </div>

        <div class="row">
            <c:forEach items="${listT}" var="o">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card tour-card h-100">
                        <div class="card-img-wrapper">
                            <img src="${o.imageUrl}" class="card-img-top" alt="Tour Image">
                            <div class="price-tag">
                                <fmt:formatNumber value="${o.price}" type="currency" currencySymbol=""/> VNĐ
                            </div>
                        </div>
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold text-dark">${o.name}</h5>
                            <p class="card-text text-muted small mb-2">
                                <i class="fas fa-map-marker-alt text-danger me-1"></i> ${o.location}
                            </p>
                            
                            <div class="capacity-box mt-auto">
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="fw-bold text-secondary">Trạng thái chỗ:</small>
                                    <span id="seat-${o.id}" class="fw-bold ${o.currentCapacity >= o.maxCapacity ? 'text-danger' : 'text-success'}">
                                        ${o.currentCapacity} / ${o.maxCapacity}
                                    </span>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <c:set var="percent" value="${(o.currentCapacity * 100) / o.maxCapacity}"/>
                                    <div class="progress-bar ${percent >= 100 ? 'bg-danger' : 'bg-success'}" 
                                         role="progressbar" style="width: ${percent}%"></div>
                                </div>
                            </div>
                            
                            <a href="detail?id=${o.id}" class="btn btn-outline-dark btn-custom w-100 mt-3 btn-sm">
                                <i class="fas fa-info-circle"></i> Xem Chi Tiết
                            </a>
                        </div>

                        <div class="card-footer bg-white border-0 pb-3 pt-0">
                            <c:if test="${sessionScope.account == null}">
                                <a href="login" class="btn btn-secondary btn-custom w-100">
                                    <i class="fas fa-lock"></i> Đăng nhập để đặt
                                </a>
                            </c:if>

                            <c:if test="${sessionScope.account != null}">
                                <c:if test="${o.currentCapacity < o.maxCapacity}">
                                    <form action="booking" method="post">
                                        <input type="hidden" name="tour_id" value="${o.id}">
                                        <button type="submit" class="btn btn-booking btn-custom w-100 shadow-sm">
                                            <i class="fas fa-paper-plane"></i> Đặt Vé Ngay
                                        </button>
                                    </form>
                                </c:if>
                                
                                <c:if test="${o.currentCapacity >= o.maxCapacity}">
                                    <button class="btn btn-danger btn-custom w-100" disabled>
                                        <i class="fas fa-times-circle"></i> Đã Hết Chỗ
                                    </button>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="bg-dark text-light text-center py-4 mt-auto">
        <div class="container">
            <p class="mb-0 small opacity-75">&copy; 2024 Travel Booking System. Realtime Technology by WebSocket.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        var socket = new WebSocket("ws://26.70.226.190:8080/TourRealtimeSystem/ws");
        socket.onopen = function(event) { console.log("WebSocket Connected!"); };

        socket.onmessage = function(event) {
            var msg = event.data;
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
                    setTimeout(() => { spanElement.classList.remove("highlight-update"); }, 1500);
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