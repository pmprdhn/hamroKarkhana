<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.hamroKarkhana.model.OrderModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderManagement.css">
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <jsp:include page="sidebar.jsp" />

    <main class="main-content">
        <div class="inventory-header">
            <h1>Order Management</h1>
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
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Product</th>
                    <th>Total Amount</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");
                    if (orders == null || orders.isEmpty()) {
                %>
                    <tr>
                        <td colspan="7" style="text-align: center;">No orders found.</td>
                    </tr>
                <%
                    } else {
                        for (OrderModel order : orders) {
                %>
                    <tr>
                        <td>#<%= order.getOrderID() %></td>
                        <td><%= order.getCustomerName() %></td>
                        <td><%= order.getProductTitle() %></td>
                        <td>Rs.<%= order.getTotalAmount() %></td>
                        <td><%= order.getAddress() %></td>
                        <td>
                            <span class="status <%= order.getOrderStatus().toLowerCase() %>">
                                <%= order.getOrderStatus() %>
                            </span>
                        </td>
                        <td>
                            <button 
                                class="update-btn" 
                                onclick="openUpdateModal('<%= order.getOrderID() %>', '<%= order.getOrderStatus() %>')">
                                Update
                            </button>
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

<!-- Update Modal -->
<div id="updateModal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close" onclick="closeModal('updateModal')">×</span>
        <h2>Update Order Status</h2>
        <form action="${pageContext.request.contextPath}/updateOrder" method="post">
            <input type="hidden" name="orderID" id="updateOrderID">
            <label for="orderStatus">Order Status:</label>
            <select name="orderStatus" id="orderStatus" required>
                <option value="Pending">Pending</option>
                <option value="Delivered">Delivered</option>
           
            </select>
            <div class="modal-buttons">
                <button type="submit" class="update-btn">Update</button>
                <button type="button" class="cancel-btn" onclick="closeModal('updateModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    function openUpdateModal(orderID, orderStatus) {
        document.getElementById("updateOrderID").value = orderID;
        document.getElementById("orderStatus").value = orderStatus;
        openModal("updateModal");
    }

    // Close modal if clicked outside
    window.onclick = function(event) {
        const modal = document.getElementById('updateModal');
        if (event.target === modal) {
            closeModal('updateModal');
        }
    };
</script>

</body>
</html>
