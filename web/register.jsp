<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng Ký</title>
        <style>
            body { font-family: Arial, sans-serif; display: flex; justify-content: center; margin-top: 50px; }
            .container { border: 1px solid #ccc; padding: 20px; border-radius: 5px; width: 350px; }
            input { width: 100%; margin-bottom: 10px; padding: 8px; box-sizing: border-box; }
            button { width: 100%; padding: 10px; background: #007bff; color: white; border: none; cursor: pointer; }
            .error { color: red; }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 style="text-align: center">Đăng Ký Tài Khoản</h2>
            <p class="error">${mess}</p>
            
            <form action="register" method="post">
                <label>Họ và tên:</label>
                <input type="text" name="fullname" required>
                
                <label>Tên đăng nhập:</label>
                <input type="text" name="user" required>
                
                <label>Mật khẩu:</label>
                <input type="password" name="pass" required>

                <label>Nhập lại mật khẩu:</label>
                <input type="password" name="re_pass" required>
                
                <button type="submit">Đăng Ký</button>
            </form>
            <p style="text-align: center">Đã có tài khoản? <a href="login">Đăng nhập</a></p>
        </div>
    </body>
</html>