<%@ page import="java.util.*" %>
<%@ page import="pahana.education.model.response.ReportCustomerPurchase" %>
<%@ page import="pahana.education.model.response.ReportProductWise" %>
<%
    String pageTitle = "Product Stock Report";
%>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="row">
                <div class="customer-table">
                    <div class="d-flex justify-content-end mb-3">
                        <button class="btn btn-outline-secondary" onclick="window.print()">
                            <i class="fas fa-print"></i> Print
                        </button>
                    </div>

                    <div class="print-header text-center d-none d-print-block mb-4">
                        <h2 class="mb-1">Pahana Edu Book Shop</h2>
                        <p class="mb-0">No.123, Colombo</p>
                        <p class="mb-0">Phone: 0112345678</p>
                        <hr>
                        <h4 class="mt-3">Product List</h4>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover table-sm">
                            <thead>
                            <tr>
                                <th></th>
                                <th>Barcode.No</th>
                                <th>Product</th>
                                <th>Type</th>
                                <th>Quantity</th>
                                <th>Sell Price (Rs.)</th>
                            </tr>
                            </thead>
                            <tbody id="customerTableBody">
                            <%
                                int qtyTotal = 0;
                                double sellTotal = 0.0;
                                List<ReportProductWise> itemsList = (List<ReportProductWise>) request.getAttribute("reportDataList");
                                if (itemsList != null) {
                                    for (int i = 0; i < itemsList.size(); i++) {
                                        ReportProductWise item = itemsList.get(i);
                                        String imagePath = (item != null && item.getItemImage() != null && !item.getItemImage().isEmpty())
                                                ? request.getContextPath() + "/" + item.getItemImage()
                                                : request.getContextPath() + "/src/assets/images/product-default.jpeg";

                                        assert item != null;
                                        qtyTotal += item.getQty() ;
                                        sellTotal += item.getSellPrice() ;
                            %>
                            <tr>
                                <td><img src="<%= imagePath%>" style="width: 80px; height: auto; object-fit: cover;"></td>
                                <td><%= item.getBarcode()%></td>
                                <td><%= item.getItemName() %></td>
                                <td><%= item.getTypeName() %></td>
                                <td><%= item.getQty() %></td>
                                <td><%= String.format("%.2f", (double) item.getSellPrice())%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="4" class="text-end fw-bold">Grand Total:</td>
                                <td class="fw-bold"><%= qtyTotal %></td>
                                <td class="fw-bold"><%= String.format("%.2f", sellTotal) %></td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
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