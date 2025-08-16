<div class="sidebar">
    <div class="sidebar-brand">
        <h3><i class="fas fa-chart-line me-2"></i>SalesDash</h3>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
<%--            <a class="nav-link active" href="../pages/dashboard.jsp" data-view="dashboard">--%>
            <a class="nav-link active" href="${pageContext.request.contextPath}/src/pages/dashboard.jsp" data-view="dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </li>
        <li>
            <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#salesMenu" role="button" aria-expanded="false">
                <span><i class="fas fa-shopping-cart me-2"></i>Products</span>
                <i class="fas fa-chevron-down"></i>
            </a>
            <div class="collapse" id="salesMenu">
                <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ps-3">
                    <li>
                        <a class="nav-link" href="${pageContext.request.contextPath}/inventory-type"><i class="fas fa-paint-brush me-2"></i>Product types</a>
                    </li>
                    <li>
                        <a class="nav-link" href="${pageContext.request.contextPath}/inventory"><i class="fas fa-copy me-2"></i>Products</a>
                    </li>
                </ul>
            </div>


        </li>

        <li class="nav-item">
            <a class="nav-link" href="../pages/user-list.jsp" data-view="customers">
                <i class="fas fa-users"></i> Customers
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-shopping-cart"></i> Sales
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-box"></i> Products
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-chart-pie"></i> Reports
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-cog"></i> Settings
            </a>
        </li>
        <li class="nav-item mt-4">
            <a class="nav-link" href="#">
                <i class="fas fa-question-circle"></i> Help Center
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>

    <div class="position-absolute bottom-0 start-0 w-100 p-3 text-center text-white-50">
        <small>v2.4.1 © 2025 SalesDash</small>
    </div>
</div>