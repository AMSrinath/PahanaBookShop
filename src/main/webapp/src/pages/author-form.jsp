<%@ page import="pahana.education.model.response.UserDataResponse" %>
<%@ page import="pahana.education.util.enums.Gender" %>
<%@ page import="pahana.education.model.response.AuthorDataResponse" %>
<%
    String pageTitle = "Author Form";
    String idParam = request.getParameter("id");
    AuthorDataResponse authorData = (AuthorDataResponse) request.getAttribute("authorData");
    boolean isAuthorData = (authorData != null);
    String baseUrl = request.getContextPath();
%>


<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <button id="" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/author">
                        <i class="fas fa-arrow-left me-2"></i>Back to Author List</span>
                    </a>
                </button>
            </div>

            <div class="custom-form-view">
                <div class="form-header">
                    <h2 id="form-title"><i class="fas fa-user-plus me-2"></i>Add New Author</h2>
                    <div class="form-buttons">
                        <% if (!isAuthorData) { %>
                        <button type="button" class="btn btn-outline-secondary" id="clear-btn">
                            Clear
                        </button>
                        <% } %>
                        <button type="button" class="btn btn-primary" id="save-btn">
                            <i class="fas fa-plus me-2"></i>Save
                        </button>
                    </div>
                </div>

                <form id="authorForm">
                    <div class="row">
                        <input type="hidden" name="userId" id="userId" value="<%= (authorData != null) ? authorData.getId() : "" %>">

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Title</label>
                            <select name="userTitle" class="form-select" id="title" >
                                <option value="">-- Select Inventory Type --</option>
                                <option value="Mr." <%= (authorData != null && "Mr.".equalsIgnoreCase(authorData.getTitle())) ? "selected" : "" %>>Mr.</option>
                                <option value="Mrs." <%= (authorData != null && "Mrs.".equalsIgnoreCase(authorData.getTitle())) ? "selected" : "" %>>Mrs.</option>
                                <option value="Miss." <%= (authorData != null && "Miss.".equalsIgnoreCase(authorData.getTitle())) ? "selected" : "" %>>Miss.</option>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <input type="text" name="firstName" class="form-control" placeholder="Enter first name" required id="firstName"
                                   value="<%= (authorData != null) ? authorData.getFirstName() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" placeholder="Enter last name" required id="lastName"
                                   value="<%= (authorData != null) ? authorData.getLastName() : "" %>">
                        </div>


                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phoneNo" class="form-control" placeholder="Enter phone no" required id="phoneNo"
                                   value="<%= (authorData != null) ? authorData.getPhoneNo() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter email" required id="email"
                                   value="<%= (authorData != null) ? authorData.getEmail() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-control" placeholder="Enter date of birth" required id="dateOfBirth"
                                   value="<%= (authorData != null) ? authorData.getDateOfBirth() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select" id="gender" required>
                                <option value="">-- Select Inventory Type --</option>
                                <option value="MALE" <%= (authorData != null && authorData.getGender() == Gender.MALE) ? "selected" : "" %>>MALE</option>
                                <option value="FEMALE" <%= (authorData != null && authorData.getGender() == Gender.FEMALE) ? "selected" : "" %>>FEMALE</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../includes/toast-message.jsp" %>

<script>
    $(document).ready(function () {
        const idParam = '<%= (idParam != null) ? idParam : "" %>';

        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update Author');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }

        $("#save-btn").click(function() {
            if (!validateForm()) {
                return;
            }

            const newFormData = {
                userId: $('[name="userId"]').val().trim(),
                userTitle: $('[name="userTitle"]').val(),
                firstName: $('[name="firstName"]').val().trim(),
                lastName: $('[name="lastName"]').val().trim(),
                phoneNo: $('[name="phoneNo"]').val().trim(),
                email: $('[name="email"]').val().trim(),
                dateOfBirth: $('[name="dateOfBirth"]').val(),
                gender: $('[name="gender"]').val(),
            };

            $.ajax({
                url: "<%= request.getContextPath() %>/author",
                type: "POST",
                data: JSON.stringify(newFormData),
                processData: false,
                contentType: "application/json",
                success: function (response) {
                    if (response.code === 200) {
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "<%= request.getContextPath() %>/author";
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
        $("#authorForm")[0].reset();
    });

    function validateForm() {
        const firstName = $('[name="firstName"]').val().trim();
        const lastName = $('[name="lastName"]').val().trim();
        const phoneNo = $('[name="phoneNo"]').val().trim();
        const email = $('[name="email"]').val().trim();
        const gender = $('[name="gender"]').val();
        const dateOfBirth = $('[name="dateOfBirth"]').val();
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