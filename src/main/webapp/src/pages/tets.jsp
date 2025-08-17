<% String pageTitle = "POS System"; %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

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

                            <!-- Barcode Scanner Input -->
                            <div class="input-group mb-4">
                                <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                <input type="text" class="form-control form-control-lg"
                                       id="barcode-input" placeholder="Scan barcode or enter product code"
                                       autofocus>
                                <button class="btn btn-primary" id="add-item-btn">Add Item</button>
                            </div>

                            <!-- Product Details (Dynamically Filled) -->
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
                                    <!-- Will be populated dynamically -->
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
                                <button class="btn btn-outline-secondary" type="button"
                                        id="new-customer-btn">New</button>
                            </div>

                            <div id="customer-details" class="d-none">
                                <div class="mb-3">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" id="customer-name" readonly>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Phone</label>
                                        <input type="text" class="form-control" id="customer-phone" readonly>
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

<%@ include file="../includes/footer.jsp" %>

<script>
    $(document).ready(function() {
        const cart = [];
        let currentProduct = null;
        let currentCustomer = null;

        // Barcode scanning/entry
        $('#barcode-input').keypress(function(e) {
            if(e.which === 13) {
                fetchProduct($(this).val());
            }
        });

        $('#add-item-btn').click(function() {
            fetchProduct($('#barcode-input').val());
        });

        function fetchProduct(barcode) {
            // AJAX call to get product details
            $.ajax({
                url: '${pageContext.request.contextPath}/pos?action=getProduct&barcode=' + barcode,
                method: 'GET',
                success: function(data) {
                    if(data) {
                        currentProduct = data;
                        $('#product-name').val(data.name);
                        $('#unit-price').val('Rs. ' + data.price.toFixed(2));
                        $('#available-qty').val(data.stock);
                        $('#sale-qty').val(1);
                        $('#product-details').removeClass('d-none');
                        $('#sale-qty').focus();
                    } else {
                        alert('Product not found!');
                    }
                    $('#barcode-input').val('').focus();
                }
            });
        }

        // Add to cart
        $('#add-to-cart').click(function() {
            const qty = parseInt($('#sale-qty').val());
            if(qty > currentProduct.stock) {
                alert('Not enough stock available');
                return;
            }

            cart.push({
                id: currentProduct.id,
                name: currentProduct.name,
                price: currentProduct.price,
                qty: qty,
                total: (currentProduct.price * qty)
            });

            updateCartTable();
            $('#product-details').addClass('d-none');
            currentProduct = null;
        });

        function updateCartTable() {
            const $tbody = $('#sale-table tbody');
            $tbody.empty();

            let subtotal = 0;

            cart.forEach(item => {
                subtotal += item.total;
                $tbody.append(`
                <tr>
                    <td>${item.name}</td>
                    <td>Rs. ${item.price.toFixed(2)}</td>
                    <td>${item.qty}</td>
                    <td>Rs. ${item.total.toFixed(2)}</td>
                    <td><button class="btn btn-sm btn-danger remove-item" data-id="${item.id}"><i class="fas fa-trash"></i></button></td>
                </tr>
            `);
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
                customerId: currentCustomer ? currentCustomer.id : null,
                items: cart,
                cashReceived: parseFloat($('#cash-received').val()),
                total: parseFloat($('#total').text().replace('Rs. ', ''))
            };

            // AJAX call to save sale
            $.ajax({
                url: '${pageContext.request.contextPath}/pos?action=completeSale',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(saleData),
                success: function(response) {
                    alert('Sale completed successfully!');
                    // Reset form
                    cart.length = 0;
                    updateCartTable();
                    $('#cash-received').val(0);
                    calculateBalance();
                    $('#customer-details').addClass('d-none');
                    currentCustomer = null;
                }
            });
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
            cart.forEach(item => {
                $itemsContainer.append(`
                <div class="d-flex justify-content-between">
                    <span>${item.name} x ${item.qty}</span>
                    <span>Rs. ${item.total.toFixed(2)}</span>
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