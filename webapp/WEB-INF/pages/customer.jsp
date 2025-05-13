<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Records</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerManagement.css">
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
        <h1>Customer Records</h1>

        <!-- Customer Table -->
        <table class="customer-table">
            <thead>
                <tr>
                    <th>Profile</th>
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
                <!-- Example customer row -->
                <tr>
                    <td><img src="${pageContext.request.contextPath}/images/profile1.png" alt="Profile" class="profile-pic"></td>
                    <td>John Doe</td>
                    <td>johndoe</td>
                    <td>john@example.com</td>
                    <td>9841234567</td>
                    <td>Kathmandu, Nepal</td>
                    <td>Male</td>
                    <td>
                        <button class="delete-btn">Delete</button>
                        <button class="view-btn">View</button>
                    </td>
                </tr>
                <tr>
                    <td><img src="${pageContext.request.contextPath}/images/profile2.png" alt="Profile" class="profile-pic"></td>
                    <td>Jane Smith</td>
                    <td>janesmith</td>
                    <td>jane@example.com</td>
                    <td>9801122334</td>
                    <td>Lalitpur, Nepal</td>
                    <td>Female</td>
                    <td>
                        <button class="delete-btn">Delete</button>
                        <button class="view-btn">View</button>
                    </td>
                </tr>
                <!-- Add dynamic rows from database later -->
            </tbody>
        </table>
    </div> <!-- End container -->
</div> <!-- End wrapper -->

<jsp:include page="footer.jsp" />

</body>
</html>
