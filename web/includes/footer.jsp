<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Common Footer -->
<footer class="ff-footer mt-5">
    <div class="container">
        <div class="row g-4 pb-4 border-bottom border-secondary border-opacity-25">
            <div class="col-lg-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="badge bg-success p-2 rounded-3"><i class="bi bi-basket2-fill fs-5"></i></span>
                    <h5 class="text-white fw-bold mb-0">FreshFruit Store</h5>
                </div>
                <p class="small text-secondary mb-3">
                    Hệ thống cung cấp trái cây tươi sạch trong ngày, nguồn gốc rõ ràng đạt chuẩn VietGAP & GlobalGAP, giao hàng siêu tốc trong 2 giờ.
                </p>
                <div class="d-flex gap-3">
                    <span class="badge bg-dark border border-secondary text-light px-3 py-2">
                        <i class="bi bi-patch-check-fill text-success me-1"></i>100% Tươi Sạch
                    </span>
                    <span class="badge bg-dark border border-secondary text-light px-3 py-2">
                        <i class="bi bi-truck text-warning me-1"></i>Giao Nhanh 2H
                    </span>
                </div>
            </div>

            <div class="col-6 col-lg-2 offset-lg-1">
                <h6 class="text-white fw-bold mb-3">Khám phá</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/index.html">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop">Cửa hàng trái cây</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng của bạn</a></li>
                    <li><a href="${pageContext.request.contextPath}/checkout.jsp">Thanh toán</a></li>
                </ul>
            </div>

            <div class="col-6 col-lg-2">
                <h6 class="text-white fw-bold mb-3">Tài khoản</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a></li>
                    <li><a href="${pageContext.request.contextPath}/register.jsp">Đăng ký thành viên</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-orders.jsp">Tra cứu đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin-order.jsp">Admin Portal</a></li>
                </ul>
            </div>

            <div class="col-lg-3">
                <h6 class="text-white fw-bold mb-3">Liên hệ hỗ trợ</h6>
                <ul class="list-unstyled small text-secondary d-flex flex-column gap-2">
                    <li><i class="bi bi-geo-alt-fill text-success me-2"></i>Khu CNC Hòa Lạc / FPT University</li>
                    <li><i class="bi bi-telephone-fill text-success me-2"></i>Hotline: 1900 6868 (8:00 - 21:00)</li>
                    <li><i class="bi bi-envelope-fill text-success me-2"></i>support@freshfruit.vn</li>
                </ul>
            </div>
        </div>

        <div class="d-flex flex-wrap justify-content-between align-items-center pt-3 small text-secondary">
            <span>&copy; 2026 FreshFruit Store - PRJ301 Project. All rights reserved.</span>
            <span>Hỗ trợ thanh toán: COD &bull; VietQR &bull; VNPay</span>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
