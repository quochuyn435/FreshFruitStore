<%-- 
    Document   : product-detail
    Description: Trang Chi tiết Sản phẩm dành cho Dev 2 (Catalog & Kho) và Dev 3 (Thêm vào giỏ)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty product ? product.productName : 'Chi tiết sản phẩm'} - FreshFruit Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.html" class="text-success text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/shop" class="text-success text-decoration-none">Cửa hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">
                    ${not empty product ? product.productName : 'Táo Envy Mỹ Size Lớn'}
                </li>
            </ol>
        </nav>

        <!-- Khối chi tiết sản phẩm -->
        <div class="card border-0 shadow-sm p-4 rounded-4 bg-white">
            <div class="row g-4 align-items-center">
                <!-- Ảnh sản phẩm -->
                <div class="col-md-5">
                    <div class="rounded-4 overflow-hidden border bg-light text-center">
                        <img src="${not empty product.imageUrl ? product.imageUrl : 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=800&q=80'}"
                             alt="${not empty product ? product.productName : 'Táo Envy Mỹ'}"
                             class="img-fluid"
                             style="max-height: 400px; width: 100%; object-fit: cover;">
                    </div>
                </div>

                <!-- Thông tin & Form đặt hàng -->
                <div class="col-md-7">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill">
                            <i class="bi bi-patch-check-fill me-1"></i>Trái cây tươi trong ngày
                        </span>
                        <span class="badge bg-light text-secondary border px-3 py-2 rounded-pill">
                            Mã SP: #${not empty product ? product.productId : '1'}
                        </span>
                    </div>

                    <h2 class="fw-bold text-dark mb-2">
                        ${not empty product ? product.productName : 'Táo Envy Mỹ Size Lớn (Nhập khẩu chính ngạch)'}
                    </h2>

                    <div class="fs-3 fw-bold text-danger mb-3">
                        ${not empty product ? product.price : '145000.0'} VNĐ
                        <span class="fs-6 text-secondary fw-normal">/ ${not empty product ? product.unit : 'kg'}</span>
                    </div>

                    <p class="text-secondary mb-4" style="line-height: 1.7;">
                        ${not empty product.description ? product.description : 'Trái cây tươi ngon được tuyển chọn kỹ lưỡng mỗi sáng, quả giòn ngọt đậm đà, nhiều nước và giàu vitamin C. Đảm bảo quy trình bảo quản lạnh từ nông trại đến bàn ăn gia đình bạn.'}
                    </p>

                    <div class="row g-3 mb-4">
                        <div class="col-sm-6">
                            <div class="p-3 rounded-3 bg-light border">
                                <div class="small text-secondary">Tình trạng tồn kho</div>
                                <div class="fw-bold text-success">
                                    <i class="bi bi-check-circle-fill me-1"></i>Còn hàng (${not empty product ? product.stockQuantity : '35'} ${not empty product ? product.unit : 'kg'})
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="p-3 rounded-3 bg-light border">
                                <div class="small text-secondary">Vận chuyển</div>
                                <div class="fw-bold text-dark">
                                    <i class="bi bi-truck text-success me-1"></i>Giao nhanh nội thành 2H
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Thêm vào giỏ hàng (Đồng bộ với shop.jsp cho Dev 3) -->
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-flex flex-wrap align-items-center gap-3">
                        <input type="hidden" name="productId" value="${not empty product ? product.productId : '1'}">
                        <div class="input-group" style="width: 150px;">
                            <span class="input-group-text fw-semibold">SL:</span>
                            <input type="number" name="quantity" value="1" min="1" max="${not empty product ? product.stockQuantity : '35'}" class="form-control text-center fw-bold">
                        </div>

                        <button type="submit" class="btn btn-success btn-lg px-4">
                            <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ hàng
                        </button>

                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-secondary btn-lg px-4">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
