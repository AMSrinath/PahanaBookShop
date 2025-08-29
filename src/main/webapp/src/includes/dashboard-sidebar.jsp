<%@ page import="pahana.education.model.response.UserDataResponse" %>
<%@ page import="java.util.Arrays" %>
<%
    String currentPath = request.getServletPath();

    UserDataResponse sessionUser = (UserDataResponse) session.getAttribute("user");
    if (sessionUser ==null || sessionUser.getUserRole() == null || sessionUser.getUserRole().getName().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String userRole = sessionUser.getUserRole().getName();
%>


<div class="sidebar">
    <div class="sidebar-brand">
        <h3><i class="fa-solid fa-book-bookmark"></i> Pahana Book</h3>
        <h3 style="align-content: center">Shop</h3>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
            <a class="nav-link <%= currentPath.contains("/src/pages/dashboard.jsp") ? "active" : "" %>"
               href="${pageContext.request.contextPath}/dashboard" data-view="dashboard" style="color: white !important;">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </li>


        <%
            boolean isProductMenu = currentPath.contains("/src/pages/product-type-list.jsp") || currentPath.contains("/src/pages/product-list.jsp");
        %>
        <% if (Arrays.asList("admin", "store_keeper").contains(userRole)) { %>
        <li>
            <a class="nav-link d-flex justify-content-between align-items-center"
               data-bs-toggle="collapse"
               href="#salesMenu"
               role="button"
               aria-expanded="<%= isProductMenu %>"
               style="color: white !important;"
            >
                <span><i class="fas fa-shopping-cart me-2"></i>Products</span>
                <i class="fas fa-chevron-down"></i>
            </a>
            <div class="collapse <%= isProductMenu ? "show" : "" %>" id="salesMenu">
                <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ps-3">

                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/product-type-list.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/inventory-type" style="color: white !important;"><i class="fas fa-paint-brush me-2"></i>Product types</a>
                        </li>
                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/product-list.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/inventory" style="color: white !important;"><i class="fas fa-copy me-2"></i>Products</a>
                        </li>
                </ul>
            </div>
        </li>
        <% } %>


        <% if (Arrays.asList("admin", "cashier").contains(userRole)) { %>
            <li class="nav-item">
                <a class="nav-link <%= currentPath.contains("/src/pages/sales.jsp") ? "active" : "" %>"
                   href="${pageContext.request.contextPath}/src/pages/sales.jsp" style="color: white !important;">
                    <i class="fas fa-shopping-cart"></i> Sales
                </a>
            </li>
        <% } %>

        <%
            boolean isUserMenu = currentPath.contains("/user") || currentPath.contains("/author");
        %>
        <li class="nav-item">
            <a class="nav-link d-flex justify-content-between align-items-center"
               data-bs-toggle="collapse"
               href="#userMenu"
               role="button"
               aria-expanded="<%= isUserMenu %>"
               style="color: white !important;"
            >
                <span><i class="fas fa-user-cog me-2"></i>Users</span>
                <i class="fas fa-chevron-down"></i>
            </a>
            <div class="collapse <%= isUserMenu ? "show" : "" %>" id="userMenu">
                <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ps-3">
                    <% if ("admin".equals(userRole)) { %>
                    <li>
                        <a class="nav-link <%= currentPath.contains("/user") ? "active" : "" %>"
                           href="${pageContext.request.contextPath}/user?type=user" style="color: white !important;"><i class="fas fa-user-tie me-2"></i>User</a>
                    </li>
                    <% } %>

                    <% if ("admin".equals(userRole)) { %>
                    <li>
                        <a class="nav-link <%= currentPath.contains("/src/pages/author-list.jsp") ? "active" : "" %>"
                           href="${pageContext.request.contextPath}/author" style="color: white !important;"><i class="fas fa-user-tie me-2"></i>Author</a>
                    </li>
                    <% } %>

                    <li>
                        <a class="nav-link" href="${pageContext.request.contextPath}/user?id=<%= sessionUser.getId() %>&action=my_account" style="color: white !important;">
                            <i class="fas fa-user-friends me-2"></i>My Account
                        </a>
                    </li>
                </ul>
            </div>
        </li>

        <%
            boolean isReportMenu = currentPath.contains("/src/pages/reports-daily-sales.jsp")
                    || currentPath.contains("/src/pages/product-list.jsp")
                    || currentPath.contains("/src/pages/reports-product-list.jsp")
                    || currentPath.contains("/src/pages/reports-product-qty-list.jsp")
                    || currentPath.contains("/src/pages/reports-cashier-wise-sales.jsp")
                    || currentPath.contains("/src/pages/reports-cashier-daily-sales.jsp")
                    || currentPath.contains("/src/pages/reports-customer-purchase.jsp")
                    || currentPath.contains("/report");
        %>
        <li>
            <a class="nav-link d-flex justify-content-between align-items-center"
               data-bs-toggle="collapse"
               href="#reportMenu"
               role="button"
               aria-expanded="<%= isReportMenu %>"
               style="color: white !important;"
            >
                <span><i class="fas fa-shopping-cart me-2"></i>Reports</span>
                <i class="fas fa-chevron-down"></i>
            </a>
            <div class="collapse <%= isReportMenu ? "show" : "" %>" id="reportMenu">
                <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ps-3">
                    <% if ("admin".equals(userRole)) { %>
                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/reports-daily-sales.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/report?report_type=daily_sales" style="color: white !important;"><i class="fas fa-paint-brush me-2"></i>
                                Daily Sales
                            </a>
                        </li>
                    <% } %>


                    <% if (Arrays.asList("admin", "cashier").contains(userRole)) { %>
                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/reports-cashier-daily-sales.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/report?report_type=cashier_daily_sales" style="color: white !important;"><i class="fas fa-paint-brush me-2" style="color: white !important;"></i>
                                Cashier Daily Sales
                            </a>
                        </li>
                    <% } %>

                    <% if ("admin".equals(userRole)) { %>
                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/reports-cashier-wise-sales.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/report?report_type=cashier_wise_sales" style="color: white !important;"><i class="fas fa-paint-brush me-2"></i>
                                Cashier Wise Sales
                            </a>
                        </li>
                    <% } %>

                    <% if (Arrays.asList("admin", "customer").contains(userRole)) { %>
                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/product-list.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/report?report_type=customer_purchase" style="color: white !important;"><i class="fas fa-copy me-2"></i>
                                Customer Purchase
                            </a>
                        </li>
                    <% } %>

                    <% if (Arrays.asList("admin", "store_keeper").contains(userRole)) { %>
                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/reports-product-list.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/report?report_type=product_list" style="color: white !important;"><i class="fas fa-copy me-2"></i>
                                Product List
                            </a>
                        </li>

                        <li>
                            <a class="nav-link <%= currentPath.contains("/src/pages/reports-product-qty-list.jsp") ? "active" : "" %>"
                               href="${pageContext.request.contextPath}/report?report_type=product_qty_list" style="color: white !important;"><i class="fas fa-copy me-2"></i>
                                Product Stock
                            </a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </li>

        <li class="nav-item mt-4">
            <a class="nav-link" href="${pageContext.request.contextPath}/help" style="color: white !important;">
                <i class="fas fa-question-circle"></i> Help Center
            </a>
        </li>
        <li class="nav-item" >
            <a class="nav-link" href="${pageContext.request.contextPath}/logout" style="color: white !important;">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>

    <div class="position-absolute bottom-0 start-0 w-100 p-3 text-center text-white-50">
        <small style="color: white !important;">Mithun © 2025</small>
    </div>
</div>