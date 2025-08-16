<%@ page import="pahana.education.model.response.UserRoleResponse" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = "Customer Form";
    String idParam = request.getParameter("id");
    String formType = request.getParameter("type");
%>


<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <button id="" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/user?type=customer">
                        <i class="fas fa-arrow-left me-2"></i>Back to <span id="backType"></span>
                    </a>
                </button>
            </div>

            <div class="custom-form-view">
                <div class="form-header">
                    <h2 id="form-title"><i class="fas fa-user-plus me-2"></i>Add New Customer</h2>
                    <div class="form-buttons">
                        <button type="button" class="btn btn-outline-secondary" id="clear-btn">
                            Clear
                        </button>
                        <button type="button" class="btn btn-primary" id="save-btn">
                            <i class="fas fa-plus me-2"></i>Save
                        </button>
                    </div>
                </div>

                <form id="customerForm">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Title</label>
                            <select name="title" class="form-select" id="title" >
                                <option></option>
                                <option>Mr.</option>
                                <option>Mrs.</option>
                                <option>Miss.</option>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <input type="text" name="firstName" class="form-control" placeholder="Enter first name" required id="firstName">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" placeholder="Enter last name" required id="lastName">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phoneNo" class="form-control" placeholder="Enter email" required id="phoneNo">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter email" required id="email">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" name="password" class="form-control" placeholder="Enter password" required id="password">
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-control" placeholder="Enter email" required id="dateOfBirth">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select" id="gender" required>
                                <option></option>
                                <option>MALE</option>
                                <option>FEMALE</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea name="address" class="form-control" placeholder="Enter billing address" id="address" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Customer Type</label>
                            <select class="form-select" name="customerTypeId" id="customerTypeId" disabled>
                                <option value="">-- Select Author --</option>
                                    <%
                                    List<UserRoleResponse> roleList = (List<UserRoleResponse>) request.getAttribute("userRoleList");
                                    if (roleList != null) {
                                        for (UserRoleResponse role : roleList) {
                                            boolean isSelected = "customer".equals(role.getName());
                                %>
                                <option value="<%= role.getId() %>"  <%= isSelected ? "selected" : "" %> > <%= role.getTitle() %></option>
                                    <%
                                        }
                                    }
                                %>
                        </div>


                        <div class="col-md-6 mb-3">
                            <label class="form-label">Product Image</label>
                            <div class="image-upload-container">
                                <div class="image-preview-form mb-3" id="imagePreview">
                                    <img id="previewImage" src="" />
                                </div>

                                <div class="input-group mb-2">
                                    <button type="button" class="btn btn-outline-primary" id="uploadTrigger">
                                        <i class="fas fa-upload me-2"></i>Upload Image
                                    </button>
                                    <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" style="display: none;">
                                </div>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("togglePassword").addEventListener("click", function () {
        const passwordField = document.getElementById("password");
        const icon = this.querySelector("i");

        if (passwordField.type === "password") {
            passwordField.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordField.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    });


    $(document).ready(function () {
        let base64ImageData = "";
        let typeName = "";
        const idParam = '<%= (idParam != null) ? idParam : "" %>';
        const formType = '<%= (formType != null) ? formType : "" %>';
        console.log("ID Parameter: " + idParam);
        console.log("IformType: " + formType);
        if (idParam) {
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }

        if (formType === 'customer') {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Add New Customer1');
            typeName = "Customer";
        }
        else if (formType === 'customer' && idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update Customer');
            $("#typeNameLabel").text("Customer");
            typeName = "Customer";
        }

        $("#backType").text(typeName);

        $("#save-btn").click(function() {
            const newFormData = {
                productId: $('[name="firstName"]').val(),
                priceListId: $('[name="lastName"]').val(),
                barcode: $('[name="phoneNo"]').val(),
                itemName: $('[name="email"]').val(),
                inventoryTypeId: $('[name="password"]').val(),
                authorId: $('[name="dateOfBirth"]').val(),
                isbnNo: $('[name="gender"]').val(),
                retailPrice: $('[name="address"]').val(),
                costPrice: $('[name="customerTypeId"]').val(),
                qtyHand: $('[name="qtyHand"]').val(),
                productImage: base64ImageData,
            };
            $.ajax({
                url: "<%= request.getContextPath() %>/inventory",
                type: "POST",
                data: JSON.stringify(newFormData),
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.code === 200) {
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "<%= request.getContextPath() %>/inventory";
                        }, 2000);
                    } else {
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    showToast("Request failed: ","error");
                }
            });
        });
    });

    $("#clear-btn").click(function() {
        $("#productForm")[0].reset();
        $("#previewImage").attr("src", "").hide();
        $(".fa-image").show();
    });

</script>

<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999">
    <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>


<%@ include file="../includes/footer.jsp" %>