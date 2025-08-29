<%@ page import="java.util.*" %>
<%@ page import="pahana.education.model.response.ReportCustomerPurchase" %>
<%
    String pageTitle = "Daily Sales Report";
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

<%@ include file="../includes/footer.jsp" %>