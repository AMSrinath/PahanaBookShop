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
                                <span>Tax (5%):</span>
                                <span id="tax">Rs. 0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Service Charge (10%):</span>
                                <span id="service-charge">Rs. 0.00</span>
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

<!-- Restaurant-Style Print Template -->
<div id="print-template" class="d-none">
    <style>
        .restaurant-bill {
            font-family: 'Courier New', monospace;
            width: 300px;
            margin: 0 auto;
            padding: 15px;
            background: white;
            color: #000;
        }
        .restaurant-header {
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 2px dashed #000;
            margin-bottom: 15px;
        }
        .restaurant-name {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 5px;
            text-transform: uppercase;
        }
        .restaurant-address {
            font-size: 14px;
            margin-bottom: 5px;
        }
        .contact {
            font-size: 14px;
            margin-bottom: 15px;
        }
        .invoice-info {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-weight: bold;
            border-bottom: 1px dashed #ccc;
        }
        .invoice-date {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #ccc;
            margin-bottom: 15px;
        }
        .items {
            margin-bottom: 15px;
        }
        .item-row {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px dashed #eee;
        }
        .item-name {
            flex: 2;
        }
        .item-price {
            text-align: right;
        }
        .summary {
            margin: 15px 0;
            border-top: 2px dashed #ccc;
            border-bottom: 2px dashed #ccc;
            padding: 10px 0;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
        }
        .grand-total {
            font-weight: bold;
            font-size: 18px;
            padding: 10px 0;
            text-align: right;
            border-top: 2px solid #000;
            border-bottom: 2px solid #000;
            margin: 15px 0;
        }
        .payment {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-weight: bold;
            border-top: 1px dashed #ccc;
        }
        .signature {
            text-align: right;
            margin-top: 15px;
            font-weight: bold;
        }
        .discount-offer {
            margin-top: 20px;
            padding: 10px;
            border: 1px dashed #000;
            text-align: center;
            font-size: 14px;
        }
        .thank-you {
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
        }
    </style>

    <div class="restaurant-bill">
        <div class="restaurant-header">
            <div class="restaurant-name">The Lone Pine</div>
            <div class="restaurant-address">43 Manchester Road</div>
            <div class="restaurant-address">12480 Brisbane Australia</div>
            <div class="contact">617-3236-6207</div>
        </div>

        <div class="invoice-info">
            <div class="invoice-no">Invoice: <span id="print-invoice-no"></span></div>
            <div class="table-no">Table: <span id="print-table-no">25</span></div>
        </div>

        <div class="invoice-date">
            <div class="date">Date: <span id="print-date"></span></div>
            <div class="time">Time: <span id="print-time"></span></div>
        </div>

        <div class="items" id="print-items">
            <!-- Items will be added here -->
        </div>

        <div class="summary">
            <div class="summary-row">
                <span>Subtotal</span>
                <span id="print-subtotal">0.00</span>
            </div>
            <div class="summary-row">
                <span>Sales/Gov Tax - 5%</span>
                <span id="print-tax">0.00</span>
            </div>
            <div class="summary-row">
                <span>Service Charge - 10%</span>
                <span id="print-service-charge">0.00</span>
            </div>
        </div>

        <div class="grand-total">
            <span>GRAND TOTAL</span>
            <span id="print-total">0.00</span>
        </div>

        <div class="payment">
            <span>Thank you and see you again!</span>
            <div>
                <div>Cash Change</div>
                <div><span id="print-cash-received">0.00</span> <span id="print-change">0.00</span></div>
            </div>
        </div>

        <div class="signature">
            <span id="print-cashier">John</span>
        </div>

        <div class="discount-offer">
            Bring this bill back within the next 10 days and get 15% discount on that day's food bill...
        </div>

        <div class="thank-you">
            Thank you for dining with us!
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
    $(document).ready(function() {
        const cart = [];
        let currentProduct = null;
        let currentCustomer = null;
        const restaurantDetails = {
            name: "The Lone Pine",
            address: "43 Manchester Road, 12480 Brisbane Australia",
            contact: "617-3236-6207"
        };

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
            // Simulated product data
            const products = [
                { id: 1, barcode: "123456", name: "Carlsberg Bottle", price: 8.00, stock: 50 },
                { id: 2, barcode: "234567", name: "Heineken Draft Standard", price: 8.20, stock: 30 },
                { id: 3, barcode: "345678", name: "Heineken Draft Half Liter", price: 15.20, stock: 25 },
                { id: 4, barcode: "456789", name: "Carlsberg Bucket (5 bottles)", price: 40.00, stock: 20 },
                { id: 5, barcode: "567890", name: "Grilled Chicken Breast", price: 18.50, stock: 40 },
                { id: 6, barcode: "678901", name: "Sirloin Steak", price: 32.00, stock: 30 },
                { id: 7, barcode: "789012", name: "Coke", price: 3.50, stock: 100 },
                { id: 8, barcode: "890123", name: "Ice Cream", price: 3.60, stock: 50 }
            ];

            const product = products.find(p => p.barcode === barcode);

            if(product) {
                currentProduct = product;
                $('#product-name').val(product.name);
                $('#unit-price').val('Rs. ' + product.price.toFixed(2));
                $('#available-qty').val(product.stock);
                $('#sale-qty').val(1);
                $('#product-details').removeClass('d-none');
                $('#sale-qty').focus();
            } else {
                alert('Product not found!');
            }
            $('#barcode-input').val('').focus();
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

            const tax = subtotal * 0.05;
            const serviceCharge = subtotal * 0.10;
            const total = subtotal + tax + serviceCharge;

            $('#subtotal').text('Rs. ' + subtotal.toFixed(2));
            $('#tax').text('Rs. ' + tax.toFixed(2));
            $('#service-charge').text('Rs. ' + serviceCharge.toFixed(2));
            $('#total').text('Rs. ' + total.toFixed(2));
            calculateBalance();
        }

        // Remove item from cart
        $(document).on('click', '.remove-item', function() {
            const id = $(this).data('id');
            const index = cart.findIndex(item => item.id === id);

            if (index !== -1) {
                cart.splice(index, 1);
                updateCartTable();
            }
        });

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

            alert('Sale completed successfully!');
            // Reset form
            cart.length = 0;
            updateCartTable();
            $('#cash-received').val(0);
            calculateBalance();
            $('#customer-details').addClass('d-none');
            currentCustomer = null;
        });

        // Print bill
        $('#print-bill').click(function() {
            if(cart.length === 0) {
                alert('Please add items to cart before printing');
                return;
            }

            const printContent = $('#print-template').clone().removeClass('d-none');
            const now = new Date();

            // Set invoice details
            printContent.find('#print-invoice-no').text('INV-' + now.getTime().toString().slice(-6));
            printContent.find('#print-date').text(formatDate(now));
            printContent.find('#print-time').text(formatTime(now));

            // Set restaurant details
            printContent.find('.restaurant-name').text(restaurantDetails.name);
            printContent.find('.restaurant-address').html(restaurantDetails.address.replace(', ', '<br>'));
            printContent.find('.contact').text(restaurantDetails.contact);

            // Calculate totals
            const subtotal = cart.reduce((sum, item) => sum + item.total, 0);
            const tax = subtotal * 0.05;
            const serviceCharge = subtotal * 0.10;
            const total = subtotal + tax + serviceCharge;
            const cashReceived = parseFloat($('#cash-received').val()) || 0;
            const change = cashReceived - total;

            // Set totals
            printContent.find('#print-subtotal').text(subtotal.toFixed(2));
            printContent.find('#print-tax').text(tax.toFixed(2));
            printContent.find('#print-service-charge').text(serviceCharge.toFixed(2));
            printContent.find('#print-total').text(total.toFixed(2));
            printContent.find('#print-cash-received').text(cashReceived.toFixed(2));
            printContent.find('#print-change').text(change.toFixed(2));

            // Add items
            const $itemsContainer = printContent.find('#print-items');
            cart.forEach(item => {
                $itemsContainer.append(`
                    <div class="item-row">
                        <div class="item-name">${item.qty} ${item.name}</div>
                        <div class="item-price">${item.total.toFixed(2)}</div>
                    </div>
                `);
            });

            const printWindow = window.open('', '_blank');
            printWindow.document.write('<html><head><title>Restaurant Bill</title>');
            printWindow.document.write('<style>' + printContent.find('style').html() + '</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write(printContent.html());
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        });

        // Helper functions for date formatting
        function formatDate(date) {
            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear().toString().slice(-2);
            return `${day}/${month}/${year}`;
        }

        function formatTime(date) {
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            return `${hours}:${minutes}`;
        }
    });
</script>