<%-- 
    Document   : shop
    Created on : Oct 30, 2026, 10:05:27 AM
    Author     : livsu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FreshFruit Store - Cửa hàng</title>
    <!-- Nhúng tạm Bootstrap để giao diện đẹp ngay lập tức -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Header chung -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4">
        <!-- Banner Cửa hàng -->
        <div class="ff-hero mb-4 py-4 px-4">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <span class="ff-hero-badge mb-2">
                        <i class="bi bi-leaf-fill text-success"></i> Tươi Ngon Chuẩn VietGAP
                    </span>
                    <h2 class="text-success fw-bold mb-2">Trái Cây Tươi Trong Ngày</h2>
                    <p class="text-secondary mb-0">
                        Chọn lựa trái cây tươi mới thu hoạch mỗi ngày. Giao hàng tận nơi nhanh chóng chỉ trong 2 giờ.
                    </p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/cart.jsp" class="btn btn-success rounded-pill px-4 py-2">
                        <i class="bi bi-cart3 me-2"></i>Xem Giỏ Hàng
                    </a>
                </div>
            </div>
        </div>

        <!-- Thanh Tìm kiếm & Lọc sản phẩm (Dành cho Dev 2 & Dev 3) -->
        <div class="ff-filter-bar mb-4">
            <form action="${pageContext.request.contextPath}/shop" method="get" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label small fw-bold text-secondary mb-1">
                        <i class="bi bi-search text-success me-1"></i>Tìm kiếm sản phẩm
                    </label>
                    <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Nhập tên trái cây (VD: Táo Envy, Dâu tây...)">
                </div>

                <div class="col-md-3">
                    <label class="form-label small fw-bold text-secondary mb-1">
                        <i class="bi bi-tags text-success me-1"></i>Danh mục
                    </label>
                    <select name="categoryId" class="form-select">
                        <option value="">-- Tất cả danh mục --</option>
                        <c:forEach items="${listCategory}" var="cat">
                            <option value="${cat.categoryId}" ${param.categoryId == cat.categoryId ? 'selected' : ''}>
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label small fw-bold text-secondary mb-1">
                        <i class="bi bi-sort-down text-success me-1"></i>Sắp xếp theo giá
                    </label>
                    <select name="sort" class="form-select">
                        <option value="">Mới nhất</option>
                        <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                        <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                    </select>
                </div>

                <div class="col-md-2 d-flex gap-2">
                    <button type="submit" class="btn btn-success w-100">
                        <i class="bi bi-funnel-fill me-1"></i>Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-secondary" title="Xóa bộ lọc">
                        <i class="bi bi-arrow-counterclockwise"></i>
                    </a>
                </div>
            </form>
        </div>
        
        <div class="row">
            <!-- Giả sử Controller đã truyền listProduct vào request -->
            <c:forEach items="${listProduct}" var="p">
                <div class="col-md-3 mb-4">
                    <div class="card ff-product-card h-100 shadow-sm">
                        <div class="ff-product-img-wrap">
                            <!-- Ảnh sản phẩm -->
                            <a href="${pageContext.request.contextPath}/product-detail.jsp?id=${p.productId}">
                                <img src="${p.imageUrl}" class="card-img-top" alt="${p.productName}" style="height: 200px; object-fit: cover;">
                            </a>
                            <span class="ff-stock-badge">
                                <i class="bi bi-box-seam me-1"></i>Còn: ${p.stockQuantity} ${p.unit}
                            </span>
                        </div>
                        <div class="card-body text-center d-flex flex-column">
                            <h5 class="card-title fw-bold">
                                <a href="${pageContext.request.contextPath}/product-detail.jsp?id=${p.productId}" class="text-dark text-decoration-none">
                                    ${p.productName}
                                </a>
                            </h5>
                            <!-- Hiển thị giá và đơn vị (VNĐ/kg hoặc VNĐ/hộp) -->
                            <p class="text-danger fw-bold fs-5 mb-3">${p.price} VNĐ / ${p.unit}</p>
                            
                            <!-- Form thêm vào giỏ hàng -->
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mt-auto">
                                <input type="hidden" name="productId" value="${p.productId}">
                                <div class="input-group mb-3 justify-content-center">
                                    <span class="input-group-text">SL:</span>
                                    <input type="number" name="quantity" value="1" min="1" max="${p.stockQuantity}" class="form-control text-center" style="max-width: 80px;">
                                </div>
                                <button type="submit" class="btn btn-outline-success w-100">
                                    <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Trạng thái hiển thị mẫu khi chưa có dữ liệu từ Controller -->
            <c:if test="${empty listProduct}">
                <div class="col-12">
                    <div class="alert alert-success border-0 shadow-sm rounded-4 p-4 mb-4 d-flex align-items-center justify-content-between flex-wrap gap-3">
                        <div>
                            <h6 class="fw-bold mb-1"><i class="bi bi-info-circle-fill me-2"></i>Chế độ xem trước giao diện (UI Preview)</h6>
                            <p class="small mb-0 text-secondary">
                                Hiện tại biến <code>&#36;{listProduct}</code> đang trống (chờ Dev 2 kết nối <code>ShopController</code>). Dưới đây là các thẻ sản phẩm mẫu để xem trước giao diện.
                            </p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin-product.jsp" class="btn btn-sm btn-success rounded-pill px-3">
                            <i class="bi bi-plus-circle me-1"></i>Quản lý Sản phẩm (Admin)
                        </a>
                    </div>
                </div>

                <!-- Sản phẩm mẫu 1 -->
                <div class="col-md-3 mb-4">
                    <div class="card ff-product-card h-100 shadow-sm">
                        <div class="ff-product-img-wrap">
                            <a href="${pageContext.request.contextPath}/product-detail.jsp?id=1">
                                <img src="https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Táo Envy Mỹ" style="height: 200px; object-fit: cover;">
                            </a>
                            <span class="ff-stock-badge"><i class="bi bi-box-seam me-1"></i>Còn: 35 kg</span>
                        </div>
                        <div class="card-body text-center d-flex flex-column">
                            <h5 class="card-title fw-bold">
                                <a href="${pageContext.request.contextPath}/product-detail.jsp?id=1" class="text-dark text-decoration-none">Táo Envy Mỹ Size Lớn</a>
                            </h5>
                            <p class="text-danger fw-bold fs-5 mb-3">145000.0 VNĐ / kg</p>
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mt-auto">
                                <input type="hidden" name="productId" value="1">
                                <div class="input-group mb-3 justify-content-center">
                                    <span class="input-group-text">SL:</span>
                                    <input type="number" name="quantity" value="1" min="1" max="35" class="form-control text-center" style="max-width: 80px;">
                                </div>
                                <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sản phẩm mẫu 2 -->
                <div class="col-md-3 mb-4">
                    <div class="card ff-product-card h-100 shadow-sm">
                        <div class="ff-product-img-wrap">
                            <a href="${pageContext.request.contextPath}/product-detail.jsp?id=2">
                                <img src="https://images.unsplash.com/photo-1464965911861-746a04b4bca6?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Dâu Tây Đà Lạt" style="height: 200px; object-fit: cover;">
                            </a>
                            <span class="ff-stock-badge"><i class="bi bi-box-seam me-1"></i>Còn: 20 hộp</span>
                        </div>
                        <div class="card-body text-center d-flex flex-column">
                            <h5 class="card-title fw-bold">
                                <a href="${pageContext.request.contextPath}/product-detail.jsp?id=2" class="text-dark text-decoration-none">Dâu Tây Hana Đà Lạt</a>
                            </h5>
                            <p class="text-danger fw-bold fs-5 mb-3">120000.0 VNĐ / hộp</p>
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mt-auto">
                                <input type="hidden" name="productId" value="2">
                                <div class="input-group mb-3 justify-content-center">
                                    <span class="input-group-text">SL:</span>
                                    <input type="number" name="quantity" value="1" min="1" max="20" class="form-control text-center" style="max-width: 80px;">
                                </div>
                                <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sản phẩm mẫu 3 -->
                <div class="col-md-3 mb-4">
                    <div class="card ff-product-card h-100 shadow-sm">
                        <div class="ff-product-img-wrap">
                            <a href="${pageContext.request.contextPath}/product-detail.jsp?id=3">
                                <img src="https://images.unsplash.com/photo-1553279768-865429fa0078?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Xoài Cát Hòa Lộc" style="height: 200px; object-fit: cover;">
                            </a>
                            <span class="ff-stock-badge"><i class="bi bi-box-seam me-1"></i>Còn: 50 kg</span>
                        </div>
                        <div class="card-body text-center d-flex flex-column">
                            <h5 class="card-title fw-bold">
                                <a href="${pageContext.request.contextPath}/product-detail.jsp?id=3" class="text-dark text-decoration-none">Xoài Cát Hòa Lộc Loại 1</a>
                            </h5>
                            <p class="text-danger fw-bold fs-5 mb-3">85000.0 VNĐ / kg</p>
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mt-auto">
                                <input type="hidden" name="productId" value="3">
                                <div class="input-group mb-3 justify-content-center">
                                    <span class="input-group-text">SL:</span>
                                    <input type="number" name="quantity" value="1" min="1" max="50" class="form-control text-center" style="max-width: 80px;">
                                </div>
                                <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sản phẩm mẫu 4 -->
                <div class="col-md-3 mb-4">
                    <div class="card ff-product-card h-100 shadow-sm">
                        <div class="ff-product-img-wrap">
                            <a href="${pageContext.request.contextPath}/product-detail.jsp?id=4">
                                <img src="https://images.unsplash.com/photo-1537640538966-79f369143f8f?auto=format&fit=crop&w=600&q=80" class="card-img-top" alt="Nho Mẫu Đơn" style="height: 200px; object-fit: cover;">
                            </a>
                            <span class="ff-stock-badge"><i class="bi bi-box-seam me-1"></i>Còn: 15 chùm</span>
                        </div>
                        <div class="card-body text-center d-flex flex-column">
                            <h5 class="card-title fw-bold">
                                <a href="${pageContext.request.contextPath}/product-detail.jsp?id=4" class="text-dark text-decoration-none">Nho Mẫu Đơn Shine Muscat</a>
                            </h5>
                            <p class="text-danger fw-bold fs-5 mb-3">290000.0 VNĐ / chùm</p>
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mt-auto">
                                <input type="hidden" name="productId" value="4">
                                <div class="input-group mb-3 justify-content-center">
                                    <span class="input-group-text">SL:</span>
                                    <input type="number" name="quantity" value="1" min="1" max="15" class="form-control text-center" style="max-width: 80px;">
                                </div>
                                <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
