<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map" %>

<%
    Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
%>

<form action="register" method="post">
    <input type="text" name="username" placeholder="Username" />
    <p style="color:red;"><%= (errors != null && errors.get("username") != null) ? errors.get("username") : "" %></p>

    <input type="email" name="email" placeholder="Email" />
    <p style="color:red;"><%= (errors != null && errors.get("email") != null) ? errors.get("email") : "" %></p>

    <input type="password" name="password" placeholder="Password" />
    <p style="color:red;"><%= (errors != null && errors.get("password") != null) ? errors.get("password") : "" %></p>

    <button type="submit">Register</button>
</form>

<p style="color:green;"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></p>
<p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>

