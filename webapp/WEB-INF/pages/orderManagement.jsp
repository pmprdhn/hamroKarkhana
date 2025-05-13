<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderManagement.css">
</head>
<body>

<jsp:include page="header.jsp" />

<div class="wrapper">
    <aside class="sidebar">
	  <h2>Admin Panel</h2>
	  <nav>
	    <ul>
	      <li><a href="dashboard">Dashboard</a></li>
	      <li><a href="inventory">Products</a></li>
	      <li><a href="order">Orders</a></li>
	      <li><a href="customer">Customers</a></li>
	      <li><a href="#">Settings</a></li>
	      <li><a href="#">Logout</a></li>
	    </ul>
	  </nav>
	</aside>


    <!-- Main Content Area -->
    <div class="container">
        <h1>Order Management</h1>

        <!-- Orders Table -->
        <table class="inventory-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>#1001</td>
                    <td>John Doe</td>
                    <td>Samsung QLED 65</td>
                    <td>1</td>
                    <td>$1200</td>
                    <td><span class="status pending">Pending</span></td>
                    <td>
                        <button class="update-btn">Update</button>
                    </td>
                </tr>
                <tr>
                    <td>#1002</td>
                    <td>Jane Smith</td>
                    <td>LG OLED 55</td>
                    <td>2</td>
                    <td>$3000</td>
                    <td><span class="status shipped">Shipped</span></td>
                    <td>
                        <button class="update-btn">Update</button>
                    </td>
                </tr>
                <tr>
                    <td>#1003</td>
                    <td>Bob Johnson</td>
                    <td>Sony Bravia 50</td>
                    <td>1</td>
                    <td>$1000</td>
                    <td><span class="status delivered">Delivered</span></td>
                    <td>
                        <button class="update-btn">Update</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div> <!-- Close container -->
</div> <!-- Close wrapper -->

<jsp:include page="footer.jsp" />

</body>
</html>
