
<% String pageTitle = "Dashboard"; %>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="back-btn" id="back-to-customers">
                <a href="customer-list.jsp.jsp">
                    <i class="fas fa-arrow-left me-2"></i> Back to Customers
                </a>
            </div>

            <div class="custom-form-view">
                <div class="form-header">
                    <h2 id="form-title"><i class="fas fa-user-plus me-2"></i>Add New Customer</h2>
                    <div class="form-buttons">
                        <button type="button" class="btn btn-outline-secondary" id="clear-btn">
                            Clear
                        </button>
                        <button type="button" class="btn btn-primary" id="save-btn">
                            <i class="fas fa-plus me-2"></i>Save
                        </button>
                    </div>
                </div>

                <form id="customerForm">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" placeholder="Enter full name" required id="fullName">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" placeholder="Enter email" required id="email">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" placeholder="Enter phone number" id="phone">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Company</label>
                            <input type="text" class="form-control" placeholder="Enter company name" id="company">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Customer Type</label>
                            <select class="form-select" id="customerType">
                                <option>Individual</option>
                                <option>Business</option>
                                <option>VIP</option>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Status</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="active" checked>
                                    <label class="form-check-label" for="active">Active</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="inactive">
                                    <label class="form-check-label" for="inactive">Inactive</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Billing Address</label>
                        <textarea class="form-control" placeholder="Enter billing address" id="address" rows="3"></textarea>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>