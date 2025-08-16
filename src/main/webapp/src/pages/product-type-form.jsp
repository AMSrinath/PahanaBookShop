<%@ page import="pahana.education.model.response.InventoryTypeResponse" %>
<%@ page import="java.util.Map" %>
<%
    String pageTitle = "Product Type";
    String idParam = request.getParameter("id");
    InventoryTypeResponse inventoryType = (InventoryTypeResponse) request.getAttribute("inventoryType");
%>

<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <button id="" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/inventory-type">
                        <i class="fas fa-arrow-left me-2"></i>Back to Product Types
                    </a>
                </button>
            </div>

            <div class="row">
                <div class="custom-form-view">
                    <div class="form-header">
                        <h2 id="form-title"><i class="fas fa-user-plus me-2"></i>Add New Product Type</h2>
                        <div class="form-buttons">
                            <button type="button" class="btn btn-sm btn-outline-secondary" id="clear-btn">
                                Clear
                            </button>
                            <button type="button" class="btn btn-sm btn-primary" id="save-btn">
                                <i class="fas fa-plus me-2"></i>Save
                            </button>
                        </div>
                    </div>

                    <form id="product-type-form" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <input type="hidden" name="id" id="productTypeId" value="<%= (inventoryType != null) ? inventoryType.getId() : "" %>">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Product Type</label>
                                <input type="text" name="productTypeName" class="form-control" placeholder="Enter Product Type"  required
                                       id="productTypeName"
                                       value="<%= (inventoryType != null) ? inventoryType.getName() : "" %>">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>


<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999">
    <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const idParam = '<%= (idParam != null) ? idParam : "" %>';
        console.log("ID Parameter: " + idParam);
        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update Product Type');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }


        $("#save-btn").click(function() {
            const productTypeName = $("#productTypeName").val().trim();
            if (!productTypeName) {
                showToast("Product Type Name is required.", "error");
                return;
            }

            const formData = new FormData($("#product-type-form")[0]);
            $.ajax({
                url: "<%= request.getContextPath() %>/inventory-type",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.code === 200) {
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "<%= request.getContextPath() %>/inventory-type";
                        }, 2000);
                    } else {
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    showToast("Request failed: ","error");
                }
            });
        });
    });
</script>


<%@ include file="../includes/footer.jsp" %>