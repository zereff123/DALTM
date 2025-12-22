<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background: linear-gradient(135deg, #71b7e6, #9b59b6); height: 100vh; display: flex; align-items: center; justify-content: center; }
        .card { border-radius: 15px; box-shadow: 0 10px 20px rgba(0,0,0,0.2); overflow: hidden; }
        .form-control { border-radius: 20px; padding: 10px 20px; }
        .btn-register { border-radius: 20px; padding: 10px; font-weight: bold; background: #9b59b6; border: none; }
        .btn-register:hover { background: #8e44ad; }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card bg-white p-4">
                    <div class="text-center mb-4">
                        <h3 class="text-primary fw-bold"><i class="fas fa-user-plus"></i> ĐĂNG KÝ</h3>
                        <p class="text-muted">Tạo tài khoản để đặt tour ngay</p>
                    </div>
                    
                    <c:if test="${not empty mess}">
                        <div class="alert alert-danger text-center">${mess}</div>
                    </c:if>

                    <form action="register" method="post">
                        <div class="mb-3">
                            <input type="text" name="user" class="form-control" placeholder="Tên đăng nhập" value="${user}" required>
                        </div>
                        
                        <div class="mb-3">
                            <input type="password" name="pass" class="form-control" placeholder="Mật khẩu" required>
                        </div>
                        
                        <div class="mb-3">
                            <input type="password" name="repass" class="form-control" placeholder="Nhập lại mật khẩu" required>
                        </div>

                        <div class="mb-3">
                            <input type="text" name="fullname" class="form-control" placeholder="Họ và tên đầy đủ" value="${fullname}" required>
                        </div>

                        <div class="mb-3">
                            <input type="text" name="phone" class="form-control" placeholder="Số điện thoại liên hệ" value="${phone}" required pattern="[0-9]{10,11}" title="Vui lòng nhập 10-11 số">
                        </div>

                        <button type="submit" class="btn btn-primary btn-register w-100 text-white mt-2">
                            ĐĂNG KÝ NGAY
                        </button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <a href="login" class="text-decoration-none">Đã có tài khoản? Đăng nhập</a>
                    </div>
                    <div class="text-center mt-2">
                        <a href="home" class="text-secondary"><i class="fas fa-arrow-left"></i> Về trang chủ</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>