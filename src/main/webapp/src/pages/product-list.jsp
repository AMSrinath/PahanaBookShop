<%@ page import="java.util.*" %>
<%@ page import="pahana.education.model.response.InventoryResponse" %>
<%
    String pageTitle = "Dashboard";
    int totalRecords  = (Integer) request.getAttribute("totalRecords");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;

    int pageSize = (Integer) request.getAttribute("pageSize");
    int startRecord = (currentPage - 1) * pageSize + 1;
    int endRecord = Math.min(startRecord + pageSize - 1, totalRecords);
    String baseUrl = request.getContextPath() + "/inventory";
%>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <h2 class="page-title"></h2>
                <button id="add-customer-btn" class="btn btn-primary" >
                    <a href="${pageContext.request.contextPath}/inventory?action=ADD-NEW">
                        <i class="fas fa-plus me-2"></i>Add New Product
                    </a>
                </button>
            </div>

            <div class="row">
                <div class="customer-table">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3><i class="fas fa-users me-2"></i>Product List</h3>
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
                                <th></th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody id="customerTableBody">
                            <%
                                List<InventoryResponse> itemsList = (List<InventoryResponse>) request.getAttribute("inventoryList");
                                if (itemsList != null) {
                                    for (int i = 0; i < itemsList.size(); i++) {
                                        InventoryResponse item = itemsList.get(i);
                                        String imagePath = (item != null && item.getDefaultImage() != null && !item.getDefaultImage().isEmpty())
                                                ? request.getContextPath() + "/" + item.getDefaultImage()
                                                : request.getContextPath() + "/src/assets/images/product-default.jpeg";
                            %>
                            <tr>
                                <td><img src="<%= imagePath%>" style="width: 80px; height: auto; object-fit: cover;"></td>
                                <td><%= item.getId() %></td>
                                <td><%= item.getName() %>
                                </td>
                                <td><%= !item.getActive() ? "<span class=\"badge badge-active\">Active</span>" : ""   %>
                                </td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1002"
                                            onclick="location.href='${pageContext.request.contextPath}/inventory?id=<%= item.getId() %>'">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn" data-id="<%= item.getId() %>">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <div>Showing  <%= startRecord %> to <%= endRecord %> of <%= totalRecords %> entries</div>
                        <nav>
                            <ul class="pagination mb-0">
                                <li class="page-item <%= (currentPage <= 1) ? "disabled" : "" %>">
                                    <a class="page-link" href="<%= baseUrl + "?page=" + (currentPage - 1) %>">Previous</a>
                                </li>

                                <% for (int i = 1; i <= totalPages; i++) { %>
                                <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                                    <a class="page-link" href="<%= baseUrl + "?page=" + i %>"><%= i %></a>
                                </li>
                                <% } %>

                                <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : "" %>">
                                    <a class="page-link" href="<%= baseUrl + "?page=" + (currentPage + 1) %>">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this product type?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Yes, Delete</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="../includes/toast-message.jsp" %>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        let deleteId = null;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));

        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function () {
                deleteId = this.getAttribute('data-id');
                deleteModal.show();
            });
        });

        document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
            if (!deleteId) return;

            const deleteData = {
                inventoryId: deleteId,
            };
            $.ajax({
                url: "<%= request.getContextPath() %>/inventory",
                type: "DELETE",
                data: JSON.stringify(deleteData),
                processData: false,
                contentType: "application/json",
                success: function (response) {
                    if (response.code === 200) {
                        deleteModal.hide();
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.reload();
                        }, 2000);
                    } else {
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    showToast("Request failed: ", xhr);
                }
            });
        });
    });
</script>

<%@ include file="../includes/footer.jsp" %>