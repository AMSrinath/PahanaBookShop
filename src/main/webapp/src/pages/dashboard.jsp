
<% String pageTitle = "Dashboard"; %>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>
sss
<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid py-4">
            <!-- Stats Row 1 -->
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h5>Monthly Sales</h5>
                        <h2>$249.95</h2>
                        <div class="d-flex align-items-center">
                            <span class="text-success me-2"><i class="fas fa-arrow-up"></i> 67%</span>
                            <span>vs last month</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-success" style="width: 67%"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-thumbs-up"></i>
                        </div>
                        <h5>Details</h5>
                        <h2>Engagement</h2>
                        <div class="d-flex align-items-center">
                            <span class="text-success me-2"><i class="fas fa-arrow-up"></i> 7.2%</span>
                            <span>Total Likes</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-info" style="width: 72%"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5>Monthly Sales</h5>
                        <h2>$2,942.32</h2>
                        <div class="d-flex align-items-center">
                            <span class="text-warning me-2"><i class="fas fa-arrow-up"></i> 36%</span>
                            <span>vs last month</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-warning" style="width: 36%"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="card stat-card">
                        <div class="icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h5>Yearly Sales</h5>
                        <h2>$8,638.32</h2>
                        <div class="d-flex align-items-center">
                            <span class="text-success me-2"><i class="fas fa-arrow-up"></i> 80%</span>
                            <span>vs last year</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-success" style="width: 80%"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content Row -->
            <div class="row">
                <!-- Left Column - Chart -->
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="card-title mb-0">Sales Performance</h4>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button"
                                            id="chartDropdown" data-bs-toggle="dropdown">
                                        Last 30 Days
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Last 7 Days</a></li>
                                        <li><a class="dropdown-item" href="#">Last 30 Days</a></li>
                                        <li><a class="dropdown-item" href="#">Last 90 Days</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="chart-placeholder">
                                <div class="axis-label y-left">0.4</div>
                                <div class="axis-label y-right">10,500</div>
                                <div class="axis-label x-bottom">1.1 MAY 12:56</div>
                                <div class="chart-percentage">+5.9% Total Likes</div>

                                <!-- Chart visualization lines -->
                                <div
                                        style="position: absolute; bottom: 30px; left: 10%; width: 80%; height: 1px; background: rgba(0,0,0,0.1);">
                                </div>
                                <div
                                        style="position: absolute; bottom: 80px; left: 10%; width: 80%; height: 1px; background: rgba(0,0,0,0.1);">
                                </div>
                                <div
                                        style="position: absolute; bottom: 130px; left: 10%; width: 80%; height: 1px; background: rgba(0,0,0,0.1);">
                                </div>

                                <!-- Chart data points -->
                                <div
                                        style="position: absolute; bottom: 30px; left: 15%; width: 8px; height: 80px; background-color: var(--primary); border-radius: 4px 4px 0 0;">
                                </div>
                                <div
                                        style="position: absolute; bottom: 30px; left: 30%; width: 8px; height: 120px; background-color: var(--info); border-radius: 4px 4px 0 0;">
                                </div>
                                <div
                                        style="position: absolute; bottom: 30px; left: 45%; width: 8px; height: 160px; background-color: var(--success); border-radius: 4px 4px 0 0;">
                                </div>
                                <div
                                        style="position: absolute; bottom: 30px; left: 60%; width: 8px; height: 100px; background-color: var(--warning); border-radius: 4px 4px 0 0;">
                                </div>
                                <div
                                        style="position: absolute; bottom: 30px; left: 75%; width: 8px; height: 140px; background-color: var(--primary); border-radius: 4px 4px 0 0;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Targets Row -->
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card target-card">
                                <h4>Target: 35,098</h4>
                                <div class="d-flex justify-content-between">
                                    <span>Duration: 350</span>
                                    <span class="text-success">82%</span>
                                </div>
                                <div class="progress mt-2">
                                    <div class="progress-bar" style="width: 82%"></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card target-card">
                                <h4>Target: 34,185</h4>
                                <div class="d-flex justify-content-between">
                                    <span>Duration: 800</span>
                                    <span class="text-warning">65%</span>
                                </div>
                                <div class="progress mt-2">
                                    <div class="progress-bar bg-warning" style="width: 65%"></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card target-card">
                                <h4>Target: 25,998</h4>
                                <div class="d-flex justify-content-between">
                                    <span>Duration: 300</span>
                                    <span class="text-success">91%</span>
                                </div>
                                <div class="progress mt-2">
                                    <div class="progress-bar bg-success" style="width: 91%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Additional Info -->
                <div class="col-lg-4">
                    <!-- Recent Users -->
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Recent Users</h4>
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


