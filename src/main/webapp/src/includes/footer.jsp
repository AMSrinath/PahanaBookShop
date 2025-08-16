<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.querySelector('.mobile-toggle').addEventListener('click', function () {
        document.querySelector('.sidebar').classList.toggle('active');
    });

    // View switching functionality
    document.querySelectorAll('.nav-link[data-view]').forEach(link => {
        link.addEventListener('click', function (e) {
            // e.preventDefault();

            document.querySelectorAll('.nav-link').forEach(el => {
                el.classList.remove('active');
            });

            // Add active class to clicked link
            this.classList.add('active');

            // Hide all views
            document.querySelectorAll('.view').forEach(view => {
                view.classList.remove('active');
            });

            // Show selected view
            const viewId = this.getAttribute('data-view') + '-view';
            document.getElementById(viewId).classList.add('active');

            // Update header title
            const title = this.textContent.trim();
            document.querySelector('.dashboard-header h1').textContent = title;
        });
    });

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function (event) {
        const sidebar = document.querySelector('.sidebar');
        const mobileToggle = document.querySelector('.mobile-toggle');

        if (window.innerWidth <= 992 &&
            !sidebar.contains(event.target) &&
            !mobileToggle.contains(event.target) &&
            sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
        }
    });

    // Form submission handling
    // document.getElementById('customerForm').addEventListener('submit', function (e) {
    //     e.preventDefault();
    //     alert('Customer added successfully!');
    //     this.reset();
    // });

    // Delete button handling
    <%--document.querySelectorAll('.btn-danger').forEach(button => {--%>
    <%--    button.addEventListener('click', function () {--%>
    <%--        const row = this.closest('tr');--%>
    <%--        const customerName = row.querySelector('td:nth-child(2)').textContent;--%>

    <%--        if (confirm(`Are you sure you want to delete ${customerName}?`)) {--%>
    <%--            row.remove();--%>
    <%--            alert('Customer deleted successfully!');--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>


    // Customer form functionality
    const addCustomerBtn = document.getElementById('add-customer-btn');
    const backToCustomers = document.getElementById('back-to-customers');
    const formTitle = document.getElementById('form-title');
    const saveBtn = document.getElementById('save-btn');
    const clearBtn = document.getElementById('clear-btn');
    const customerForm = document.getElementById('customerForm');

    // Show form for adding new customer
    // addCustomerBtn.addEventListener('click', function () {
    //     document.getElementById('customers-view').classList.remove('active');
    //     document.getElementById('customer-form-view').classList.add('active');
    //     formTitle.innerHTML = '<i class="fas fa-user-plus me-2"></i>Add New Customer';
    //     saveBtn.innerHTML = '<i class="fas fa-plus me-2"></i>Save';
    //     clearBtn.textContent = 'Clear';
    //     customerForm.reset();
    //     document.getElementById('page-title').textContent = 'Add Customer';
    // });

    // Back to customers list
    // backToCustomers.addEventListener('click', function () {
    //     document.getElementById('customer-form-view').classList.remove('active');
    //     document.getElementById('customers-view').classList.add('active');
    //     document.getElementById('page-title').textContent = 'Customers';
    // });

    // Edit customer button handling
    /*document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            const id = this.getAttribute('data-id');
            const row = this.closest('.customer-row');
            const name = row.querySelector('h5').textContent;
            const email = row.querySelector('p:nth-child(2)').textContent.replace('Email: ', '');
            const phone = row.querySelector('p:nth-child(3)').textContent.replace('Phone: ', '');
            const address = row.querySelector('p:nth-child(4)').textContent.replace('Billing Address: ', '');
            const type = row.querySelector('.customer-type').textContent;

            // Populate form
            document.getElementById('fullName').value = name;
            document.getElementById('email').value = email;
            document.getElementById('phone').value = phone;
            document.getElementById('address').value = address;
            document.getElementById('customerType').value = type;

            // Update form title and buttons
            formTitle.innerHTML = `<i class="fas fa-user-edit me-2"></i>Edit Customer #${id}`;
            saveBtn.innerHTML = '<i class="fas fa-save me-2"></i>Update';

            // Show form view
            document.getElementById('customers-view').classList.remove('active');
            document.getElementById('customer-form-view').classList.add('active');
            document.getElementById('page-title').textContent = 'Edit Customer';
        });
    });*/

    // Clear/Reset form
    // clearBtn.addEventListener('click', function () {
    //     customerForm.reset();
    // });

    // SaveUpdate customer
    /*saveBtn.addEventListener('click', function () {
        const fullName = document.getElementById('fullName').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        const company = document.getElementById('company').value;
        const customerType = document.getElementById('customerType').value;
        const address = document.getElementById('address').value;

        if (!fullName || !email) {
            alert('Please fill in all required fields');
            return;
        }

        // Show success message
        if (saveBtn.textContent.includes('Save')) {
            alert('New customer added successfully!');
        } else {
            alert('Customer updated successfully!');
        }

        // Go back to customers list
        document.getElementById('customer-form-view').classList.remove('active');
        document.getElementById('customers-view').classList.add('active');
        document.getElementById('page-title').textContent = 'Customers';
    });*/
</script>
</body>

</html>