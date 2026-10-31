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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - FreshFruit Store</title>
    <!-- Nhúng Bootstrap để form đẹp ngay lập tức -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body class="bg-light ff-auth-body d-flex flex-column justify-content-center align-items-center" style="min-height: 100vh; padding: 24px;">
    
    <!-- Nút điều hướng nhanh về Trang chủ / Cửa hàng -->
    <div class="mb-3 text-center">
        <a href="${pageContext.request.contextPath}/index.html" class="ff-brand text-decoration-none">
            <span class="brand-badge"><i class="bi bi-basket2-fill"></i></span>
            <span>FreshFruit Store</span>
        </a>
    </div>

    <div class="card ff-auth-card shadow p-4 p-md-5" style="width: 100%; max-width: 420px;">
        <div class="text-center mb-2">
            <span class="badge bg-success-subtle text-success rounded-pill px-3 py-2 mb-2">
                <i class="bi bi-person-check-fill me-1"></i>Chào mừng trở lại
            </span>
        </div>
        <h3 class="text-center text-success fw-bold mb-4">Đăng Nhập</h3>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label small fw-semibold text-secondary">Tài khoản</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-success"><i class="bi bi-person"></i></span>
                    <input type="text" class="form-control border-start-0" name="username" placeholder="Tên đăng nhập" required />
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label small fw-semibold text-secondary">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-success"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control border-start-0" name="password" placeholder="Mật khẩu" required />
                </div>
            </div>
            
            <!-- Chỗ hiển thị lỗi báo đỏ nếu sai mật khẩu -->
            <p class="text-danger text-center mb-3 fw-semibold small">${error}</p>
            
            <button type="submit" class="btn btn-success w-100 py-2 mb-3">
                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
            </button>
        </form>
        
        <!-- Nút bẻ luồng sang trang đăng ký -->
        <div class="text-center border-top pt-3">
            <span>Chưa có tài khoản? </span>
            <a href="${pageContext.request.contextPath}/register.jsp" class="text-success text-decoration-none fw-bold">Đăng ký ngay</a>
        </div>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/shop" class="small text-secondary text-decoration-none">
                <i class="bi bi-arrow-left me-1"></i>Tiếp tục xem cửa hàng không cần đăng nhập
            </a>
        </div>
    </div>

</body>
</html>
