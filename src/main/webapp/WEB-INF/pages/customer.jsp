<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.hamroKarkhana.model.CustomerModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Records</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerManagement.css">
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container">
    <jsp:include page="sidebar.jsp" />

    <main class="main-content">
        <div class="inventory-header">
            <h1>Customer Records</h1>
        </div>

        <!-- Error/Success Messages -->
        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="error-message"><%= error %></div>
        <%
            }
            if (success != null) {
        %>
            <div class="success-message"><%= success %></div>
        <%
            }
        %>

        <table class="inventory-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Address</th>
                    <th>Gender</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<CustomerModel> customers = (List<CustomerModel>) request.getAttribute("customers");
                    if (customers == null || customers.isEmpty()) {
                %>
                    <tr>
                        <td colspan="7" style="text-align: center;">No customers found.</td>
                    </tr>
                <%
                    } else {
                        for (CustomerModel customer : customers) {
                %>
                    <tr>
                        <td><%= customer.getName() %></td>
                        <td><%= customer.getUsername() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhoneNumber() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td><%= customer.getGender() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/customer" method="post" onsubmit="return confirm('Are you sure you want to delete this customer?');">
                                <input type="hidden" name="username" value="<%= customer.getUsername() %>">
                                <button type="submit" class="delete-btn">Delete</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </main>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
