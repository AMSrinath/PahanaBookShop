<%@ page import="pahana.education.model.response.UserRoleResponse" %>
<%@ page import="pahana.education.model.response.UserDataResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.education.util.enums.Gender" %>
<%
    String pageTitle = "User Form";
    String idParam = request.getParameter("id");
    UserDataResponse userResponse = (UserDataResponse) request.getAttribute("userData");
    boolean isPasswordHide = (userResponse != null);

    String baseUrl = request.getContextPath();
    String imagePath = (userResponse != null && userResponse.getUserImagePath() != null && !userResponse.getUserImagePath().isEmpty())
            ? baseUrl + "/" + userResponse.getUserImagePath()
            : baseUrl + "/src/assets/images/default.jpg";
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
                    <h2 id="form-title"><i class="fas fa-user-plus me-2"></i>Add New User</h2>
                    <div class="form-buttons">
                        <% if (!isPasswordHide) { %>
                        <button type="button" class="btn btn-outline-secondary" id="clear-btn">
                            Clear
                        </button>
                        <% } %>
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
                            <select name="userTitle" class="form-select" id="title" >
                                <option value="">-- Select Inventory Type --</option>
                                <option value="Mr." <%= (userResponse != null && "Mr.".equalsIgnoreCase(userResponse.getTitle())) ? "selected" : "" %>>Mr.</option>
                                <option value="Mrs." <%= (userResponse != null && "Mrs.".equalsIgnoreCase(userResponse.getTitle())) ? "selected" : "" %>>Mrs.</option>
                                <option value="Miss." <%= (userResponse != null && "Miss.".equalsIgnoreCase(userResponse.getTitle())) ? "selected" : "" %>>Miss.</option>
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
                                            boolean isSelected = (userResponse != null && userResponse.getUserRole().getId() == role.getId());
                                %>
                                <option value="<%= role.getId() %>" <%= isSelected ? "selected" : "" %> > <%= role.getTitle() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Account No</label>
                            <input type="text" name="accountNo" class="form-control" placeholder="Enter Account No" required id="accountNo"
                                   value="<%= (userResponse != null) ? userResponse.getAccountNo() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phoneNo" class="form-control" placeholder="Enter phone no" required id="phoneNo"
                                   value="<%= (userResponse != null) ? userResponse.getPhoneNo() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter email" required id="email"
                                   value="<%= (userResponse != null) ? userResponse.getEmail() : "" %>">
                        </div>

                        <% if (!isPasswordHide) { %>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" name="password" class="form-control" placeholder="Enter password" required id="password">
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                        <% } %>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-control" placeholder="Enter date of birth" required id="dateOfBirth"
                                   value="<%= (userResponse != null) ? userResponse.getDateOfBirth() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select" id="gender" required>
                                <option value="">-- Select Inventory Type --</option>
                                <option value="MALE" <%= (userResponse != null && userResponse.getGender() == Gender.MALE) ? "selected" : "" %>>MALE</option>
                                <option value="FEMALE" <%= (userResponse != null && userResponse.getGender() == Gender.FEMALE) ? "selected" : "" %>>FEMALE</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea name="address" class="form-control" placeholder="Enter billing address" id="address" rows="3">
                                <%= (userResponse != null) ? userResponse.getAddress().trim() : "" %>
                            </textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Image</label>
                            <div class="image-upload-container">
                                <div class="image-preview-form mb-3" id="imagePreview">
                                    <img id="previewImage" src="<%= imagePath%>" />
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

<%@ include file="../includes/toast-message.jsp" %>

<script>
    const isPasswordShowHide = <%= isPasswordHide %>;
    if (!isPasswordShowHide) {
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
    }


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
        const idParam = '<%= (idParam != null) ? idParam : "" %>';

        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update User');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }

        const previewSrc = $("#previewImage").attr("src");

        if (previewSrc && !previewSrc.startsWith("data:image") && !previewSrc.includes("default.jpg")) {
            convertImageToBase64(previewSrc, function (base64) {
                base64ImageData = base64;
            });
        }

        $("#imageFile").on("change", function () {
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                base64ImageData = e.target.result;
                $("#previewImage").attr("src", base64ImageData);
            };
            reader.readAsDataURL(file);
        });

        $("#save-btn").click(function() {
            if (!validateForm()) {
                return;
            }

            const newFormData = {
                userId: $('[name="userId"]').val().trim(),
                userTitle: $('[name="userTitle"]').val(),
                userRoleId: $('[name="userRoleId"]').val().trim(),
                firstName: $('[name="firstName"]').val().trim(),
                lastName: $('[name="lastName"]').val().trim(),
                phoneNo: $('[name="phoneNo"]').val().trim(),
                email: $('[name="email"]').val().trim(),
                password: (isPasswordShowHide === true) ? "" : $('[name="password"]').val().trim(),
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
                contentType: "application/json",
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
                    showToast("Request failed: ", xhr);
                }
            });
        });
    });

    $("#clear-btn").click(function() {
        $("#customerForm")[0].reset();
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


    function convertImageToBase64(imageUrl, callback) {
        fetch(imageUrl)
            .then(response => response.blob())
            .then(blob => {
                const reader = new FileReader();
                reader.onloadend = function () {
                    callback(reader.result);
                };
                reader.readAsDataURL(blob);
            })
            .catch(error => {
                console.error("Failed to convert image to base64:", error);
                callback(""); // fallback if fetch fails
            });
    }

    function validateForm() {
        const firstName = $('[name="firstName"]').val().trim();
        const lastName = $('[name="lastName"]').val().trim();
        const phoneNo = $('[name="phoneNo"]').val().trim();
        const email = $('[name="email"]').val().trim();
        const gender = $('[name="gender"]').val();
        const dateOfBirth = $('[name="dateOfBirth"]').val();
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

        if (!gender) {
            showToast("Please select gender ", "error");
            return false;
        }

        if (!dateOfBirth) {
            showToast("Please add the date of birth ", "error");
            return false;
        }

        return true;
    }
</script>

<%@ include file="../includes/footer.jsp" %>