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
    <title>FreshFruit Store - Cửa hàng</title>
    <!-- Nhúng tạm Bootstrap để giao diện đẹp ngay lập tức -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-success mb-4">Trái Cây Tươi Trong Ngày</h2>
        
        <div class="row">
            <!-- Giả sử Controller đã truyền listProduct vào request -->
            <c:forEach items="${listProduct}" var="p">
                <div class="col-md-3 mb-4">
                    <div class="card h-100 shadow-sm">
                        <!-- Ảnh sản phẩm -->
                        <img src="${p.imageUrl}" class="card-img-top" alt="${p.productName}" style="height: 200px; object-fit: cover;">
                        <div class="card-body text-center">
                            <h5 class="card-title">${p.productName}</h5>
                            <!-- Hiển thị giá và đơn vị (VNĐ/kg hoặc VNĐ/hộp) -->
                            <p class="text-danger fw-bold">${p.price} VNĐ / ${p.unit}</p>
                            
                            <!-- Form thêm vào giỏ hàng -->
                            <form action="${pageContext.request.contextPath}/cart/add" method="post">
                                <input type="hidden" name="productId" value="${p.productId}">
                                <div class="input-group mb-3 justify-content-center">
                                    <span class="input-group-text">SL:</span>
                                    <input type="number" name="quantity" value="1" min="1" max="${p.stockQuantity}" class="form-control" style="max-width: 80px;">
                                </div>
                                <button type="submit" class="btn btn-outline-success w-100">Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>