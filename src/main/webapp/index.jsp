<% String pageTitle = "Login"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><%= pageTitle != null ? pageTitle : "My App" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/src/assets/js/common.js"></script>
    <link rel="stylesheet" href="./src/assets/css/style.css">
</head>
<body>

<div class="login-page">
    <div class="login-card ">
        <h2 class="text-center login-title">Login</h2>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
            </div>
            <div class="d-grid">
                <button id="login-btn" type="button" class="btn btn-primary">Login</button>
            </div>
        </form>
        <div class="mt-3 text-center">
            <a href="#">Forgot password?</a>
        </div>
    </div>
</div>

<!-- Spinner Overlay -->
<div id="spinner-overlay" style="display: none;">
    <div class="spinner-container d-flex justify-content-center align-items-center"
         style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
         background-color: rgba(0,0,0,0.5); z-index: 9999;">
        <div class="spinner-border text-light" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
</div>


<%@ include file="./src/includes/toast-message.jsp" %>

<script>
    $(document).ready(function () {
        $("#login-btn").click(function(event) {
            console.log("Response11:");
            event.preventDefault()
            const login = {
                email: $('[name="email"]').val().trim(),
                password: $('[name="password"]').val().trim(),
            };

            if (!login.email || !login.password) {
                showToast("Please fill in all fields.", "danger");
                return;
            }

            $("#spinner-overlay").show();

            $.ajax({
                url: "<%= request.getContextPath() %>/login",
                type: "POST",
                data: JSON.stringify(login),
                processData: false,
                contentType: "application/json",
                success: function (response) {
                    if (response.code === 200) {
                        localStorage.setItem("user", JSON.stringify(response.data));
                        localStorage.setItem("token", response.data.token);
                        $("#spinner-overlay").hide();
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "<%= request.getContextPath() %>/src/pages/dashboard.jsp";
                        }, 2000);
                    } else {
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    console.log("Response333:", xhr);
                    showToast("Request failed: ","error");
                }
            });
        });
    });
</script>

<%@ include file="src/includes/footer.jsp" %>
