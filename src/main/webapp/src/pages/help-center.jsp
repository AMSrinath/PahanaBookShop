<%
    String pageTitle = "Help Center";
%>

<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="help-center-view">
        <div class="container-fluid py-4">
            <div class="help-container">
                <div class="help-header">
                    <h1><i class="fas fa-life-ring me-2"></i>Help Center</h1>
                    <p>Find answers to your questions and learn how to use Pahana Book Shop system</p>
                </div>

                <div class="row">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="category-card dashboard">
                            <div class="category-icon">
                                <i class="fas fa-tachometer-alt"></i>
                            </div>
                            <h3>Dashboard</h3>
                            <p>Learn how to navigate and interpret your dashboard metrics and reports.</p>
                            <ul>
                                <li>Understanding sales statistics</li>
                                <li>Reading performance charts</li>
                                <li>Customizing your dashboard</li>
                            </ul>
                            <a href="#" class="read-more">
                                Read more <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="category-card products">
                            <div class="category-icon">
                                <i class="fas fa-book"></i>
                            </div>
                            <h3>Products Management</h3>
                            <p>Manage your inventory, add new products, and update existing items.</p>
                            <ul>
                                <li>Adding new books to inventory</li>
                                <li>Updating product information</li>
                                <li>Managing stock levels</li>
                            </ul>
                            <a href="#" class="read-more">
                                Read more <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="category-card sales">
                            <div class="category-icon">
                                <i class="fas fa-receipt"></i>
                            </div>
                            <h3>Sales & Transactions</h3>
                            <p>Process sales, manage transactions, and handle customer payments.</p>
                            <ul>
                                <li>Creating new sales records</li>
                                <li>Processing payments</li>
                                <li>Managing transaction history</li>
                            </ul>
                            <a href="#" class="read-more">
                                Read more <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="category-card users">
                            <div class="category-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h3>User Management</h3>
                            <p>Add staff members, manage permissions, and control system access.</p>
                            <ul>
                                <li>Creating user accounts</li>
                                <li>Setting permission levels</li>
                                <li>Managing user activities</li>
                            </ul>
                            <a href="#" class="read-more">
                                Read more <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="category-card reports">
                            <div class="category-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <h3>Reports & Analytics</h3>
                            <p>Generate detailed reports and analyze your business performance.</p>
                            <ul>
                                <li>Sales reports generation</li>
                                <li>Inventory analysis</li>
                                <li>Exporting report data</li>
                            </ul>
                            <a href="#" class="read-more">
                                Read more <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="fas fa-cog"></i>
                            </div>
                            <h3>System Settings</h3>
                            <p>Configure system preferences, store information, and backup data.</p>
                            <ul>
                                <li>Store configuration</li>
                                <li>System preferences</li>
                                <li>Data backup and restore</li>
                            </ul>
                            <a href="#" class="read-more">
                                Read more <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h2 class="faq-title">Frequently Asked Questions</h2>

                    <div class="accordion" id="helpAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    How do I add a new product to the inventory?
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    To add a new product, navigate to the Products section from the sidebar, click on the "Add New Product" button, fill in the required information including product name, category, price, and stock quantity, then click "Save". You can also upload product images for better presentation.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    How can I generate a sales report?
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    Sales reports can be generated from the Reports section. Select the date range, report type (daily, weekly, monthly), and any specific filters you need. Click "Generate Report" to view the data, and use the "Export" button to download it in PDF or Excel format.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    What should I do if I forget my password?
                                </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    If you forget your password, click on the "Forgot Password" link on the login page. Enter your registered email address, and you will receive instructions to reset your password. If you continue to experience issues, contact your system administrator.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingFour">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                    How do I process a return or refund?
                                </button>
                            </h2>
                            <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    To process a return, go to the Sales section and locate the original transaction. Click on the "Return" button next to the sale, select the items being returned, and specify the reason. The system will calculate the refund amount and update inventory accordingly.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="support-card">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h3>Still need help?</h3>
                            <p>Our support team is here to assist you with any questions or issues you may encounter.</p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn">
                                <i class="fas fa-envelope me-2"></i>Contact Support
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>