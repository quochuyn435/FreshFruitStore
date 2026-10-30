<%-- 
    Document   : register
    Created on : Oct 30, 2026, 11:41:21 AM
    Author     : livsu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng ký - FreshFruit Store</title>
    <!-- Nhúng Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center" style="min-height: 100vh; padding: 40px 0;">
    
    <div class="card shadow p-4" style="width: 450px;">
        <h3 class="text-center text-success mb-4">Tạo Tài Khoản</h3>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Tên đăng nhập</label>
                <input type="text" class="form-control" name="username" placeholder="Nhập tên đăng nhập" required />
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Mật khẩu</label>
                <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" required />
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Họ và tên</label>
                <input type="text" class="form-control" name="fullname" placeholder="Ví dụ: Nguyễn Văn A" required />
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Số điện thoại</label>
                <input type="text" class="form-control" name="phone" placeholder="Ví dụ: 0912345678" required />
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Địa chỉ giao hàng</label>
                <textarea class="form-control" name="address" rows="2" placeholder="Số nhà, Đường, Phường/Xã..." required></textarea>
            </div>
            
            <!-- Hiển thị báo đỏ nếu tên đăng nhập đã bị người khác chọn -->
            <p class="text-danger text-center mb-3">${error}</p>
            
            <button type="submit" class="btn btn-success w-100 mb-3">Đăng ký</button>
        </form>
        
        <!-- Nút quay lại trang đăng nhập -->
        <div class="text-center">
            <span>Đã có tài khoản? </span>
            <a href="${pageContext.request.contextPath}/login.jsp" class="text-success text-decoration-none fw-bold">Đăng nhập ngay</a>
        </div>
    </div>

</body>
</html>
