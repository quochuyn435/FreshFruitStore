<%-- 
    Document   : admin-user
    Description: Trang Admin Quản lý Tài khoản & Khóa/Mở khóa tài khoản (Module Dev 1)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Tài khoản - FreshFruit</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navbar Admin đồng bộ -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin-user.jsp">
                <span class="badge bg-success p-2"><i class="bi bi-basket2-fill"></i></span>
                <span>FreshFruit Admin Dashboard</span>
            </a>
            <div class="navbar-nav me-auto ms-4 gap-2">
                <a class="nav-link active fw-bold text-success" href="${pageContext.request.contextPath}/admin-user.jsp">
                    <i class="bi bi-people-fill me-1"></i>Quản lý Tài khoản (Khóa/Mở khóa)
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-product.jsp">
                    <i class="bi bi-box-seam me-1"></i>Sản phẩm & Ngừng bán
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-order.jsp">
                    <i class="bi bi-receipt me-1"></i>Quản lý Đơn hàng
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
        <!-- Thống kê nhanh Tài khoản -->
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Tổng Tài khoản</div>
                            <h4 class="fw-bold mb-0">${not empty listUser ? listUser.size() : '4'} tài khoản</h4>
                        </div>
                        <div class="ff-stat-icon bg-primary-subtle text-primary"><i class="bi bi-people-fill"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Đang hoạt động</div>
                            <h4 class="fw-bold text-success mb-0">3 tài khoản</h4>
                        </div>
                        <div class="ff-stat-icon bg-success-subtle text-success"><i class="bi bi-person-check-fill"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Đã bị khóa</div>
                            <h4 class="fw-bold text-danger mb-0">1 tài khoản</h4>
                        </div>
                        <div class="ff-stat-icon bg-danger-subtle text-danger"><i class="bi bi-person-lock"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card ff-admin-stat-card p-3 bg-white">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-secondary small fw-semibold">Quản trị viên (Admin)</div>
                            <h4 class="fw-bold text-dark mb-0">1 Admin</h4>
                        </div>
                        <div class="ff-stat-icon bg-warning-subtle text-warning"><i class="bi bi-shield-lock-fill"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thanh lọc & tìm kiếm tài khoản -->
        <div class="ff-filter-bar mb-4">
            <form action="${pageContext.request.contextPath}/admin/users" method="get" class="row g-3 align-items-end">
                <div class="col-md-5">
                    <label class="form-label small fw-bold text-secondary mb-1">
                        <i class="bi bi-search text-success me-1"></i>Tìm kiếm tài khoản
                    </label>
                    <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Nhập username, họ tên hoặc số điện thoại...">
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold text-secondary mb-1">Vai trò (Role)</label>
                    <select name="role" class="form-select">
                        <option value="">-- Tất cả vai trò --</option>
                        <option value="Admin" ${param.role == 'Admin' ? 'selected' : ''}>Admin (Quản trị)</option>
                        <option value="Customer" ${param.role == 'Customer' ? 'selected' : ''}>Customer (Khách hàng)</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-bold text-secondary mb-1">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="">-- Tất cả --</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="locked" ${param.status == 'locked' ? 'selected' : ''}>Đã khóa</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <button type="submit" class="btn btn-success w-100">
                        <i class="bi bi-funnel-fill me-1"></i>Lọc
                    </button>
                </div>
            </form>
        </div>

        <!-- Bảng Danh sách Tài khoản & Khóa/Mở khóa -->
        <div class="card border-0 shadow-sm p-3 bg-white rounded-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-success mb-0">
                    <i class="bi bi-person-lines-fill me-2"></i>Danh sách Tài khoản Hệ thống
                </h5>
                <c:if test="${not empty message}">
                    <span class="badge bg-success-subtle text-success px-3 py-2">${message}</span>
                </c:if>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-success">
                        <tr>
                            <th>ID</th>
                            <th>Tên đăng nhập</th>
                            <th>Họ và tên</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th class="text-end">Hành động (Khóa / Mở khóa)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listUser}" var="u">
                            <tr>
                                <td class="fw-bold">#${u.userId}</td>
                                <td class="fw-semibold text-dark">${u.username}</td>
                                <td>${not empty u.fullName ? u.fullName : '<span class="text-muted fst-italic">Chưa cập nhật</span>'}</td>
                                <td>${not empty u.phone ? u.phone : '-'}</td>
                                <td><small class="text-secondary">${not empty u.address ? u.address : '-'}</small></td>
                                <td>
                                    <span class="badge ${u.role == 'Admin' ? 'bg-danger' : 'bg-info text-dark'}">
                                        ${u.role}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.locked}">
                                            <span class="badge bg-danger">
                                                <i class="bi bi-slash-circle me-1"></i>Đã khóa
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success">
                                                <i class="bi bi-check-circle me-1"></i>Hoạt động
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">
                                    <c:if test="${u.role != 'Admin'}">
                                        <!-- Form Khóa / Mở khóa tài khoản -->
                                        <form action="${pageContext.request.contextPath}/admin/user/toggle-lock" method="post" class="d-inline">
                                            <input type="hidden" name="userId" value="${u.userId}">
                                            <c:choose>
                                                <c:when test="${u.locked}">
                                                    <input type="hidden" name="action" value="unlock">
                                                    <button type="submit" class="btn btn-success btn-sm">
                                                        <i class="bi bi-unlock-fill me-1"></i>Mở khóa
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="action" value="lock">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm">
                                                        <i class="bi bi-lock-fill me-1"></i>Khóa tài khoản
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </c:if>
                                    <c:if test="${u.role == 'Admin'}">
                                        <span class="badge bg-light text-secondary border">Tài khoản Admin</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- Dữ liệu mẫu hiển thị khi chưa truyền listUser (UI Preview) -->
                        <c:if test="${empty listUser}">
                            <tr>
                                <td class="fw-bold">#1</td>
                                <td class="fw-semibold text-dark">admin</td>
                                <td>Quản trị viên Hệ thống</td>
                                <td>0901234567</td>
                                <td><small class="text-secondary">FPT University Hòa Lạc</small></td>
                                <td><span class="badge bg-danger">Admin</span></td>
                                <td><span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span></td>
                                <td class="text-end">
                                    <span class="badge bg-light text-secondary border">Tài khoản Admin</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">#2</td>
                                <td class="fw-semibold text-dark">customer</td>
                                <td>Nguyễn Văn A</td>
                                <td>0912345678</td>
                                <td><small class="text-secondary">Số 12 Cầu Giấy, Hà Nội</small></td>
                                <td><span class="badge bg-info text-dark">Customer</span></td>
                                <td><span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span></td>
                                <td class="text-end">
                                    <form action="${pageContext.request.contextPath}/admin/user/toggle-lock" method="post" class="d-inline">
                                        <input type="hidden" name="userId" value="2">
                                        <input type="hidden" name="action" value="lock">
                                        <button type="submit" class="btn btn-outline-danger btn-sm">
                                            <i class="bi bi-lock-fill me-1"></i>Khóa tài khoản
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <tr class="table-light text-muted">
                                <td class="fw-bold">#3</td>
                                <td class="fw-semibold">khachhang02</td>
                                <td>Trần Thị B</td>
                                <td>0987654321</td>
                                <td><small>Quận 1, TP. Hồ Chí Minh</small></td>
                                <td><span class="badge bg-secondary">Customer</span></td>
                                <td><span class="badge bg-danger"><i class="bi bi-slash-circle me-1"></i>Đã khóa</span></td>
                                <td class="text-end">
                                    <form action="${pageContext.request.contextPath}/admin/user/toggle-lock" method="post" class="d-inline">
                                        <input type="hidden" name="userId" value="3">
                                        <input type="hidden" name="action" value="unlock">
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="bi bi-unlock-fill me-1"></i>Mở khóa
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
