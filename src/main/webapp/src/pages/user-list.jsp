<%@ page import="java.util.*" %>
<%@ page import="pahana.education.model.response.UserDataResponse" %>
<%
    String pageTitle = "Customer";
    int totalRecords  = (Integer) request.getAttribute("totalRecords");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;

    int pageSize = (Integer) request.getAttribute("pageSize");
    int startRecord = (currentPage - 1) * pageSize + 1;
    int endRecord = Math.min(startRecord + pageSize - 1, totalRecords);
    String baseUrl = request.getContextPath() + "/user?type=user&action=list";
    String imageUrl = request.getContextPath();
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
                    <a href="${pageContext.request.contextPath}/user?type=user&action=add_new">
                        <i class="fas fa-plus me-2"></i>Add New User
                    </a>
                </button>
            </div>

            <div class="row">
                <div class="customer-table">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3><i class="fas fa-users me-2"></i>Customer List</h3>
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
                                <th>Account No</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody id="customerTableBody">
                            <%
                                List<UserDataResponse> customerList = (List<UserDataResponse>) request.getAttribute("customerList");
                                if (customerList != null) {
                                    for (int i = 0; i < customerList.size(); i++) {
                                        UserDataResponse customer = customerList.get(i);

                                        String imagePath = (customer != null && customer.getUserImagePath() != null && !customer.getUserImagePath().isEmpty())
                                                ? imageUrl + "/" + customer.getUserImagePath()
                                                : imageUrl + "/src/assets/images/user-default.png";
                            %>
                            <tr>
                                <td><img src="<%= imagePath %>" style="width: 80px; height: auto; object-fit: cover;"></td>
                                <td><%= customer.getId() %></td>
                                <td><%= customer.getAccountNo() %></td>
                                <td><%= customer.getFullName() %></td>
                                <td><%= customer.getEmail() %></td>
                                <td><%= customer.getPhoneNo() %></td>
                                <td><%= !customer.getActive() ? "<span class=\"badge badge-active\">Active</span>" : ""   %>
                                </td>
                                <td class="action-buttons">
                                    <button class="btn btn-sm btn-primary edit-btn" data-id="C1002"
                                            onclick="location.href='${pageContext.request.contextPath}/user?id=<%= customer.getId() %>'">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger delete-btn" data-id="<%= customer.getId() %>">
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
                                    <a class="page-link" href="<%= baseUrl + "&page=" + (currentPage - 1) %>">Previous</a>
                                </li>

                                <% for (int i = 1; i <= totalPages; i++) { %>
                                <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                                    <a class="page-link" href="<%= baseUrl + "&page=" + i %>"><%= i %></a>
                                </li>
                                <% } %>

                                <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : "" %>">
                                    <a class="page-link" href="<%= baseUrl + "&page=" + (currentPage + 1) %>">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%@ include file="../modals/delete-modal.jsp" %>

<%@ include file="../includes/toast-message.jsp" %>

<script>
    document.getElementById('searchInput').addEventListener('keyup', function () {
        const query = this.value.toLowerCase();
        const rows = document.querySelectorAll('#customerTableBody tr');

        rows.forEach(row => {
            const rowText = row.textContent.toLowerCase();
            row.style.display = rowText.includes(query) ? '' : 'none';
        });

        const pagination = document.querySelector('.pagination');
        if (pagination) {
            pagination.style.display = query.length > 0 ? 'none' : '';
        }
    });

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
                userId: deleteId,
            };
            $.ajax({
                url: "<%= request.getContextPath() %>/user",
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