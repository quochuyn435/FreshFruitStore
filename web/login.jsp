<%-- 
    Document   : login
    Created on : Oct 30, 2026, 11:39:19 AM
    Author     : livsu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập - FreshFruit Store</title>
    <!-- Nhúng Bootstrap để form đẹp ngay lập tức -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center" style="height: 100vh;">
    
    <div class="card shadow p-4" style="width: 400px;">
        <h3 class="text-center text-success mb-4">Đăng Nhập</h3>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="username" placeholder="Tên đăng nhập" required />
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Mật khẩu" required />
            </div>
            
            <!-- Chỗ hiển thị lỗi báo đỏ nếu sai mật khẩu -->
            <p class="text-danger text-center mb-3">${error}</p>
            
            <button type="submit" class="btn btn-success w-100 mb-3">Đăng nhập</button>
        </form>
        
        <!-- Nút bẻ luồng sang trang đăng ký -->
        <div class="text-center">
            <span>Chưa có tài khoản? </span>
            <a href="${pageContext.request.contextPath}/register.jsp" class="text-success text-decoration-none fw-bold">Đăng ký ngay</a>
        </div>
    </div>

</body>
</html>
