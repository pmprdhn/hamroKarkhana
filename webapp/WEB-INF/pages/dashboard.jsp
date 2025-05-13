<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Dashboard - Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
        <h3>Total Products</h3>
        <p>35</p>
      </div>
      <div class="card">
        <h3>Total Orders</h3>
        <p>102</p>
      </div>
      <div class="card">
        <h3>Today's Orders</h3>
        <p>5</p>
      </div>
      <div class="card">
        <h3>Revenue This Month</h3>
        <p>$2,300</p>
      </div>
    </section>

    <section class="recent-orders">
      <h2>Recent Orders</h2>
      <table>
        <thead>
          <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Total</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>#0012</td>
            <td>John Doe</td>
            <td>$120</td>
            <td>Pending</td>
          </tr>
          <tr>
            <td>#0013</td>
            <td>Jane Smith</td>
            <td>$230</td>
            <td>Shipped</td>
          </tr>
          <tr>
            <td>#0014</td>
            <td>Michael Brown</td>
            <td>$75</td>
            <td>Delivered</td>
          </tr>
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
