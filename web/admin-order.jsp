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
    <title>Admin - Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navbar Admin cơ bản -->
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">FreshFruit Admin Dashboard</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Đăng xuất</a>
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
