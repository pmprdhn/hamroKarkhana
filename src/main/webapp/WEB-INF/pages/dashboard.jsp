<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Map" import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Dashboard - Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
  <style>
.low-stock {
  margin-top: 2rem;
}

.low-stock h2 {
  font-size: 24px;
  font-weight: 600;
  margin-bottom: 1rem;
  color: #222;
}

/* Table container */
.low-stock table {
  width: 100%;
  border-collapse: collapse;
  background-color: #ffffff;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

/* Table headers */
.low-stock thead {
  background-color: #f4f6f8;
}

.low-stock th {
  padding: 14px 18px;
  text-align: left;
  font-weight: 600;
  color: #333;
  border-bottom: 1px solid #e0e0e0;
}

/* Table body rows */
.low-stock td {
  padding: 14px 18px;
  border-bottom: 1px solid #eee;
  color: #555;
  font-size: 16px;
}

/* Hover effect */
.low-stock tbody tr:hover {
  background-color: #f9f9f9;
  transition: background-color 0.2s ease;
}

/* Optional: message row when no low stock items */
.low-stock td[colspan] {
  text-align: center;
  font-style: italic;
  color: #888;
}  
  </style>
</head>
<body>
  <jsp:include page="header.jsp" />
  
  

<div class="admin-container">

  <!-- Sidebar -->
  <jsp:include page="sidebar.jsp" />

  <!-- Main Content -->
  <main class="main-content">
    <header class="dashboard-header">
      <h1>Dashboard</h1>
      <p>Welcome, Admin!</p>
    </header>

    <section class="dashboard-cards">
      <div class="card">
        <h3>Total Users</h3>
        <p><%= request.getAttribute("totalUsers") %></p>
      </div>
      <div class="card">
        <h3>Total Products in Stock</h3>
        <p><%= request.getAttribute("totalProducts") %></p>
      </div>
      <div class="card">
        <h3>Total Orders Placed</h3>
        <p><%= request.getAttribute("totalOrders") %></p>
      </div>
      <div class="card">
        <h3>Total Revenue</h3>
        <p> Rs. <%= request.getAttribute("totalRevenue") %></p>
      </div>
    </section>

	<section class="low-stock">
  <h2>Low Stock</h2>
  <table>
    <thead>
      <tr>
        <th>Product Title</th>
        <th>Stock</th>
      </tr>
    </thead>
    <tbody>
      <%
        List<Map<String, Object>> lowStockList = (List<Map<String, Object>>) request.getAttribute("lowStockList");
        if (lowStockList != null && !lowStockList.isEmpty()) {
          for (Map<String, Object> item : lowStockList) {
      %>
        <tr>
          <td><%= item.get("title") %></td>
          <td><%= item.get("stock") %></td>
        </tr>
      <%
          }
        } else {
      %>
        <tr>
          <td colspan="2">All products are sufficiently stocked.</td>
        </tr>
      <%
        }
      %>
    </tbody>
  </table>
</section>
  </main>
</div>
<footer>
  <jsp:include page="footer.jsp" />
</footer>


<script>
  const profileButton = document.getElementById('profileButton');
  const dropdownMenu = document.getElementById('dropdownMenu');

  profileButton.addEventListener('click', () => {
    dropdownMenu.style.display = dropdownMenu.style.display === 'flex' ? 'none' : 'flex';
  });

  // Optional: Close dropdown if click outside
  document.addEventListener('click', (event) => {
    if (!profileButton.contains(event.target)) {
      dropdownMenu.style.display = 'none';
    }
  });
</script>

</body>
</html>
