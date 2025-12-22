<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* CSS dùng chung giống trang Register */
        body { 
            background: linear-gradient(135deg, #71b7e6, #9b59b6); 
            height: 100vh; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
        }
        .card { 
            border-radius: 15px; 
            box-shadow: 0 10px 20px rgba(0,0,0,0.2); 
            overflow: hidden; 
            width: 100%;
            max-width: 400px;
        }
        .form-control { 
            border-radius: 20px; 
            padding: 10px 20px; 
        }
        .btn-login { 
            border-radius: 20px; 
            padding: 10px; 
            font-weight: bold; 
            background: #9b59b6; 
            border: none; 
            transition: 0.3s;
        }
        .btn-login:hover { 
            background: #8e44ad; 
            transform: scale(1.02);
        }
        .icon-header {
            font-size: 50px;
            color: #9b59b6;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 d-flex justify-content-center">
                <div class="card bg-white p-4">
                    
                    <div class="text-center mb-4">
                        <div class="icon-header"><i class="fas fa-user-circle"></i></div>
                        <h3 class="text-primary fw-bold" style="color: #9b59b6 !important;">ĐĂNG NHẬP</h3>
                        <p class="text-muted">Chào mừng bạn quay trở lại</p>
                    </div>
                    
                    <c:if test="${not empty mess}">
                        <div class="alert alert-danger text-center p-2" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> ${mess}
                        </div>
                    </c:if>

                    <c:if test="${not empty sessionScope.successMsg}">
                        <div class="alert alert-success text-center p-2" role="alert">
                            <i class="fas fa-check-circle"></i> ${sessionScope.successMsg}
                        </div>
                        <c:remove var="successMsg" scope="session"/>
                    </c:if>
                    
                    <form action="login" method="post">
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0 rounded-start-pill ps-3">
                                    <i class="fas fa-user text-muted"></i>
                                </span>
                                <input type="text" name="user" class="form-control" placeholder="Tên đăng nhập" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0 rounded-start-pill ps-3">
                                    <i class="fas fa-lock text-muted"></i>
                                </span>
                                <input type="password" name="pass" class="form-control" placeholder="Mật khẩu" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-login w-100 text-white mt-3">
                            <i class="fas fa-sign-in-alt me-2"></i> ĐĂNG NHẬP
                        </button>
                    </form>
                    
                    <div class="text-center mt-4">
                        <p class="mb-1">Chưa có tài khoản?</p>
                        <a href="register" class="text-decoration-none fw-bold" style="color: #9b59b6;">Đăng ký ngay</a>
                    </div>
                    <div class="text-center mt-3">
                        <a href="home" class="text-secondary small"><i class="fas fa-arrow-left"></i> Về trang chủ</a>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

</body>
</html>