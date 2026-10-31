<%-- 
    Document   : admin-product
    Description: Trang Admin Quản lý Danh mục, Sản phẩm & Tồn kho (Dành cho Dev 2)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Sản phẩm & Kho - FreshFruit</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navbar Admin đồng bộ với admin-order.jsp -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin/orders">
                <span class="badge bg-success p-2"><i class="bi bi-basket2-fill"></i></span>
                <span>FreshFruit Admin Dashboard</span>
            </a>
            <div class="navbar-nav me-auto ms-4 gap-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-order.jsp">
                    <i class="bi bi-receipt me-1"></i>Quản lý Đơn hàng (Dev 4)
                </a>
                <a class="nav-link active fw-bold text-success" href="${pageContext.request.contextPath}/admin-product.jsp">
                    <i class="bi bi-box-seam me-1"></i>Sản phẩm & Tồn kho (Dev 2)
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/shop">
                    <i class="bi bi-shop me-1"></i>Xem Cửa hàng
                </a>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">
                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
            </a>
        </div>
    </nav>

    <div class="container-fluid px-4 pb-5">
        <!-- Thống kê nhanh Kho & Danh mục -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Tổng Danh mục</div>
                            <h4 class="fw-bold mb-0">${not empty listCategory ? listCategory.size() : '4'} Danh mục</h4>
                        </div>
                        <div class="ff-stat-icon bg-success-subtle text-success"><i class="bi bi-tags-fill"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Tổng Sản phẩm</div>
                            <h4 class="fw-bold mb-0">${not empty listProduct ? listProduct.size() : '24'} mặt hàng</h4>
                        </div>
                        <div class="ff-stat-icon bg-primary-subtle text-primary"><i class="bi bi-boxes"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Thao tác nhanh</div>
                            <button class="btn btn-success btn-sm mt-1" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                <i class="bi bi-plus-lg me-1"></i>Thêm Sản phẩm mới
                            </button>
                        </div>
                        <div class="ff-stat-icon bg-warning-subtle text-warning"><i class="bi bi-plus-circle-fill"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Cột Trái: Quản lý Danh mục (Categories) -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-3 bg-white">
                    <h5 class="fw-bold text-success mb-3">
                        <i class="bi bi-folder2-open me-2"></i>Quản lý Danh mục
                    </h5>

                    <!-- Form Thêm Danh mục -->
                    <form action="${pageContext.request.contextPath}/admin/category/add" method="post" class="d-flex gap-2 mb-3">
                        <input type="text" name="categoryName" class="form-control form-control-sm" placeholder="Tên danh mục mới..." required>
                        <button type="submit" class="btn btn-success btn-sm px-3 text-nowrap">
                            <i class="bi bi-plus-lg"></i> Thêm
                        </button>
                    </form>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Danh mục</th>
                                    <th class="text-end">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listCategory}" var="c">
                                    <tr>
                                        <td>#${c.categoryId}</td>
                                        <td class="fw-semibold">${c.categoryName}</td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/admin/category/delete" method="post" class="d-inline">
                                                <input type="hidden" name="categoryId" value="${c.categoryId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listCategory}">
                                    <tr>
                                        <td>#1</td>
                                        <td class="fw-semibold">Trái Cây Nhập Khẩu</td>
                                        <td class="text-end"><button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i></button></td>
                                    </tr>
                                    <tr>
                                        <td>#2</td>
                                        <td class="fw-semibold">Đặc Sản Việt Nam</td>
                                        <td class="text-end"><button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i></button></td>
                                    </tr>
                                    <tr>
                                        <td>#3</td>
                                        <td class="fw-semibold">Trái Cây Đà Lạt</td>
                                        <td class="text-end"><button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i></button></td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Cột Phải: Quản lý Sản phẩm & Tồn kho (Products & Stock) -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm p-3 bg-white">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-success mb-0">
                            <i class="bi bi-box-seam me-2"></i>Danh sách Sản phẩm & Tồn kho
                        </h5>
                        <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="bi bi-plus-circle me-1"></i>Thêm Sản phẩm
                        </button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-success">
                                <tr>
                                    <th>Mã SP</th>
                                    <th>Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá bán</th>
                                    <th>Tồn kho (Cập nhật)</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listProduct}" var="p">
                                    <tr>
                                        <td>#${p.productId}</td>
                                        <td>
                                            <img src="${p.imageUrl}" alt="${p.productName}" class="rounded" style="width: 48px; height: 48px; object-fit: cover;">
                                        </td>
                                        <td>
                                            <div class="fw-bold">${p.productName}</div>
                                            <small class="text-secondary">Danh mục ID: ${p.categoryId}</small>
                                        </td>
                                        <td class="text-danger fw-bold">${p.price} đ / ${p.unit}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/product/stock" method="post" class="d-flex align-items-center gap-1">
                                                <input type="hidden" name="productId" value="${p.productId}">
                                                <input type="number" name="stockQuantity" value="${p.stockQuantity}" min="0" class="form-control form-control-sm text-center" style="width: 75px;">
                                                <button type="submit" class="btn btn-outline-success btn-sm" title="Lưu tồn kho">
                                                    <i class="bi bi-check2"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/product/delete" method="post" class="d-inline">
                                                <input type="hidden" name="productId" value="${p.productId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty listProduct}">
                                    <tr>
                                        <td>#1</td>
                                        <td><img src="https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=200&q=80" class="rounded" style="width: 48px; height: 48px; object-fit: cover;"></td>
                                        <td>
                                            <div class="fw-bold">Táo Envy Mỹ Size Lớn</div>
                                            <small class="text-secondary">Danh mục: Trái Cây Nhập Khẩu</small>
                                        </td>
                                        <td class="text-danger fw-bold">145000.0 đ / kg</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/product/stock" method="post" class="d-flex align-items-center gap-1">
                                                <input type="hidden" name="productId" value="1">
                                                <input type="number" name="stockQuantity" value="35" min="0" class="form-control form-control-sm text-center" style="width: 75px;">
                                                <button type="submit" class="btn btn-outline-success btn-sm"><i class="bi bi-check2"></i></button>
                                            </form>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Xóa</button>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm Sản phẩm mới (Dev 2) -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content rounded-4 border-0">
                <form action="${pageContext.request.contextPath}/admin/product/add" method="post">
                    <div class="modal-header bg-success text-white rounded-top-4">
                        <h5 class="modal-title fw-bold"><i class="bi bi-plus-circle me-2"></i>Thêm Sản phẩm Trái cây mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="row g-3">
                            <div class="col-md-8">
                                <label class="form-label fw-semibold">Tên sản phẩm</label>
                                <input type="text" name="productName" class="form-control" placeholder="VD: Nho Mẫu Đơn Hàn Quốc" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Mã Danh mục (CategoryID)</label>
                                <input type="number" name="categoryId" class="form-control" value="1" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Giá bán (VNĐ)</label>
                                <input type="number" step="0.01" name="price" class="form-control" placeholder="145000" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Đơn vị tính</label>
                                <input type="text" name="unit" class="form-control" placeholder="kg / hộp / giỏ" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Số lượng tồn kho</label>
                                <input type="number" name="stockQuantity" class="form-control" value="50" min="0" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Đường dẫn ảnh (Image URL)</label>
                                <input type="text" name="imageUrl" class="form-control" placeholder="https://...">
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Mô tả chi tiết</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="Nguồn gốc, hương vị, cách bảo quản..."></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success px-4">Lưu Sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
