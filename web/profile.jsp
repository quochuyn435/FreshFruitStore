<%-- 
    Document   : profile
    Description: Trang Thông tin cá nhân & Chỉnh sửa thông tin dành cho User (Module Dev 1)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - FreshFruit Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4 pb-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="text-success fw-bold mb-1"><i class="bi bi-person-vcard me-2"></i>Hồ Sơ Cá Nhân</h2>
                <p class="text-secondary small mb-0">Quản lý và cập nhật thông tin tài khoản, số điện thoại và địa chỉ nhận hàng của bạn.</p>
            </div>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-success rounded-pill px-4">
                <i class="bi bi-shop me-1"></i>Về Cửa hàng
            </a>
        </div>

        <div class="row g-4">
            <!-- Cột Trái: Thẻ Tóm tắt Tài khoản -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 text-center bg-white rounded-4 h-100">
                    <div class="mx-auto mb-3 d-flex align-items-center justify-content-center rounded-circle bg-success-subtle text-success fw-bold" style="width: 90px; height: 90px; font-size: 2.2rem;">
                        <i class="bi bi-person-circle"></i>
                    </div>
                    <h5 class="fw-bold mb-1">
                        ${not empty sessionScope.account.fullName ? sessionScope.account.fullName : 'Nguyễn Văn A'}
                    </h5>
                    <p class="text-secondary small mb-2">
                        @${not empty sessionScope.account.username ? sessionScope.account.username : 'customer'}
                    </p>
                    <div class="mb-3">
                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-1">
                            <i class="bi bi-patch-check-fill me-1"></i>${not empty sessionScope.account.role ? sessionScope.account.role : 'Customer'}
                        </span>
                    </div>

                    <hr>
                    <div class="text-start small text-secondary d-flex flex-column gap-2">
                        <div>
                            <i class="bi bi-telephone-fill text-success me-2"></i>
                            <strong>SĐT:</strong> ${not empty sessionScope.account.phone ? sessionScope.account.phone : '0912345678'}
                        </div>
                        <div>
                            <i class="bi bi-geo-alt-fill text-success me-2"></i>
                            <strong>Địa chỉ:</strong> ${not empty sessionScope.account.address ? sessionScope.account.address : 'Hà Nội, Việt Nam'}
                        </div>
                    </div>

                    <div class="mt-auto pt-4">
                        <a href="${pageContext.request.contextPath}/my-orders.jsp" class="btn btn-outline-success w-100">
                            <i class="bi bi-receipt-cutoff me-1"></i>Xem Lịch sử Đơn hàng
                        </a>
                    </div>
                </div>
            </div>

            <!-- Cột Phải: Form Chỉnh sửa Thông tin Cá nhân & Đổi mật khẩu -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm p-4 bg-white rounded-4 mb-4">
                    <h5 class="fw-bold text-success mb-3">
                        <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa Thông tin Cá nhân
                    </h5>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small"><i class="bi bi-check-circle-fill me-1"></i>${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small"><i class="bi bi-exclamation-triangle-fill me-1"></i>${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="userId" value="${sessionScope.account.userId}">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Tên đăng nhập (Không thể đổi)</label>
                                <input type="text" name="username" class="form-control bg-light" value="${not empty sessionScope.account.username ? sessionScope.account.username : 'customer'}" readonly>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" value="${not empty sessionScope.account.fullName ? sessionScope.account.fullName : ''}" placeholder="Nhập họ và tên đầy đủ" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Số điện thoại liên hệ</label>
                                <input type="text" name="phone" class="form-control" value="${not empty sessionScope.account.phone ? sessionScope.account.phone : ''}" placeholder="Ví dụ: 0912345678" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Mật khẩu mới (Để trống nếu giữ nguyên)</label>
                                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu mới nếu muốn đổi">
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-semibold">Địa chỉ nhận hàng mặc định</label>
                                <textarea name="address" class="form-control" rows="3" placeholder="Số nhà, Đường, Phường/Xã, Quận/Huyện, Tỉnh/Thành phố..." required>${not empty sessionScope.account.address ? sessionScope.account.address : ''}</textarea>
                            </div>

                            <div class="col-12 text-end mt-3">
                                <button type="submit" class="btn btn-success px-4 py-2">
                                    <i class="bi bi-floppy-fill me-1"></i>Lưu Thay Đổi
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
