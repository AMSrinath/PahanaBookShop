

<%
    String sessionUserImage = (sessionUser != null && sessionUser.getUserImagePath() != null && !sessionUser.getUserImagePath().isEmpty())
            ? request.getContextPath() + "/" + sessionUser.getUserImagePath()
            : request.getContextPath() + "/src/assets/images/user-default.png";

    assert sessionUser != null;%>

<header class="dashboard-header">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <button class="btn mobile-toggle me-3">
                    <i class="fas fa-bars"></i>
                </button>
                <div>
                    <h1 class="mb-0"> <%= pageTitle %></h1>
                </div>
            </div>

            <div class="d-flex align-items-center">
                <!-- Notifications -->
                <div class="me-3 position-relative">
                    <i class="fas fa-bell fa-lg"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">3</span>
                </div>

                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                       id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="<%= sessionUserImage %>" class="rounded-circle me-2"
                             width="40" height="40" alt="User">
                        <span class="text-dark fw-semibold"><%= sessionUser.getFirstName() %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user?id=<%= sessionUser.getId() %>&action=my_account">
                                <i class="fas fa-user me-2"></i>My Account
                            </a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                <i class="fas fa-key me-2"></i>Change Password
                            </a>
                        </li>

                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                 <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>


<!-- Change Password Modal -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="changePasswordForm">
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="newPassword" required>
                        <div class="form-text">Password must be at least 8 characters long.</div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirmPassword" required>
                        <div class="invalid-feedback" id="confirmPasswordFeedback">
                            Passwords do not match.
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="updatePasswordBtn">Update Password</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="../includes/toast-message.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const changePasswordForm = document.getElementById('changePasswordForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const updatePasswordBtn = document.getElementById('updatePasswordBtn');

        confirmPassword.addEventListener('input', function() {
            if (newPassword.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity("Passwords do not match");
                confirmPassword.classList.add('is-invalid');
            } else {
                confirmPassword.setCustomValidity("");
                confirmPassword.classList.remove('is-invalid');
            }
        });


        updatePasswordBtn.addEventListener('click', function() {
            if (newPassword.value !== confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                return;
            }

            const passwordData = {
                newPassword: newPassword.value
            };
            $("#spinner-overlay").show();
            $.ajax({
                url: "<%= request.getContextPath() %>/change-password",
                type: "POST",
                data: JSON.stringify(passwordData),
                processData: false,
                contentType: "application/json",
                success: function (response) {
                    if (response.code === 200) {
                        $("#spinner-overlay").hide();
                        showToast(response.message, "success");
                        setTimeout(() => {
                            const modal = bootstrap.Modal.getInstance(document.getElementById('changePasswordModal'));
                            modal.hide();
                            changePasswordForm.reset();
                        }, 2000);
                    } else {
                        $("#spinner-overlay").hide();
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    $("#spinner-overlay").hide();
                    showToast("Request failed: ", xhr);
                }
            });
        });

        // Reset form when modal is closed
        document.getElementById('changePasswordModal').addEventListener('hidden.bs.modal', function () {
            changePasswordForm.reset();
            confirmPassword.classList.remove('is-invalid');
        });
    });
</script>

<style>
    .dashboard-header {
        padding: 1rem 0;
        background-color: #fff;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 1.5rem;
    }

    .mobile-toggle {
        border: none;
        font-size: 1.2rem;
        color: #6c757d;
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        border-radius: 0.5rem;
    }

    .dropdown-item {
        padding: 0.5rem 1rem;
    }

    .dropdown-item:hover {
        background-color: #f8f9fa;
    }

    .modal-content {
        border: none;
        border-radius: 0.7rem;
        box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.2);
    }

    .modal-header {
        border-bottom: 1px solid #e9ecef;
        padding: 1.2rem 1.5rem;
    }

    .modal-body {
        padding: 1.5rem;
    }

    .modal-footer {
        border-top: 1px solid #e9ecef;
        padding: 1rem 1.5rem;
    }

    .btn-primary {
        background-color: #4e73df;
        border-color: #4e73df;
    }

    .btn-primary:hover {
        background-color: #2e59d9;
        border-color: #2e59d9;
    }
</style>