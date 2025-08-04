<%@ page import="pahana.education.model.response.inventory.InventoryTypeResponse" %>
<%
    String pageTitle = "Dashboard";
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
                    <a href="product-type-list.jsp">
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

                    <form id="inventory-type-form" action="${pageContext.request.contextPath}/inventory-type" method="post">
                        <div class="row">
                            <input type="text" name="id" id="productTypeId" value="<%= (inventoryType != null) ? inventoryType.getId() : "" %>">
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


<script>
    $(document).ready(function () {
        const idParam = '<%= (idParam != null) ? idParam : "" %>';
        console.log("ID Parameter: " + idParam);
        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update Product Type');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }
    });


    document.getElementById("save-btn").addEventListener("click", function () {
        document.getElementById("inventory-type-form").submit();
    });

    <%--$('#save-btn').click(function () {--%>
    <%--    const id = $('#productTypeId').val();--%>
    <%--    const name = $('#productTypeName').val();--%>

    <%--    const payload = JSON.stringify({--%>
    <%--        id: id,--%>
    <%--        name: name--%>
    <%--    });--%>

    <%--    console.log(" asd: " + payload);--%>
    <%--    $.ajax({--%>
    <%--        url: `${pageContext.request.contextPath}/inventory-type`,--%>
    <%--        method: id ? 'PUT' : 'POST',--%>
    <%--        contentType: 'application/json',--%>
    <%--        data: payload,--%>
    <%--        success: function () {--%>
    <%--            alert("Success!");--%>
    <%--            // window.location.href = 'product-type-list.jsp';--%>
    <%--        },--%>
    <%--        error: function (xhr, status, error) {--%>
    <%--            console.error("Error:", error);--%>
    <%--            alert("Failed to save product type.");--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>



</script>


<%@ include file="../includes/footer.jsp" %>