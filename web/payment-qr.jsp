<%-- 
    Document   : payment-qr
    Description: Trang Sinh mã VietQR & Xác nhận Thanh toán (Dành cho Dev 4)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán VietQR - FreshFruit Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4">
        <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 mx-auto bg-white" style="max-width: 820px;">
            <div class="text-center mb-4">
                <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill mb-2">
                    <i class="bi bi-check-circle-fill me-1"></i>Đặt hàng thành công
                </span>
                <h3 class="fw-bold text-dark">Thanh Toán Chuyển Khoản VietQR</h3>
                <p class="text-secondary mb-0">
                    Quét mã QR bên dưới bằng ứng dụng Ngân hàng để thanh toán tự động đúng số tiền và nội dung.
                </p>
            </div>

            <div class="row g-4 align-items-center">
                <!-- Cột Mã QR VietQR -->
                <div class="col-md-6 text-center">
                    <div class="p-3 border rounded-4 bg-light d-inline-block shadow-sm">
                        <img src="${not empty qrUrl ? qrUrl : 'https://img.vietqr.io/image/MB-0123456789-compact2.png?amount=290000&addInfo=THANH%20TOAN%20DON%20HANG%20101&accountName=FRESHFRUIT%20STORE'}"
                             alt="Mã thanh toán VietQR"
                             class="img-fluid rounded-3"
                             style="max-width: 280px;">
                    </div>
                </div>

                <!-- Cột Thông tin chuyển khoản -->
                <div class="col-md-6">
                    <div class="p-3 rounded-4 bg-light border mb-3">
                        <div class="small text-secondary mb-1">Mã đơn hàng</div>
                        <div class="fw-bold fs-5 text-success">#${not empty order ? order.orderId : '101'}</div>
                        <hr class="my-2">
                        <div class="small text-secondary mb-1">Số tiền cần thanh toán</div>
                        <div class="fw-bold fs-4 text-danger">${not empty order ? order.totalAmount : '290000.0'} VNĐ</div>
                        <hr class="my-2">
                        <div class="small text-secondary mb-1">Nội dung chuyển khoản</div>
                        <div class="fw-bold text-dark">THANH TOAN DON HANG #${not empty order ? order.orderId : '101'}</div>
                    </div>

                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/my-orders.jsp" class="btn btn-success py-2">
                            <i class="bi bi-check2-all me-1"></i>Tôi đã hoàn tất chuyển khoản
                        </a>
                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-secondary py-2">
                            <i class="bi bi-shop me-1"></i>Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
