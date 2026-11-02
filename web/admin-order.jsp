<%-- 
    Document   : admin-order
    Created on : Oct 30, 2026, 10:07:13 AM
    Author     : livsu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Kiểm tra phân quyền bắt buộc: Chỉ tài khoản Admin đã đăng nhập mới được truy cập
    model.User currentAccount = (model.User) session.getAttribute("account");
    if (currentAccount == null) {
        request.setAttribute("error", "Vui lòng đăng nhập bằng tài khoản Admin để truy cập khu vực Quản trị!");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
        return;
    }
    if (currentAccount.getRole() == null || !currentAccount.getRole().trim().equalsIgnoreCase("Admin")) {
        request.getRequestDispatcher("/access-denied.jsp").forward(request, response);
        return;
    }
%>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                    <i class="bi bi-people-fill me-1"></i>Quản lý Tài khoản
                </a>
                <a class="nav-link active fw-bold text-success" href="${pageContext.request.contextPath}/admin-order.jsp">
                    <i class="bi bi-receipt me-1"></i>Quản lý Đơn hàng
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/shop.jsp">
                    <i class="bi bi-shop me-1"></i>Xem Cửa hàng
                </a>
            </div>
            <div class="d-flex align-items-center gap-3">
                <span class="text-light small">
                    <i class="bi bi-shield-check text-success me-1"></i>Admin: <strong>${sessionScope.account.username}</strong>
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-4">
        <h3 class="mb-3">Danh sách Đơn hàng mới</h3>
        
        <div class="table-responsive bg-white p-3 shadow-sm rounded">
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
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
