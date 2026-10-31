<%-- 
    Document   : checkout
    Created on : Oct 30, 2026, 10:05:52 AM
    Author     : livsu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - FreshFruit</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Header chung -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-5">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-4">
            <h2 class="mb-0 text-success fw-bold"><i class="bi bi-truck me-2"></i>Thông tin giao hàng</h2>
            <a href="${pageContext.request.contextPath}/cart.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="bi bi-arrow-left me-1"></i>Quay lại giỏ hàng
            </a>
        </div>
        
        <div class="row g-4">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <!-- Form Checkout -->
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold"><i class="bi bi-person text-success me-1"></i>Họ và tên người nhận</label>
                            <input type="text" name="receiverName" value="${sessionScope.account.fullName}" class="form-control" placeholder="Nhập họ và tên người nhận hàng" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold"><i class="bi bi-telephone text-success me-1"></i>Số điện thoại</label>
                            <input type="text" name="receiverPhone" value="${sessionScope.account.phone}" class="form-control" placeholder="Nhập số điện thoại liên hệ khi giao hàng" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold"><i class="bi bi-geo-alt text-success me-1"></i>Địa chỉ giao hàng chi tiết</label>
                            <textarea name="shippingAddress" class="form-control" rows="3" placeholder="Số nhà, ngõ/ngách, đường, phường/xã, quận/huyện..." required>${sessionScope.account.address}</textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold"><i class="bi bi-chat-left-text text-success me-1"></i>Ghi chú đơn hàng (Không bắt buộc)</label>
                            <textarea name="orderNote" class="form-control" rows="2" placeholder="Ví dụ: Giao trong giờ hành chính, chọn quả chín vừa..."></textarea>
                        </div>
                        
                        <h4 class="mt-4 mb-3 fw-bold text-dark"><i class="bi bi-wallet2 text-success me-2"></i>Phương thức thanh toán</h4>
                        <div class="form-check p-3 mb-2 border rounded-3 bg-light">
                            <!-- Lựa chọn COD hoặc Chuyển khoản[cite: 12] -->
                            <input class="form-check-input ms-0 me-2" type="radio" name="paymentMethod" id="payCOD" value="COD" checked>
                            <label class="form-check-label fw-semibold" for="payCOD">
                                <i class="bi bi-cash-coin text-success me-1"></i>Thanh toán khi nhận hàng (COD)
                            </label>
                        </div>
                        <div class="form-check p-3 mb-4 border rounded-3 bg-light">
                            <input class="form-check-input ms-0 me-2" type="radio" name="paymentMethod" id="payBank" value="BANK_TRANSFER">
                            <label class="form-check-label fw-semibold" for="payBank">
                                <i class="bi bi-qr-code-scan text-primary me-1"></i>Chuyển khoản VietQR / VNPay
                            </label>
                        </div>

                        <button type="submit" class="btn btn-success btn-lg w-100 py-3">
                            <i class="bi bi-check2-circle me-2"></i>Xác nhận Đặt hàng
                        </button>
                    </form>
                </div>
            </div>
            
            <!-- Cột hiển thị tóm tắt giỏ hàng bên phải (Tùy chọn) -->
            <div class="col-md-4">
                <div class="card bg-white border-0 shadow-sm p-2">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3"><i class="bi bi-receipt text-success me-2"></i>Tổng tiền tạm tính:</h5>
                        <!-- Lấy tổng tiền từ Session Giỏ hàng[cite: 12] -->
                        <h3 class="text-danger fw-bold mb-3">${sessionScope.cart.totalAmount} VNĐ</h3>

                        <hr>
                        <div class="small text-secondary mb-3">
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <i class="bi bi-shield-check text-success fs-5"></i>
                                <span>Đảm bảo trái cây tươi ngon 100% khi giao tới tay khách hàng.</span>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-qr-code text-primary fs-5"></i>
                                <span>Nếu chọn VietQR, mã QR tự động kèm số tiền sẽ hiển thị ở bước tiếp theo.</span>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/payment-qr.jsp" class="btn btn-outline-success btn-sm w-100">
                            <i class="bi bi-qr-code-scan me-1"></i>Xem trước màn hình mã VietQR (Dev 4)
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
