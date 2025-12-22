<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng Nhập</title>
        <style>
            body { font-family: Arial, sans-serif; display: flex; justify-content: center; margin-top: 50px; }
            .container { border: 1px solid #ccc; padding: 20px; border-radius: 5px; width: 300px; }
            input { width: 100%; margin-bottom: 10px; padding: 8px; box-sizing: border-box; }
            button { width: 100%; padding: 10px; background: #28a745; color: white; border: none; cursor: pointer; }
            .error { color: red; font-size: 14px; }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 style="text-align: center">Đăng Nhập</h2>
            <p class="error">${mess}</p> <form action="login" method="post">
                <label>Tên đăng nhập:</label>
                <input type="text" name="user" required>
                
                <label>Mật khẩu:</label>
                <input type="password" name="pass" required>
                
                <button type="submit">Đăng Nhập</button>
            </form>
            <p style="text-align: center">Chưa có tài khoản? <a href="register">Đăng ký ngay</a></p>
        </div>
    </body>
</html>