<%@ page import="pahana.education.model.response.DashBoardResponse" %>
<%
    String pageTitle = "Dashboard";
    DashBoardResponse dashboardData = null;
    dashboardData  = (DashBoardResponse) request.getAttribute("dashboardData");
    if (dashboardData == null) {
        dashboardData = new DashBoardResponse();
    }

    double current = dashboardData.getCurrentMonth();
    double last = dashboardData.getLastMonth();
    double percentChange = 0;
    if (last > 0) {
        percentChange = ((double)(current - last) / last) * 100;
    } else {
        percentChange = ((double)(current) / last) * 100;
    }
    String progressColor = percentChange >= 0 ? "bg-success" : "bg-danger";
%>

<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .stat-card {
        background: linear-gradient(145deg, #ffffff, #f0f0f0);
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        padding: 20px;
        margin-bottom: 25px;
        transition: all 0.3s ease-in-out;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 25px rgba(0, 0, 0, 0.12);
    }

    .stat-card .icon {
        font-size: 2rem;
        margin-bottom: 10px;
        color: #4e73df;
    }

    .stat-card h5 {
        font-weight: 600;
        color: #6c757d;
    }

    .stat-card h2 {
        font-weight: bold;
        color: #343a40;
    }

    .progress {
        height: 8px;
        border-radius: 10px;
        background-color: #e9ecef;
    }

    .progress-bar {
        transition: width 1s ease-in-out;
    }

    .user-card {
        background: #fff;
        padding: 15px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 15px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .user-avatar {
        width: 50px;
        height: 50px;
        background-color: #6c757d;
        border-radius: 50%;
        color: white;
        font-weight: bold;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 18px;
    }
</style>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid py-4">
            <!-- Stats Row 1 -->
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-receipt"></i>
                        </div>
                        <h5>Sales Count</h5>
                        <h2><%= dashboardData.getSaleCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-sack-dollar"></i>
                        </div>
                        <h5>Total Sales</h5>
                        <h2>Rs. <%= dashboardData.getSaleTotal() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-calendar-minus"></i>
                        </div>
                        <h5>Lash Month Sales</h5>
                        <h2>Rs. <%= dashboardData.getLastMonth() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h5>Current Monthly Sales</h5>
                        <h2>Rs. <%= dashboardData.getCurrentMonth() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Users count</h5>
                        <h2><%= dashboardData.getUserCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-user-tag"></i>
                        </div>
                        <h5>Customer count</h5>
                        <h2><%= dashboardData.getCustomerCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-box-open"></i>
                        </div>
                        <h5>Items count</h5>
                        <h2><%= dashboardData.getInventoryCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-warehouse"></i>
                        </div>
                        <h5>Stock count</h5>
                        <h2><%= dashboardData.getStockCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-coins"></i>
                        </div>
                        <h5>Total Stock</h5>
                        <h2>Rs. <%= dashboardData.getStockValue() %></h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-4">
                    <!-- Recent Users -->
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Customers</h4>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <span class="text-success me-2"><i class="fas fa-arrow-up"></i> 6.2%</span>
                                    <span>Total Likes</span>
                                </div>
                                <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>

                            <div class="card user-card">
                                <div class="user-avatar">IC</div>
                                <div>
                                    <h5 class="mb-1">Isabella Christensen</h5>
                                    <p class="mb-0 text-muted small">Lorem Ipsum is simply dummy text of...</p>
                                </div>
                            </div>

                            <div class="card user-card">
                                <div class="user-avatar"
                                     style="background: linear-gradient(45deg, #f72585, #7209b7);">JD</div>
                                <div>
                                    <h5 class="mb-1">John Doe</h5>
                                    <p class="mb-0 text-muted small">Recently purchased premium package</p>
                                </div>
                            </div>

                            <div class="card user-card">
                                <div class="user-avatar"
                                     style="background: linear-gradient(45deg, #4cc9f0, #4895ef);">ES</div>
                                <div>
                                    <h5 class="mb-1">Emma Smith</h5>
                                    <p class="mb-0 text-muted small">Active for 120 days</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Rating -->
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <h5>Customer Rating</h5>
                        <h2>4.7 <span class="fs-6 text-warning"><i class="fas fa-star"></i><i
                                class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                class="fas fa-star-half-alt"></i></span></h2>
                        <div class="d-flex align-items-center">
                            <span class="text-success me-2"><i class="fas fa-arrow-up"></i> 12%</span>
                            <span>vs last month</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-warning" style="width: 94%"></div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>

</div>

<%@ include file="../includes/footer.jsp" %>


