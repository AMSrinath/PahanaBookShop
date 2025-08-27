<%@ page import="pahana.education.model.response.UserDataResponse" %><%
    int userId = 0;
    UserDataResponse user = (UserDataResponse) session.getAttribute("user");
    if (user != null) {
        userId = user.getId();
    }
%>


<% String pageTitle = "POS System"; %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>

    <div class="view active" id="pos-view">
        <div class="container-fluid py-4">
            <div class="row">
                <!-- Left Column - Product Entry -->
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title mb-4">New Sale</h4>

                            <div class="input-group mb-4">
                                <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                <input type="text" class="form-control form-control-lg"
                                       id="product-search" placeholder="product name or barcode"
                                       autofocus>
                            </div>

                            <div id="product-details" class="d-none">
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label class="form-label">Product Name</label>
                                        <input type="text" class="form-control" id="product-name" readonly>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label">Unit Price</label>
                                        <input type="text" class="form-control" id="unit-price" readonly>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label">Available Qty</label>
                                        <input type="text" class="form-control" id="available-qty" readonly>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label">Quantity</label>
                                        <input type="number" class="form-control" id="sale-qty" value="1" min="1">
                                    </div>
                                    <div class="col-md-2 d-flex align-items-end">
                                        <button class="btn btn-success w-100" id="add-to-cart">Add</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Sale Items Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover" id="sale-table">
                                    <thead class="table-light">
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Qty</th>
                                        <th>Total</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Customer & Payment -->
                <div class="col-lg-4">
                    <!-- Customer Selection -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title mb-4">Customer Information</h4>
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="customer-search"
                                       placeholder="Search customer by name or account">
                            </div>

                            <div id="customer-details" class="d-none">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Name</label>
                                        <input type="text" class="form-control" id="customer-name" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Account No</label>
                                        <input type="text" class="form-control" id="customer-account" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Summary -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title mb-4">Payment Summary</h4>

                            <div class="d-flex justify-content-between mb-2">
                                <span>Subtotal:</span>
                                <span id="subtotal">Rs. 0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Discount:</span>
                                <span id="discount">Rs. 0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tax (8%):</span>
                                <span id="tax">Rs. 0.00</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-3 fw-bold fs-5">
                                <span>Total:</span>
                                <span id="total">Rs. 0.00</span>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Cash Received</label>
                                <input type="number" class="form-control form-control-lg"
                                       id="cash-received" min="0" value="0.00" step="0.01">
                            </div>

                            <div class="d-flex justify-content-between mb-3 fw-bold fs-5">
                                <span>Balance:</span>
                                <span id="balance">Rs. 0.00</span>
                            </div>

                            <div class="d-grid gap-2">
                                <button class="btn btn-success btn-lg" id="complete-sale">Complete Sale</button>
                                <button class="btn btn-outline-secondary" id="print-bill">Print Bill</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Print Template (Hidden) -->
<div id="print-template" class="d-none">
    <div class="text-center">
        <h3>Pahana Book Shop</h3>
        <p>123 Book Street, Colombo</p>
        <p>Invoice: <span id="print-invoice-no"></span></p>
        <hr>
    </div>
    <div id="print-items"></div>
    <hr>
    <div class="d-flex justify-content-between">
        <span>Total:</span>
        <span id="print-total"></span>
    </div>
    <div class="d-flex justify-content-between">
        <span>Cash Received:</span>
        <span id="print-cash"></span>
    </div>
    <div class="d-flex justify-content-between fw-bold">
        <span>Balance:</span>
        <span id="print-balance"></span>
    </div>
    <hr>
    <p class="text-center">Thank you for your purchase!</p>
</div>

<%@ include file="../includes/toast-message.jsp" %>

<%@ include file="../includes/footer.jsp" %>

<script>
    $(document).ready(function() {
        const cart = [];
        let currentProduct = null;
        let currentCustomer = null;

        // Initialize customer search autocomplete
        $("#customer-search").autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/sale?action=search_customers',
                    method: 'POST',
                    data: JSON.stringify({ keywords: request.term }),
                    contentType: "application/json",
                    success: function(data) {
                        if (data.data && data.data.length > 0) {
                            const itemsList = data.data;
                            response($.map(itemsList, function(item) {
                                return {
                                    label: item.fullName + " | Acc. " + item.accountNo,
                                    value: item.fullName,
                                    id: item.id,
                                    customer: item
                                };
                            }));
                        }
                    }
                });
            },
            minLength: 2,
            select: function(event, ui) {
                currentCustomer = ui.item.customer;
                $('#customer-name').val(currentCustomer.fullName);
                $('#customer-account').val(currentCustomer.accountNo);
                $('#customer-details').removeClass('d-none');

                $(this).val(currentCustomer.name);
                return false;
            }
        });


        // Initialize product search autocomplete
        $("#product-search").autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/sale?action=search_products',
                    method: 'POST',
                    data: JSON.stringify({ keywords: request.term }),
                    contentType: "application/json",
                    success: function(data) {
                        if (data.data && data.data.length > 0) {
                            const itemsList = data.data;
                            response($.map(itemsList, function(item) {
                                return {
                                    label: item.name + " | " + item.barcode + "  | Rs. " + item.retailPrice.toFixed(2),
                                    value: item.name,
                                    id: item.id,
                                    product: item
                                };
                            }));
                        }
                    }
                });
            },
            minLength: 2,
            select: function(event, ui) {
                currentProduct = ui.item.product;
                $('#product-name').val(currentProduct.name);
                $('#unit-price').val('Rs. ' + currentProduct.retailPrice.toFixed(2));
                $('#available-qty').val(currentProduct.qtyHand);
                $('#sale-qty').val(1);
                $('#product-details').removeClass('d-none');
                $('#sale-qty').focus();

                $(this).val('');
                return false;
            }
        });

        // Add to cart when Enter is pressed in quantity field
        $('#sale-qty').keypress(function(e) {
            if(e.which === 13) { // Enter key
                $('#add-to-cart').click();
            }
        });

        // Add to cart
        $('#add-to-cart').click(function() {
            if (!currentProduct) {
                alert('Please select a product first');
                return;
            }

            const qty = parseInt($('#sale-qty').val());
            if(qty > currentProduct.stock) {
                alert('Not enough stock available');
                return;
            }

            // Check if product already exists in cart
            const existingItemIndex = cart.findIndex(item => item.id === currentProduct.id);

            if (existingItemIndex >= 0) {
                // Update existing item quantity
                cart[existingItemIndex].qty += qty;
                cart[existingItemIndex].total = (currentProduct.retailPrice * cart[existingItemIndex].qty);
            } else {
                // Add new item to cart
                cart.push({
                    productId: currentProduct.id,
                    name: currentProduct.name,
                    price: currentProduct.retailPrice,
                    qty: qty,
                    total: (currentProduct.retailPrice * qty),
                    costPrice: currentProduct.costPrice,
                    priceListId: currentProduct.priceListId
                });
            }

            updateCartTable();
            $('#product-details').addClass('d-none');
            currentProduct = null;
            $('#product-search').focus();
        });

        function updateCartTable() {
            const $tbody = $('#sale-table tbody');
            $tbody.empty();

            let subtotal = 0;
            cart.forEach(item => {
                subtotal += item.total;
                const row = '<tr>' +
                    '<td>' + item.name + '</td>' +
                    '<td>Rs. ' + item.price + '</td>' +
                    '<td>' + item.qty + '</td>' +
                    '<td>Rs. ' + item.total + '</td>' +
                    '<td><button class="btn btn-sm btn-danger remove-item" data-id="' + item.id + '">' +
                    '<i class="fas fa-trash"></i>' +
                    '</button></td>' +
                    '</tr>';
                $tbody.append(row)
            });

            // Add event listeners for remove buttons
            $('.remove-item').click(function() {
                const id = $(this).data('id');
                const index = cart.findIndex(item => item.id === id);
                if (index !== -1) {
                    cart.splice(index, 1);
                    updateCartTable();
                }
            });

            const tax = subtotal * 0.08;
            const total = subtotal + tax;

            $('#subtotal').text('Rs. ' + subtotal.toFixed(2));
            $('#tax').text('Rs. ' + tax.toFixed(2));
            $('#total').text('Rs. ' + total.toFixed(2));
            calculateBalance();
        }

        // Calculate balance
        $('#cash-received').on('input', calculateBalance);

        function calculateBalance() {
            const total = parseFloat($('#total').text().replace('Rs. ', ''));
            const cash = parseFloat($('#cash-received').val()) || 0;
            const balance = cash - total;

            $('#balance').text('Rs. ' + balance.toFixed(2));
        }

        // Complete sale
        $('#complete-sale').click(function() {
            if(cart.length === 0) {
                alert('Please add items to cart');
                return;
            }

            const saleData = {
                cashierId: 1,
                customerId: currentCustomer ? currentCustomer.id : null,
                saleItems: cart,
                cashReceived: parseFloat($('#cash-received').val()),
                taxAmount: 100,
                total: parseFloat($('#total').text().replace('Rs. ', ''))
            };

            if (saleData.customerId === null ||
                saleData.customerId === undefined ||
                saleData.customerId === 0) {
                showToast("Please select customer", "danger");
            } else if(saleData.cashReceived < saleData.total) {
                showToast("Insufficient cash received", "danger");
            } else {
                $.ajax({
                    url: '${pageContext.request.contextPath}/sale?action=complete_sale',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(saleData),
                    success: function(response) {
                        if (response.code === 200) {
                            showToast(response.message, "success");
                            alert('Sale completed successfully!');

                            $('#print-bill').click();

                            cart.length = 0;
                            updateCartTable();
                            $('#cash-received').val(0);
                            calculateBalance();
                            $('#customer-details').addClass('d-none');
                            currentCustomer = null;
                            $('#product-search').focus();
                        } else {
                            showToast(response.message, "danger");
                            return;
                        }

                    }
                });
            }
        });

        // Print bill
        $('#print-bill').click(function() {
            const printContent = $('#print-template').clone().removeClass('d-none');
            const invoiceNo = 'INV-' + new Date().getTime();

            printContent.find('#print-invoice-no').text(invoiceNo);
            printContent.find('#print-total').text($('#total').text());
            printContent.find('#print-cash').text('Rs. ' + $('#cash-received').val());
            printContent.find('#print-balance').text($('#balance').text());

            const $itemsContainer = printContent.find('#print-items');
            console.log("Cart", cart);
            cart.forEach(item => {
                $itemsContainer.append(`
                <div class="d-flex justify-content-between">
                    <span>\${item.name} x \${item.qty}</span>
                    <span>Rs. \${item.total.toFixed(2)}</span>
                </div>
            `);
            });

            const printWindow = window.open('', '_blank');
            printWindow.document.write('<html><head><title>Receipt</title>');
            printWindow.document.write('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">');
            printWindow.document.write('</head><body>');
            printWindow.document.write(printContent.html());
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        });
    });
</script>