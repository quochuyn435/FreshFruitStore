<%-- 
    Document   : checkout
    Created on : Oct 30, 2026, 10:05:52 AM
    Author     : livsu
--%>

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
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4 text-success fw-bold">Thông tin giao hàng</h2>
        
        <div class="row g-4">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <!-- Form Checkout -->
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Họ và tên người nhận</label>
                            <input type="text" name="receiverName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" name="receiverPhone" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Địa chỉ giao hàng chi tiết</label>
                            <textarea name="shippingAddress" class="form-control" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ghi chú đơn hàng (Không bắt buộc)</label>
                            <textarea name="orderNote" class="form-control" rows="2"></textarea>
                        </div>
                        
                        <h4 class="mt-4 mb-3 fw-bold">Phương thức thanh toán</h4>
                        <div class="form-check mb-2">
                            <!-- Lựa chọn COD hoặc Chuyển khoản[cite: 12] -->
                            <input class="form-check-input" type="radio" name="paymentMethod" value="COD" checked>
                            <label class="form-check-label">Thanh toán khi nhận hàng (COD)</label>
                        </div>
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="radio" name="paymentMethod" value="BANK_TRANSFER">
                            <label class="form-check-label">Chuyển khoản VietQR / VNPay</label>
                        </div>

                        <button type="submit" class="btn btn-success btn-lg w-100">Xác nhận Đặt hàng</button>
                    </form>
                </div>
            </div>
            
            <!-- Cột hiển thị tóm tắt giỏ hàng bên phải (Tùy chọn) -->
            <div class="col-md-4">
                <div class="card bg-white border-0 shadow-sm">
                    <div class="card-body">
                        <h5>Tổng tiền tạm tính:</h5>
                        <!-- Lấy tổng tiền từ Session Giỏ hàng[cite: 12] -->
                        <h3 class="text-danger">${sessionScope.cart.totalAmount} VNĐ</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
