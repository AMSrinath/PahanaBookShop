<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inventory Types</title>
</head>
<body>
<h1>Inventory Types</h1>

<ul>
    <%
        List<String> inventoryTypes = (List<String>) request.getAttribute("inventoryTypes");
        for (String type : inventoryTypes) {
    %>
    <li><%= type %></li>
    <% } %>
</ul>

<h2>Add New Inventory Type</h2>
<form action="inventory-type" method="post">
    <input type="text" name="type" placeholder="Enter new type" required>
    <button type="submit">Add</button>
</form>
</body>
</html>
