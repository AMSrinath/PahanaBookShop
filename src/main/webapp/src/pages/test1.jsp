<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant POS Bill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Courier New', monospace;
        }

        body {
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            width: 100%;
            display: flex;
            gap: 30px;
        }

        .pos-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 25px;
            flex: 1;
        }

        .bill-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 0;
            width: 350px;
            position: relative;
            overflow: hidden;
        }

        .header {
            text-align: center;
            padding: 25px 0 15px;
            border-bottom: 2px dashed #e1e1e1;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #2c3e50, #1a1a2e);
            color: white;
        }

        .restaurant-name {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 5px;
            text-transform: uppercase;
        }

        .restaurant-address {
            font-size: 14px;
            margin-bottom: 5px;
            opacity: 0.9;
        }

        .contact {
            font-size: 14px;
            margin-bottom: 15px;
            opacity: 0.9;
        }

        .invoice-info {
            display: flex;
            justify-content: space-between;
            padding: 15px 30px;
            background: #f8f9fa;
            border-bottom: 1px dashed #ccc;
        }

        .info-item {
            font-size: 15px;
            font-weight: bold;
        }

        .invoice-date {
            display: flex;
            justify-content: space-between;
            padding: 10px 30px;
            background: #f8f9fa;
        }

        .items {
            padding: 0 30px;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px dashed #eee;
        }

        .item-name {
            flex: 3;
            font-size: 16px;
        }

        .item-price {
            flex: 1;
            text-align: right;
            font-size: 16px;
        }

        .summary {
            padding: 15px 30px;
            background: #f8f9fa;
            border-top: 2px dashed #ccc;
            border-bottom: 2px dashed #ccc;
            margin: 10px 0;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
        }

        .grand-total {
            font-weight: bold;
            font-size: 18px;
            padding: 12px 0;
            border-top: 2px solid #333;
            border-bottom: 2px solid #333;
            margin: 10px 0;
        }

        .payment {
            display: flex;
            justify-content: space-between;
            padding: 15px 30px;
            background: #f0f8ff;
            font-weight: bold;
            margin-top: 15px;
        }

        .footer {
            text-align: center;
            padding: 20px 30px;
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }

        .thank-you {
            font-size: 16px;
            font-weight: bold;
            margin: 15px 0;
            color: #2c3e50;
        }

        .discount-offer {
            background: #fff8e1;
            border: 1px dashed #ffc107;
            padding: 15px;
            margin: 15px 30px;
            border-radius: 8px;
            font-size: 14px;
            text-align: center;
        }

        .signature {
            text-align: right;
            padding: 15px 30px 5px;
            font-weight: bold;
            font-size: 16px;
            border-top: 1px dashed #ccc;
            margin-top: 10px;
        }

        /* POS Interface Styles */
        .pos-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }

        .pos-title {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }

        .control-panel {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-bottom: 25px;
        }

        .control-btn {
            padding: 15px 10px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .control-btn i {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .control-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .order-panel {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .order-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #2c3e50;
            display: flex;
            justify-content: space-between;
        }

        .order-items {
            max-height: 250px;
            overflow-y: auto;
            padding-right: 10px;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px dashed #ddd;
        }

        .item-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            background: #e74c3c;
            color: white;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn.edit {
            background: #3498db;
        }

        .payment-panel {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .customer-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }

        .payment-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }

        .panel-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .input-group input, .input-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
        }

        .totals {
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            margin-top: 15px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
        }

        .final-row {
            font-weight: bold;
            font-size: 18px;
            padding: 12px 0;
            border-top: 2px solid #eee;
        }

        .complete-btn {
            width: 100%;
            padding: 16px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s;
        }

        .complete-btn:hover {
            background: #219653;
            transform: translateY(-2px);
        }

        .print-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #3498db;
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            z-index: 10;
        }

        @media print {
            body * {
                visibility: hidden;
            }
            .bill-container, .bill-container * {
                visibility: visible;
            }
            .bill-container {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                box-shadow: none;
            }
            .print-btn {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="pos-container">
        <div class="pos-header">
            <h1 class="pos-title">Restaurant POS System</h1>
            <div class="datetime">
                <div id="current-date"></div>
                <div id="current-time"></div>
            </div>
        </div>

        <div class="control-panel">
            <button class="control-btn">
                <i class="fas fa-utensils"></i>
                Food
            </button>
            <button class="control-btn">
                <i class="fas fa-beer"></i>
                Drinks
            </button>
            <button class="control-btn">
                <i class="fas fa-wine-bottle"></i>
                Alcohol
            </button>
            <button class="control-btn">
                <i class="fas fa-ice-cream"></i>
                Desserts
            </button>
            <button class="control-btn">
                <i class="fas fa-coffee"></i>
                Coffee
            </button>
            <button class="control-btn">
                <i class="fas fa-search"></i>
                Search
            </button>
            <button class="control-btn">
                <i class="fas fa-barcode"></i>
                Scan
            </button>
            <button class="control-btn">
                <i class="fas fa-undo"></i>
                Void
            </button>
        </div>

        <div class="order-panel">
            <div class="order-title">
                <span>Current Order</span>
                <span>Table 25</span>
            </div>
            <div class="order-items">
                <div class="order-item">
                    <div class="item-name">2 Carlsberg Bottle</div>
                    <div class="item-price">$16.00</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">3 Heineken Draft Standard</div>
                    <div class="item-price">$24.60</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">1 Heineken Draft Half Liter</div>
                    <div class="item-price">$15.20</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">2 Carlsberg Bucket (5 bottles)</div>
                    <div class="item-price">$80.00</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">4 Grilled Chicken Breast</div>
                    <div class="item-price">$74.00</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">3 Sirloin Steak</div>
                    <div class="item-price">$96.00</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">1 Coke</div>
                    <div class="item-price">$3.50</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="item-name">5 Ice Cream</div>
                    <div class="item-price">$18.00</div>
                    <div class="item-actions">
                        <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                        <button class="action-btn"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
            </div>
        </div>

        <div class="payment-panel">
            <div class="customer-info">
                <h3 class="panel-title">Customer Information</h3>
                <div class="input-group">
                    <label for="customer-name">Name</label>
                    <input type="text" id="customer-name" value="John Smith">
                </div>
                <div class="input-group">
                    <label for="table-number">Table Number</label>
                    <input type="text" id="table-number" value="25">
                </div>
                <div class="input-group">
                    <label for="customer-phone">Phone</label>
                    <input type="text" id="customer-phone" value="(555) 123-4567">
                </div>
                <div class="input-group">
                    <label for="special-requests">Special Requests</label>
                    <input type="text" id="special-requests" placeholder="Any special requests?">
                </div>
            </div>

            <div class="payment-info">
                <h3 class="panel-title">Payment Information</h3>
                <div class="input-group">
                    <label for="payment-method">Payment Method</label>
                    <select id="payment-method">
                        <option>Cash</option>
                        <option>Credit Card</option>
                        <option>Debit Card</option>
                        <option>Mobile Payment</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="cash-received">Cash Received ($)</label>
                    <input type="number" id="cash-received" value="400.00">
                </div>

                <div class="totals">
                    <div class="total-row">
                        <span>Subtotal:</span>
                        <span>$327.30</span>
                    </div>
                    <div class="total-row">
                        <span>Sales/Gov Tax (5%):</span>
                        <span>$16.36</span>
                    </div>
                    <div class="total-row">
                        <span>Service Charge (10%):</span>
                        <span>$32.73</span>
                    </div>
                    <div class="final-row">
                        <span>GRAND TOTAL:</span>
                        <span>$376.40</span>
                    </div>
                    <div class="final-row">
                        <span>Cash Change:</span>
                        <span>$23.60</span>
                    </div>
                </div>

                <button class="complete-btn">
                    <i class="fas fa-check-circle"></i> Complete Payment
                </button>
            </div>
        </div>
    </div>

    <div class="bill-container">
        <button class="print-btn" onclick="window.print()">
            <i class="fas fa-print"></i>
        </button>

        <div class="header">
            <div class="restaurant-name">The Lone Pine</div>
            <div class="restaurant-address">43 Manchester Road</div>
            <div class="restaurant-address">12480 Brisbane Australia</div>
            <div class="contact">617-3236-6207</div>
        </div>

        <div class="invoice-info">
            <div class="info-item">Invoice: 08000008</div>
            <div class="info-item">Table: 25</div>
        </div>

        <div class="invoice-date">
            <div>09/04/08</div>
            <div>12:45</div>
        </div>

        <div class="items">
            <div class="item-row">
                <div class="item-name">2 Carlsberg Bottle</div>
                <div class="item-price">16.00</div>
            </div>
            <div class="item-row">
                <div class="item-name">3 Heineken Draft Standard</div>
                <div class="item-price">24.60</div>
            </div>
            <div class="item-row">
                <div class="item-name">1 Heineken Draft Half Liter</div>
                <div class="item-price">15.20</div>
            </div>
            <div class="item-row">
                <div class="item-name">2 Carlsberg Bucket (5 bottles)</div>
                <div class="item-price">80.00</div>
            </div>
            <div class="item-row">
                <div class="item-name">4 Grilled Chicken Breast</div>
                <div class="item-price">74.00</div>
            </div>
            <div class="item-row">
                <div class="item-name">3 Sirloin Steak</div>
                <div class="item-price">96.00</div>
            </div>
            <div class="item-row">
                <div class="item-name">1 Coke</div>
                <div class="item-price">3.50</div>
            </div>
            <div class="item-row">
                <div class="item-name">5 Ice Cream</div>
                <div class="item-price">18.00</div>
            </div>
        </div>

        <div class="summary">
            <div class="summary-row">
                <span>Subtotal</span>
                <span>327.30</span>
            </div>
            <div class="summary-row">
                <span>Sales/Gov Tax - 5%</span>
                <span>16.36</span>
            </div>
            <div class="summary-row">
                <span>Service Charge - 10%</span>
                <span>32.73</span>
            </div>
        </div>

        <div class="grand-total summary-row">
            <span>GRAND TOTAL</span>
            <span>376.40</span>
        </div>

        <div class="payment">
            <span>Thank you and see you again!</span>
            <div>
                <div>Cash Change</div>
                <div>400.00 23.60</div>
            </div>
        </div>

        <div class="signature">John</div>

        <div class="discount-offer">
            Bring this bill back within the next 10 days and get 15% discount on that day's food bill...
        </div>

        <div class="footer">
            <div class="thank-you">Thank you for dining with us!</div>
            <div>Prices include all applicable taxes</div>
            <div>No returns or exchanges on food items</div>
            <div>Manager: John Anderson • Server: Sarah Johnson</div>
        </div>
    </div>
</div>

<script>
    // Update current date and time
    function updateDateTime() {
        const now = new Date();
        const dateStr = now.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            weekday: 'long'
        });

        const timeStr = now.toLocaleTimeString('en-US', {
            hour: '2-digit',
            minute: '2-digit'
        });

        document.getElementById('current-date').textContent = dateStr;
        document.getElementById('current-time').textContent = timeStr;
    }

    // Update time every minute
    updateDateTime();
    setInterval(updateDateTime, 60000);

    // Print functionality
    document.querySelector('.print-btn').addEventListener('click', function() {
        window.print();
    });
</script>
</body>
</html>