<% String pageTitle = "Dashboard"; %>
<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>

    <div class="view active" id="dashboard-view">
        <%@ include file="dashboard.jsp" %>
    </div>

    <div class="view" id="customers-view">
        <%@ include file="user-list.jsp" %>
    </div>

    <div class="view" id="customer-form-view">
        <%@ include file="user-form.jsp" %>
    </div>

</div>

<%@ include file="../includes/footer.jsp" %>



