<%@ page import="pahana.education.model.response.UserRoleResponse" %>
<%@ page import="pahana.education.model.response.UserDataResponse" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = "User Form";
    String idParam = request.getParameter("id");
    UserDataResponse userResponse = (UserDataResponse) request.getAttribute("userData");
%>


<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <button id="" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/user?type=user&action=list">
                        <i class="fas fa-arrow-left me-2"></i>Back to <span id="backType"></span>
                    </a>
                </button>
            </div>

            <div class="custom-form-view">
                <div class="form-header">
                    <h2 id="form-title"><i class="fas fa-user-plus me-2"></i>Add New user</h2>
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
                        <input type="hidden" name="userId" id="userId" value="<%= (userResponse != null) ? userResponse.getId() : "" %>">
                        <input type="hidden" name="userRoleId" id="userRoleId" value="<%= (userResponse != null) ? userResponse.getUserRole().getId() : "" %>">

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
                            <input type="text" name="firstName" class="form-control" placeholder="Enter first name" required id="firstName"
                                   value="<%= (userResponse != null) ? userResponse.getFirstName() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" placeholder="Enter last name" required id="lastName"
                                   value="<%= (userResponse != null) ? userResponse.getLastName() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Type</label>
                            <select class="form-select" name="customerTypeId" id="customerTypeId">
                                <option value="">-- Select Author --</option>
                                <%
                                    List<UserRoleResponse> roleList = (List<UserRoleResponse>) request.getAttribute("userRoleList");
                                    if (roleList != null) {
                                        for (UserRoleResponse role : roleList) {
                                %>
                                <option value="<%= role.getId() %>"  > <%= role.getTitle() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Account No</label>
                            <input type="text" name="accountNo" class="form-control" placeholder="Enter Account No" required id="accountNo">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phoneNo" class="form-control" placeholder="Enter phone no" required id="phoneNo">
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
                            <label class="form-label">Product Image</label>
                            <div class="image-upload-container">
                                <div class="image-preview-form mb-3" id="imagePreview">
                                    <img id="previewImage" src="${pageContext.request.contextPath}/src/assets/images/default.jpg" />
                                </div>

                                <div class="input-group mb-2">
                                    <button type="button" class="btn btn-outline-primary" id="uploadTrigger">
                                        <i class="fas fa-upload me-2"></i>User Image
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

    toggleAccountNo();
    $('#customerTypeId').change(toggleAccountNo);

    function toggleAccountNo() {
        const selectedText = $('#customerTypeId option:selected').text().trim().toLowerCase();
        const isCustomer = selectedText === 'customer';

        const $accountNoField = $('[name="accountNo"]');

        if (isCustomer) {
            $accountNoField.prop('disabled', false);
        } else {
            $accountNoField.prop('disabled', true).val('');
        }
    }

    $(document).ready(function () {
        let base64ImageData = "";
        let typeName = "";
        const idParam = '<%= (idParam != null) ? idParam : "" %>';

        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update User');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }

        document.getElementById("imageFile").addEventListener("change", function () {
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                base64ImageData = e.target.result;
                document.getElementById("previewImage").src = base64ImageData;
            };

            reader.readAsDataURL(file);
        });

        $("#save-btn").click(function() {
            if (!validateForm()) {
                return;
            }
            const newFormData = {
                userId: $('[name="userId"]').val().trim(),
                userRoleId: $('[name="userRoleId"]').val().trim(),
                firstName: $('[name="firstName"]').val().trim(),
                lastName: $('[name="lastName"]').val().trim(),
                phoneNo: $('[name="phoneNo"]').val().trim(),
                email: $('[name="email"]').val().trim(),
                password: $('[name="password"]').val().trim(),
                dateOfBirth: $('[name="dateOfBirth"]').val(),
                gender: $('[name="gender"]').val(),
                address: $('[name="address"]').val().trim(),
                customerTypeId: $('[name="customerTypeId"]').val(),
                accountNo: $('[name="accountNo"]').val().trim(),
                userImage: base64ImageData,
            };
            $.ajax({
                url: "<%= request.getContextPath() %>/user",
                type: "POST",
                data: JSON.stringify(newFormData),
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.code === 200) {
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "<%= request.getContextPath() %>/user?type=user&action=list";
                        }, 2000);
                    } else {
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    console.log("Request failed:", xhr);
                    showToast("Request failed: ", xhr);
                }
            });
        });
    });

    $("#clear-btn").click(function() {
        $("#productForm")[0].reset();
        $("#previewImage").attr("src", "").hide();
        $(".fa-image").show();
    });

    document.getElementById("imageFile").addEventListener("change", function () {
        const file = this.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function (e) {
            base64ImageData = e.target.result;
            document.getElementById("previewImage").src = base64ImageData;
        };

        reader.readAsDataURL(file);
    });

    $("#imageFile").change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $("#previewImage").attr("src", e.target.result).show();
                $(".fa-image").hide();
            }
            reader.readAsDataURL(file);
        }
    });

    $("#uploadTrigger").click(function() {
        $("#imageFile").click();
    });

    $("#removeImageBtn").click(function() {
        $("#imageFile").val("");
        $("#previewImage").attr("src", "").hide();
        $(".fa-image").show();
    });


    function validateForm() {
        const firstName = $('[name="firstName"]').val().trim();
        const lastName = $('[name="lastName"]').val().trim();
        const phoneNo = $('[name="phoneNo"]').val().trim();
        const email = $('[name="email"]').val().trim();
        const selectedText = $('#customerTypeId option:selected').text().trim().toLowerCase();

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phoneRegex = /^\d{10}$/;

        if (!firstName) {
            showToast("First Name is required", "error");
            return false;
        }

        if (!lastName) {
            showToast("Last Name is required", "error");
            return false;
        }

        if (!phoneNo) {
            showToast("Phone Number is required", "error");
            return false;
        } else if (!phoneRegex.test(phoneNo)) {
            showToast("Phone Number must be 10 digits", "error");
            return false;
        }

        if (selectedText === 'customer' && !$('#accountNo').val().trim()) {
            showToast("Account No is required for customers", "error");
            return false;
        }

        if (!email) {
            showToast("Email is required", "error");
            return false;
        } else if (!emailRegex.test(email)) {
            showToast("Please enter a valid email address", "error");
            return false;
        }

        return true;
    }
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