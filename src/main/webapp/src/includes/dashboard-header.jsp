<%--<%@ page import="pahana.education.model.response.UserDataResponse" %>--%>
<%--<%@ page session="true" %>--%>
<%--<%--%>
<%--    UserDataResponse user = (UserDataResponse) session.getAttribute("user");--%>
<%--%>--%>

<%--<nav class="navbar navbar-expand-lg navbar-light bg-light">--%>
<%--    <!-- Your other navbar elements -->--%>

<%--    <ul class="navbar-nav ms-auto">--%>
<%--        <% if (user != null) { %>--%>
<%--        <li class="nav-item dropdown">--%>
<%--            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">--%>
<%--                <%= user.getFullName() %> <!-- Or user.getName() -->--%>
<%--            </a>--%>
<%--            <ul class="dropdown-menu dropdown-menu-end">--%>
<%--                <li><a class="dropdown-item" href="<%= request.getContextPath() %>/logout">Logout</a></li>--%>
<%--            </ul>--%>
<%--        </li>--%>
<%--        <% } else { %>--%>
<%--        <li class="nav-item">--%>
<%--            <a class="nav-link" href="<%= request.getContextPath() %>/login.jsp">Login</a>--%>
<%--        </li>--%>
<%--        <% } %>--%>
<%--    </ul>--%>
<%--</nav>--%>

<header class="dashboard-header">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center">
            <!-- Left Side: Title and Toggle -->
            <div class="d-flex align-items-center">
                <button class="btn mobile-toggle me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <div>
                    <h1 class="mb-0">Dashboard</h1>
                </div>
            </div>

            <!-- Right Side: Notifications and User Dropdown -->
            <div class="d-flex align-items-center">
                <!-- Notifications -->
                <div class="me-3 position-relative">
                    <i class="fas fa-bell fa-lg"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">3</span>
                </div>

                <!-- User Dropdown -->
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                       id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=random" class="rounded-circle me-2"
                             width="40" height="40" alt="User">
                        <span class="text-dark fw-semibold">Admin</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="/user/profile"><i class="fas fa-user me-2"></i>My Account</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>



<%--<header class="dashboard-header">--%>
<%--    <div class="container-fluid">--%>
<%--        <div class="d-flex justify-content-between align-items-center">--%>
<%--            <div class="d-flex align-items-center">--%>
<%--                <button class="btn mobile-toggle me-3">--%>
<%--                    <i class="fas fa-bars"></i>--%>
<%--                </button>--%>
<%--                <div>--%>
<%--                    <h1 class="mb-0">Dashboard</h1>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="d-flex align-items-center">--%>
<%--                <div class="me-3 position-relative">--%>
<%--                    <i class="fas fa-bell fa-lg"></i>--%>
<%--                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">  3 </span>--%>
<%--                </div>--%>
<%--                <img src="https://ui-avatars.com/api/?name=Admin&background=random" class="rounded-circle"--%>
<%--                     width="40" height="40" alt="User">--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</header>--%>