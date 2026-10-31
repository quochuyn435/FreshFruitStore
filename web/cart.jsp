<%-- 
    Document   : cart
    Description: Trang Giỏ hàng dành cho Dev 3 (Trải nghiệm Mua sắm & Giỏ hàng)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn - FreshFruit Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="text-success fw-bold mb-1"><i class="bi bi-cart3 me-2"></i>Giỏ Hàng Của Bạn</h2>
                <p class="text-secondary small mb-0">Kiểm tra lại danh sách trái cây và số lượng trước khi thanh toán.</p>
            </div>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-success rounded-pill px-4">
                <i class="bi bi-arrow-left me-1"></i>Tiếp tục mua sắm
            </a>
        </div>

        <div class="row g-4">
            <!-- Danh sách sản phẩm trong giỏ -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm p-3 bg-white">
                    <div class="table-responsive">
                        <table class="table align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th class="text-center">Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th class="text-end">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${sessionScope.cart.items}" var="item">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <img src="${item.product.imageUrl}" alt="${item.product.productName}" class="rounded-3 border" style="width: 64px; height: 64px; object-fit: cover;">
                                                <div>
                                                    <h6 class="fw-bold mb-1">${item.product.productName}</h6>
                                                    <span class="badge bg-light text-secondary border">Đơn vị: ${item.product.unit}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="fw-semibold">${item.product.price} VNĐ</td>
                                        <td style="width: 150px;">
                                            <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex justify-content-center gap-1">
                                                <input type="hidden" name="productId" value="${item.product.productId}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stockQuantity}" class="form-control form-control-sm text-center" style="width: 70px;">
                                                <button type="submit" class="btn btn-outline-success btn-sm" title="Cập nhật">
                                                    <i class="bi bi-arrow-repeat"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td class="text-danger fw-bold">${item.product.price * item.quantity} VNĐ</td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/cart/remove" method="post" class="d-inline">
                                                <input type="hidden" name="productId" value="${item.product.productId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <!-- Hiển thị mẫu khi giỏ hàng trong Session chưa có dữ liệu (UI Preview cho Dev 3) -->
                                <c:if test="${empty sessionScope.cart.items}">
                                    <tr>
                                        <td colspan="5">
                                            <div class="alert alert-warning border-0 small mb-0">
                                                <i class="bi bi-info-circle-fill me-1"></i>
                                                Giỏ hàng trong Session (<code>&#36;{sessionScope.cart.items}</code>) hiện đang trống. Dưới đây là dòng dữ liệu mẫu để Dev 3 kiểm tra giao diện:
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <img src="https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=200&q=80" alt="Táo Envy" class="rounded-3 border" style="width: 64px; height: 64px; object-fit: cover;">
                                                <div>
                                                    <h6 class="fw-bold mb-1">Táo Envy Mỹ Size Lớn</h6>
                                                    <span class="badge bg-light text-secondary border">Đơn vị: kg</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="fw-semibold">145000.0 VNĐ</td>
                                        <td style="width: 150px;">
                                            <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex justify-content-center gap-1">
                                                <input type="hidden" name="productId" value="1">
                                                <input type="number" name="quantity" value="2" min="1" class="form-control form-control-sm text-center" style="width: 70px;">
                                                <button type="submit" class="btn btn-outline-success btn-sm"><i class="bi bi-arrow-repeat"></i></button>
                                            </form>
                                        </td>
                                        <td class="text-danger fw-bold">290000.0 VNĐ</td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/cart/remove" method="post" class="d-inline">
                                                <input type="hidden" name="productId" value="1">
                                                <button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Cột Tóm tắt thanh toán -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 bg-white">
                    <h5 class="fw-bold mb-3">Tóm tắt đơn hàng</h5>
                    <div class="d-flex justify-content-between mb-2 text-secondary">
                        <span>Phí vận chuyển:</span>
                        <span class="text-success fw-semibold">Miễn phí</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold">Tổng tiền tạm tính:</span>
                        <h4 class="text-danger fw-bold mb-0">
                            ${not empty sessionScope.cart.totalAmount ? sessionScope.cart.totalAmount : '290000.0'} VNĐ
                        </h4>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout.jsp" class="btn btn-success btn-lg w-100 mb-2">
                        <i class="bi bi-credit-card-2-front me-2"></i>Tiến hành Thanh toán
                    </a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
