<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- header.html -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- header.html -->
<header>
    <a href="home" class="logo-container">
        <img src="${pageContext.request.contextPath}/resources/images/system/final.png" alt="Hamro Karkhana Logo">
        <h1>Hamro Karkhana</h1>
    </a>
    <nav class="navbar">
        <a href="home">Home</a>
        <a href="aboutUs">About Us</a>
        <a href="contactUs">Contact Us</a>
        <a href="product">Products</a>
    </nav>

    <div class="auth-buttons">
        <%-- Check if user is logged in --%>
        <% if (session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")) { %>
            <!-- User Profile with dropdown -->
            <div class="admin-profile">
                <div class="admin-info-click" id="profileButton">
                    <img src="${pageContext.request.contextPath}/resources/images/system/${empty sessionScope.profilePicture ? 'default.png' : sessionScope.profilePicture}?t=${Math.random()}" alt="User Profile" class="admin-img">


                    <div class="admin-info">
                        <p class="admin-name">${sessionScope.name}</p>
                        <p class="admin-role">${sessionScope.username}</p>
                    </div>
                </div>

                <!-- Dropdown Menu -->
                <div class="dropdown-menu" id="dropdownMenu">
                    <a href="editProfile">Edit User Profile</a>
                    <a href="logout">Logout</a>
                </div>
            </div>
        <% } else { %>
            <!-- Login and Signup Buttons -->
            <a href="login">
                <button class="login-btn">Login</button>
            </a>
            <a href="register">
                <button class="signup-btn">Signup</button>
            </a>
        <% } %>
    </div>
</header>

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



<!-- Link the CSS file -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
