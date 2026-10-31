<%-- 
    Document   : my-orders
    Description: Trang Lịch sử đơn hàng của Khách hàng (Dành cho Dev 4)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - FreshFruit Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="text-success fw-bold mb-1"><i class="bi bi-receipt-cutoff me-2"></i>Đơn Hàng Đã Đặt</h2>
                <p class="text-secondary small mb-0">Theo dõi tiến trình xác nhận và giao hàng các đơn trái cây của bạn.</p>
            </div>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-success rounded-pill px-4">
                <i class="bi bi-cart-plus me-1"></i>Đặt thêm đơn mới
            </a>
        </div>

        <div class="card border-0 shadow-sm p-3 bg-white">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-success">
                        <tr>
                            <th>Mã Đơn</th>
                            <th>Ngày đặt</th>
                            <th>Người nhận & Địa chỉ</th>
                            <th>Tổng tiền</th>
                            <th>Thanh toán</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listOrder}" var="o">
                            <tr>
                                <td class="fw-bold">#${o.orderId}</td>
                                <td>${o.orderDate}</td>
                                <td>
                                    <div class="fw-semibold">${o.receiverName} - ${o.receiverPhone}</div>
                                    <small class="text-secondary">${o.shippingAddress}</small>
                                </td>
                                <td class="text-danger fw-bold">${o.totalAmount} đ</td>
                                <td><span class="badge bg-light text-dark border">${o.paymentMethod}</span></td>
                                <td>
                                    <span class="badge ${o.orderStatus == 'Chờ xác nhận' ? 'bg-warning text-dark' : (o.orderStatus == 'Đã hủy' ? 'bg-danger' : 'bg-success')}">
                                        ${o.orderStatus}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listOrder}">
                            <tr>
                                <td class="fw-bold">#101</td>
                                <td>31/10/2026 09:30</td>
                                <td>
                                    <div class="fw-semibold">Nguyễn Văn A - 0912345678</div>
                                    <small class="text-secondary">Khu CNC Hòa Lạc, Thạch Thất, Hà Nội</small>
                                </td>
                                <td class="text-danger fw-bold">290000.0 đ</td>
                                <td><span class="badge bg-light text-dark border">BANK_TRANSFER</span></td>
                                <td><span class="badge bg-warning text-dark">Chờ xác nhận</span></td>
                            </tr>
                            <tr>
                                <td class="fw-bold">#100</td>
                                <td>30/10/2026 15:10</td>
                                <td>
                                    <div class="fw-semibold">Nguyễn Văn A - 0912345678</div>
                                    <small class="text-secondary">Khu CNC Hòa Lạc, Thạch Thất, Hà Nội</small>
                                </td>
                                <td class="text-danger fw-bold">145000.0 đ</td>
                                <td><span class="badge bg-light text-dark border">COD</span></td>
                                <td><span class="badge bg-success">Hoàn thành</span></td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
