<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body { background-color: #f0f2f5; font-family: 'Nunito', sans-serif; }
        .navbar { background: linear-gradient(to right, #00c6ff, #0072ff); box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .navbar-brand { font-family: 'Montserrat', sans-serif; font-weight: 800; }
        
        .profile-card { border: none; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); background: white; overflow: hidden; }
        .avatar-box { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; color: white; }
        .avatar-img { width: 120px; height: 120px; border-radius: 50%; border: 4px solid rgba(255,255,255,0.3); object-fit: cover; margin-bottom: 15px; }
        .nav-pills .nav-link { color: #555; font-weight: 600; border-radius: 10px; margin-bottom: 5px; text-align: left; padding: 12px 20px; }
        .nav-pills .nav-link.active { background-color: #0072ff; color: white; }
        .nav-pills .nav-link:hover:not(.active) { background-color: #f8f9fa; }
        .form-control { border-radius: 10px; padding: 10px 15px; }
        .btn-save { background: #0072ff; border: none; padding: 10px 25px; border-radius: 25px; font-weight: bold; }
        .btn-save:hover { background: #005bb5; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark mb-4 sticky-top">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-paper-plane me-2"></i>TRAVEL BOOKING</a>
            <div class="ms-auto">
                <a href="home" class="btn btn-outline-light rounded-pill btn-sm"><i class="fas fa-home"></i> Trang Chủ</a>
                <a href="logout" class="btn btn-danger rounded-pill btn-sm ms-2"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="successMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.errorMsg}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-times-circle me-2"></i> ${sessionScope.errorMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="profile-card h-100">
                    <div class="avatar-box">
                        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Avatar" class="avatar-img">
                        <h4 class="fw-bold" style="font-family: 'Montserrat', sans-serif;">${sessionScope.account.username}</h4>
                        <p class="mb-0 opacity-75">${sessionScope.account.role}</p>
                    </div>
                    <div class="p-4">
                        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                            <button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab">
                                <i class="fas fa-user-circle me-2"></i> Thông Tin Chung
                            </button>
                            <button class="nav-link" id="v-pills-password-tab" data-bs-toggle="pill" data-bs-target="#v-pills-password" type="button" role="tab">
                                <i class="fas fa-key me-2"></i> Đổi Mật Khẩu
                            </button>
                            <a href="history" class="nav-link">
                                <i class="fas fa-history me-2"></i> Lịch Sử Đặt Tour
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="tab-content" id="v-pills-tabContent">
                    
                    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel">
                        <div class="profile-card p-4">
                            <h4 class="fw-bold mb-4 text-primary border-bottom pb-2">Chỉnh Sửa Thông Tin</h4>
                            
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="updateInfo">
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold small text-muted">Tên Đăng Nhập (Không thể đổi)</label>
                                    <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" disabled>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold">Họ và Tên</label>
                                        <input type="text" name="fullname" class="form-control" value="${sessionScope.account.fullName}" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold">Số Điện Thoại</label>
                                        <input type="text" name="phone" class="form-control" value="${sessionScope.account.phoneNumber}" pattern="[0-9]{10,11}" required>
                                    </div>
                                </div>
                                
                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-primary btn-save shadow">
                                        <i class="fas fa-save me-2"></i> Lưu Thay Đổi
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="v-pills-password" role="tabpanel">
                        <div class="profile-card p-4">
                            <h4 class="fw-bold mb-4 text-danger border-bottom pb-2">Thay Đổi Mật Khẩu</h4>
                            
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="changePass">
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Mật khẩu hiện tại</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="fas fa-lock"></i></span>
                                        <input type="password" name="oldPass" class="form-control" placeholder="Nhập mật khẩu cũ" required>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Mật khẩu mới</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="fas fa-key"></i></span>
                                        <input type="password" name="newPass" class="form-control" placeholder="Mật khẩu mới" required>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Xác nhận mật khẩu mới</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="fas fa-check-circle"></i></span>
                                        <input type="password" name="confirmPass" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
                                    </div>
                                </div>
                                
                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-danger btn-save shadow">
                                        <i class="fas fa-exchange-alt me-2"></i> Đổi Mật Khẩu
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>