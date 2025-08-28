<%@ page import="java.util.*" %>
<%@ page import="pahana.education.model.response.ReportCustomerPurchase" %>
<%
    String pageTitle = "Customer Purchase Report";
%>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="row">
                <div class="customer-table">
                    <div class="table-responsive">
                        <table class="table table-hover table-sm">
                            <thead>
                            <tr>
                                <th></th>
                                <th>Invoice.No</th>
                                <th>Product</th>
                                <th>Type</th>
                                <th>Unit Price (Rs.)</th>
                                <th>Qty</th>
                                <th>Total Price (Rs.)</th>
                            </tr>
                            </thead>
                            <tbody id="customerTableBody">
                            <%
                                double grandTotal = 0.0;
                                List<ReportCustomerPurchase> itemsList = (List<ReportCustomerPurchase>) request.getAttribute("reportDataList");
                                if (itemsList != null) {
                                    for (int i = 0; i < itemsList.size(); i++) {
                                        ReportCustomerPurchase item = itemsList.get(i);
                                        String imagePath = (item != null && item.getProductImage() != null && !item.getProductImage().isEmpty())
                                                ? request.getContextPath() + "/" + item.getProductImage()
                                                : request.getContextPath() + "/src/assets/images/product-default.jpeg";

                                        grandTotal += item.getTotal() ;
                            %>
                            <tr>
                                <td><img src="<%= imagePath%>" style="width: 80px; height: auto; object-fit: cover;"></td>
                                <td><%= item.getInvoice_no()%></td>
                                <td><%= item.getProductName() %></td>
                                <td><%= item.getProductType() %></td>
                                <td><%= String.format("%.2f", (double) item.getRetailPrice()) %> </td>
                                <td><%= item.getQty()%></td>
                                 <td><%= String.format("%.2f", (double) item.getTotal())%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" class="text-end fw-bold">Grand Total:</td>
                                <td class="fw-bold"><%= String.format("%.2f", grandTotal) %></td>
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