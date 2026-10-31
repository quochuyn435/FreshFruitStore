<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Common Header / Navbar (Dev 1 - Auth & Navigation) -->
<nav class="navbar navbar-expand-lg ff-navbar sticky-top py-3">
    <div class="container">
        <a class="navbar-brand ff-brand" href="${pageContext.request.contextPath}/index.html">
            <span class="brand-badge"><i class="bi bi-basket2-fill"></i></span>
            <span>FreshFruit Store</span>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#ffNavbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="ffNavbarContent">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0 gap-1">
                <li class="nav-item">
                    <a class="nav-link ff-nav-link" href="${pageContext.request.contextPath}/index.html">
                        <i class="bi bi-house-door me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ff-nav-link" href="${pageContext.request.contextPath}/shop">
                        <i class="bi bi-shop me-1"></i>Cửa hàng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ff-nav-link" href="${pageContext.request.contextPath}/cart.jsp">
                        <i class="bi bi-cart3 me-1"></i>Giỏ hàng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ff-nav-link" href="${pageContext.request.contextPath}/my-orders.jsp">
                        <i class="bi bi-receipt-cutoff me-1"></i>Đơn mua
                    </a>
                </li>
                <c:if test="${sessionScope.account != null && sessionScope.account.role == 'Admin'}">
                    <li class="nav-item dropdown">
                        <a class="nav-link ff-nav-link dropdown-toggle text-danger" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-shield-lock me-1"></i>Quản trị (Admin)
                        </a>
                        <ul class="dropdown-menu shadow border-0 rounded-3">
                            <li>
                                <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/orders">
                                    <i class="bi bi-box-seam me-2 text-success"></i>Quản lý Đơn hàng (Dev 4)
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin-product.jsp">
                                    <i class="bi bi-grid-3x3-gap me-2 text-primary"></i>Quản lý Sản phẩm & Kho (Dev 2)
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-2">
                <!-- Nút Giỏ hàng nhanh (Dev 3) -->
                <a href="${pageContext.request.contextPath}/cart.jsp" class="btn btn-light position-relative border rounded-pill px-3">
                    <i class="bi bi-bag-check-fill text-success me-1"></i>
                    <span class="fw-semibold">Giỏ hàng</span>
                    <c:if test="${not empty sessionScope.cart}">
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            !
                        </span>
                    </c:if>
                </a>

                <!-- Khu vực Tài khoản & Phân quyền (Dev 1) -->
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <div class="dropdown">
                            <button class="btn btn-outline-success dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i>
                                <c:out value="${not empty sessionScope.account.fullName ? sessionScope.account.fullName : sessionScope.account.username}" />
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3">
                                <li class="px-3 py-2 border-bottom">
                                    <div class="small text-muted">Vai trò</div>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle">
                                        ${sessionScope.account.role}
                                    </span>
                                </li>
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/my-orders.jsp">
                                        <i class="bi bi-clock-history me-2"></i>Lịch sử đơn hàng
                                    </a>
                                </li>
                                <c:if test="${sessionScope.account.role == 'Admin'}">
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/orders">
                                            <i class="bi bi-speedometer2 me-2"></i>Vào trang Admin
                                        </a>
                                    </li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 text-danger fw-semibold" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-success rounded-pill px-3">
                            Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-success rounded-pill px-3">
                            Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
