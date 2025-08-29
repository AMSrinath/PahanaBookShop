<%@ page import="java.util.List" %>
<%@ page import="pahana.education.model.response.*" %>
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

    .item-avatar {
        width: 80px;
        height: 100px;
        color: white;
        font-weight: bold;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 18px;
    }

    .status-badge {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
    }
    .status-completed {
        background: #e6f4ee;
        color: var(--success1);
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
                        <div class="icon" style="color: #e74a3b">
                            <i class="fas fa-receipt"></i>
                        </div>
                        <h5>Sales Count</h5>
                        <h2><%= dashboardData.getSaleCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #4895ef">
                            <i class="fas fa-sack-dollar"></i>
                        </div>
                        <h5>Total Sales</h5>
                        <h2>Rs. <%= dashboardData.getSaleTotal() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #bb09fa;">
                            <i class="fas fa-calendar-minus"></i>
                        </div>
                        <h5>Lash Month Sales</h5>
                        <h2>Rs. <%= dashboardData.getLastMonth() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #bb09fa;">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h5>Current Monthly Sales</h5>
                        <h2>Rs. <%= dashboardData.getCurrentMonth() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card ">
                        <div class="icon" style="color: #1cc88a">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Users count</h5>
                        <h2><%= dashboardData.getUserCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #1cc88a">
                            <i class="fas fa-user-tag"></i>
                        </div>
                        <h5>Customer count</h5>
                        <h2><%= dashboardData.getCustomerCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #36b9cc">
                            <i class="fas fa-box-open"></i>
                        </div>
                        <h5>Items count</h5>
                        <h2><%= dashboardData.getInventoryCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #f6c23e">
                            <i class="fas fa-warehouse"></i>
                        </div>
                        <h5>Stock count</h5>
                        <h2><%= dashboardData.getStockCount() %></h2>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon" style="color: #f6c23e">
                            <i class="fas fa-coins"></i>
                        </div>
                        <h5>Total Stock</h5>
                        <h2>Rs. <%= dashboardData.getStockValue() %></h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Recent Transactions -->
                <div class="col-xl-8 col-lg-7">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Recent Transactions</h6>
                            <a href="#" class="btn btn-sm btn-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="recent-table">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th scope="col">Invoice No</th>
                                            <th scope="col">Customer</th>
                                            <th scope="col">Date</th>
                                            <th scope="col">Status</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <%
                                            List<RecentSalesInfo> recentSalesInfos = dashboardData.getRecentSalesInfoList();
                                            if (recentSalesInfos != null) {
                                                for (int i = 0; i < recentSalesInfos.size(); i++) {
                                                    RecentSalesInfo item = recentSalesInfos.get(i);
                                                    assert item != null;%>

                                                <tr>
                                                    <td>#<%=item.getInvoiceNo() %></td>
                                                    <td><%=item.getCustomerFullName() %></td>
                                                    <td><%=item.getInvoiceDate() %></td>
                                                    <td><span class="status-badge status-completed"><%=!item.isStatus() ? " Complete" : "Failed" %></span></td>
                                                </tr>
                                            <% } %>
                                        <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions and Inventory Alerts -->
                <div class="col-xl-4 col-lg-5">
                    <!-- Quick Actions -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>
                        </div>
                        <div class="card-body">
                            <div class="quick-actions">
                                <button class="action-btn">
                                    <i class="fas fa-plus-circle"></i>
                                    <span>New Sale</span>
                                </button>
                                <button class="action-btn">
                                    <i class="fas fa-user-plus"></i>
                                    <span>Add Customer</span>
                                </button>
                                <button class="action-btn">
                                    <i class="fas fa-box"></i>
                                    <span>Add Product</span>
                                </button>
                                <button class="action-btn">
                                    <i class="fas fa-file-invoice"></i>
                                    <span>Generate Report</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xl-6 col-lg-7">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Recent Customers</h6>
                        </div>
                        <div class="card-body">
                            <%
                                List<CustomerList> customerLists = dashboardData.getCustomerList();
                                if (customerLists != null) {
                                    for (int i = 0; i < customerLists.size(); i++) {
                                        CustomerList item = customerLists.get(i);
                                        String imagePath = (item != null && item.getUserImage() != null && !item.getUserImage().isEmpty())
                                                ? request.getContextPath() + "/" + item.getUserImage()
                                                : request.getContextPath() + "/src/assets/images/user-default.png";
                                        assert item != null;%>
                            <div class="user-card">
                                <div class="user-avatar" style="background: linear-gradient(45deg, #4cc9f0, #4895ef);">
                                    <img src="<%= imagePath %>" alt="User Avatar" style="width: 100%; height: 100%; border-radius: 50%;">
                                </div>
                                <div>
                                    <h5 class="mb-1"><%= item.getFullName() %></h5>
                                    <p class="mb-0 text-muted small">Joined: <%= item.getJoinedDate() %></p>
                                </div>
                            </div>

                                <% } %>
                            <% } %>

                        </div>
                    </div>
                </div>

                <!-- Recent Customers -->
                <div class="col-xl-6 col-lg-5">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Recent Products</h6>
                        </div>
                        <div class="card-body">
                            <%
                                List<ProductList> productList = dashboardData.getItemsList();
                                if (productList != null) {
                                    for (int i = 0; i < productList.size(); i++) {
                                        ProductList item = productList.get(i);
                                        String imagePath = (item != null && item.getItemImage() != null && !item.getItemImage().isEmpty())
                                                ? request.getContextPath() + "/" + item.getItemImage()
                                                : request.getContextPath() + "/src/assets/images/product-default.jpeg";
                                        assert item != null;%>
                            <div class="user-card">
                                <div class="item-avatar">
                                    <img src="<%= imagePath %>" alt="User Avatar" style="width: 100%; height: 100%;">
                                </div>
                                <div>
                                    <h5 class="mb-1"><%= item.getItemName() %></h5>
                                    <p class="mb-0 text-muted small">Rs. <%= item.getSalePrice() %></p>
                                    <p class="mb-0 text-muted small">Qty. <%= item.getQty() %></p>
                                    <p class="mb-0 text-muted small">Added: <%= item.getAddDate() %></p>
                                </div>
                            </div>

                            <% } %>
                            <% } %>

                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>

</div>

<%@ include file="../includes/footer.jsp" %>
