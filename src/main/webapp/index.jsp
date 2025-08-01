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
                <button type="submit" class="btn btn-primary"><a href="src/pages/main.jsp"></a>Login</button>
            </div>
        </form>
        <div class="mt-3 text-center">
            <a href="#">Forgot password?</a>
        </div>
    </div>
</div>

<%@ include file="src/includes/footer.jsp" %>
