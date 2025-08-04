

<% String pageTitle = "Dashboard"; %>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <h2 class="page-title"></h2>
                <button id="add-customer-btn" class="btn btn-primary">
                    <a href="user-form.jsp">
                        <i class="fas fa-plus me-2"></i>Add New Product
                    </a>
                </button>
            </div>

            <div class="row">
                <div class="customer-table">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3><i class="fas fa-users me-2"></i>Product Type List</h3>
                        <div class="d-flex">
                            <input type="text" class="form-control me-2" placeholder="Search customers"
                                   id="searchInput">
                            <button class="btn btn-outline-secondary">
                                <i class="fas fa-filter"></i>
                            </button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover table-sm">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="customerTableBody">
                            <tr>
                                <td>#C1001</td>
                                <td>Isabella Christensen</td>
                                <td>isabella@example.com</td>
                                <td><span class="badge badge-vip">VIP</span></td>
                                <td><span class="badge badge-active">Active</span></td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1001">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>#C1002</td>
                                <td>John Doe</td>
                                <td>john@example.com</td>
                                <td><span class="badge badge-business">Business</span></td>
                                <td><span class="badge badge-active">Active</span></td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1002">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>#C1003</td>
                                <td>Emma Smith</td>
                                <td>emma@example.com</td>
                                <td><span class="badge badge-individual">Individual</span></td>
                                <td><span class="badge badge-pending">Pending</span></td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1003">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>#C1004</td>
                                <td>Michael Johnson</td>
                                <td>michael@example.com</td>
                                <td><span class="badge badge-business">Business</span></td>
                                <td><span class="badge badge-active">Active</span></td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1004">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>#C1005</td>
                                <td>Sarah Williams</td>
                                <td>sarah@example.com</td>
                                <td><span class="badge badge-vip">VIP</span></td>
                                <td><span class="badge badge-inactive">Inactive</span></td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1005">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <div>Showing 1 to 5 of 15 entries</div>
                        <nav>
                            <ul class="pagination mb-0">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%@ include file="../includes/footer.jsp" %>