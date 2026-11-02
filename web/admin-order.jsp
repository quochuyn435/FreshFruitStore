<%-- 
    Document   : admin-order
    Created on : Oct 30, 2026, 10:07:13 AM
    Author     : livsu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navbar Admin cơ bản -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
        <div class="container-fluid px-4">
            <span class="navbar-brand mb-0 h1 d-flex align-items-center gap-2">
                <span class="badge bg-success p-2"><i class="bi bi-basket2-fill"></i></span>
                <span>FreshFruit Admin Dashboard</span>
            </span>
            <div class="navbar-nav me-auto ms-4 gap-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-user.jsp">
                    <i class="bi bi-people-fill me-1"></i>Quản lý Tài khoản (Khóa/Mở khóa)
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-product.jsp">
                    <i class="bi bi-box-seam me-1"></i>Sản phẩm & Ngừng bán
                </a>
                <a class="nav-link active fw-bold text-success" href="${pageContext.request.contextPath}/admin-order.jsp">
                    <i class="bi bi-receipt me-1"></i>Quản lý Đơn hàng (Dev 4)
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/shop">
                    <i class="bi bi-shop me-1"></i>Xem Cửa hàng
                </a>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Đăng xuất</a>
        </div>
    </nav>

    <div class="container-fluid px-4 pb-5">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
            <h3 class="mb-0 fw-bold text-dark"><i class="bi bi-clipboard-check text-success me-2"></i>Danh sách Đơn hàng mới</h3>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin-product.jsp" class="btn btn-outline-success btn-sm">
                    <i class="bi bi-boxes me-1"></i>Quản lý Sản phẩm & Kho
                </a>
            </div>
        </div>
        
        <div class="table-responsive bg-white p-3 shadow-sm rounded-4">
            <table class="table table-hover align-middle">
                <thead class="table-success">
                    <tr>
                        <th>Mã Đơn</th>
                        <th>Khách hàng</th>
                        <th>Tổng tiền</th>
                        <th>Thanh toán</th>
                        <th>Trạng thái hiện tại</th>
                        <th>Hành động (Cập nhật)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listOrder}" var="o">
                        <tr>
                            <td>#${o.orderId}</td>
                            <td>
                                <b>${o.receiverName}</b><br>
                                <small>${o.receiverPhone}</small>
                            </td>
                            <td class="text-danger fw-bold">${o.totalAmount} đ</td>
                            <td>${o.paymentMethod}</td>
                            <td>
                                <!-- In màu trạng thái cho dễ nhìn -->
                                <span class="badge ${o.orderStatus == 'Chờ xác nhận' ? 'bg-warning' : 'bg-success'}">
                                    ${o.orderStatus}
                                </span>
                            </td>
                            <td>
                                <!-- Form nhỏ để Admin update trạng thái đơn[cite: 12] -->
                                <form action="${pageContext.request.contextPath}/admin/order/update" method="post" class="d-flex">
                                    <input type="hidden" name="orderId" value="${o.orderId}">
                                    
                                    <select name="newStatus" class="form-select form-select-sm me-2" style="width: 160px;">
                                        <!-- Các trạng thái theo nghiệp vụ[cite: 12] -->
                                        <option value="Chờ xác nhận" ${o.orderStatus == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                                        <option value="Đã xác nhận" ${o.orderStatus == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="Đã thanh toán" ${o.orderStatus == 'Đã thanh toán' ? 'selected' : ''}>Đã thanh toán</option>
                                        <option value="Đang giao hàng" ${o.orderStatus == 'Đang giao hàng' ? 'selected' : ''}>Đang giao hàng</option>
                                        <option value="Hoàn thành" ${o.orderStatus == 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                                        <option value="Đã hủy" ${o.orderStatus == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                                    </select>
                                    
                                    <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                    <!-- Hiển thị dòng mẫu khi listOrder chưa được truyền từ AdminOrderController (UI Preview) -->
                    <c:if test="${empty listOrder}">
                        <tr>
                            <td>#101</td>
                            <td>
                                <b>Nguyễn Văn A</b><br>
                                <small>0912345678</small>
                            </td>
                            <td class="text-danger fw-bold">290000.0 đ</td>
                            <td>BANK_TRANSFER</td>
                            <td>
                                <span class="badge bg-warning">Chờ xác nhận</span>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/order/update" method="post" class="d-flex">
                                    <input type="hidden" name="orderId" value="101">
                                    <select name="newStatus" class="form-select form-select-sm me-2" style="width: 160px;">
                                        <option value="Chờ xác nhận" selected>Chờ xác nhận</option>
                                        <option value="Đã xác nhận">Đã xác nhận</option>
                                        <option value="Đã thanh toán">Đã thanh toán</option>
                                        <option value="Đang giao hàng">Đang giao hàng</option>
                                        <option value="Hoàn thành">Hoàn thành</option>
                                        <option value="Đã hủy">Đã hủy</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                                </form>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
