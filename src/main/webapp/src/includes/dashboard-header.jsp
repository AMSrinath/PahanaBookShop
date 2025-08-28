

<%
    String sessionUserImage = (sessionUser != null && sessionUser.getUserImagePath() != null && !sessionUser.getUserImagePath().isEmpty())
            ? request.getContextPath() + "/" + sessionUser.getUserImagePath()
            : request.getContextPath() + "/src/assets/images/user-default.png";

    assert sessionUser != null;%>

<header class="dashboard-header">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <button class="btn mobile-toggle me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <div>
                    <h1 class="mb-0"> <%= pageTitle %></h1>
                </div>
            </div>

            <div class="d-flex align-items-center">
                <!-- Notifications -->
                <div class="me-3 position-relative">
                    <i class="fas fa-bell fa-lg"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">3</span>
                </div>

                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                       id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="<%= sessionUserImage %>" class="rounded-circle me-2"
                             width="40" height="40" alt="User">
                        <span class="text-dark fw-semibold"><%= sessionUser.getFirstName() %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user?id=<%= sessionUser.getId() %>&action=my_account">
                                <i class="fas fa-user me-2"></i>My Account
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                 <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
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