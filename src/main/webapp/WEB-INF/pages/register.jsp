<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hamro Karkhana- Registration</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/registration.css" />
</head>
<body>
 <div class="left">
    <div>
      <img class="logo" src="${pageContext.request.contextPath}/resources/images/system/final.png" alt="Hamro Karkhana Logo">
      <h1>हाम्रो कारखाना</h1>
      <p>Grow together, better than ever!</p>
      <div class="welcome-message">
		  <h2>Welcome to Hamro Karkhana!</h2>
		  <p>Join our community to never miss an update.</p>
	  </div>	
	  <div class="social-media">
		  <a href="https://facebook.com" target="_blank" aria-label="Facebook">
		    <img src="${pageContext.request.contextPath}/resources/images/system/facebook.svg" alt="Facebook Icon">
		  </a>
		  <a href="https://linkedin.com" target="_blank" aria-label="LinkedIn">
		    <img src="${pageContext.request.contextPath}/resources/images/system/linkedin.svg" alt="LinkedIn Icon">
		  </a>
		  <a href="https://instagram.com" target="_blank" aria-label="Instagram">
		    <img src="${pageContext.request.contextPath}/resources/images/system/instagram.svg" alt="Instagram Icon">
		  </a>
	 </div>        
    </div>
    <div class="copyright">
      &copy; 2025 Hamro Karkhana. All rights reserved.
    </div>
  </div>

  <div class="right">
    <div class="form-container">
      <h2>Registration Form</h2>
       <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
       <p style="color: red;"><%= error %></p>
    <% } %>
       <% String success = (String) request.getAttribute("success");
       if (success != null) { %>
       <p style="color: green;"><%= success %></p>
    <% } %>
      <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
        <div class="form-grid">
          <div class="form-group">
            <label for="name">Name</label>
            <input type="text" name="name" required />
          </div>

          <div class="form-group">
            <label for="username">Username</label>
            <input type="text"  name="username" required />
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input type="email"  name="email" required />
          </div>

          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" name="phoneNumber" required />
          </div>

          <div class="form-group">
            <label for="address">Address</label>
            <input id="address" name="address"  required>
          </div>

          <div class="form-group">
            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
              <option value="">Select gender</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
            </select>
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input type="password"  name="password" required />
          </div>

          <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" name="retypePassword" required />
          </div>

          <div class="form-group full-width">
            <label for="profilePic">Profile Picture</label>
            <input type="file" name="image" accept="image/*" required />

          </div>
          
          <div class="form-group full-width terms">
			  <label class="checkbox-container">
			    <input type="checkbox" name="terms" required />
			    <span class="checkmark"></span>
			    By registering, I accept the <a href="#" class="terms">Terms of Service</a> and acknowledge the <a href="#" class="terms">Privacy policy</a> of this company.
			  </label>
		  </div>
     	<br>
          <div class="form-actions">
            <button type="submit">Sign Up</button>
            
   
          </div>
        </div>
      </form>
    </div>
  </div>
  
  <script>
    document.querySelector('form').addEventListener('submit', function(event) {
        var password = document.querySelector('input[name="password"]').value;
        var confirmPassword = document.querySelector('input[name="confirm_password"]').value;

        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            event.preventDefault();
        }
    });
    </script>
    <!--button to redirect it to login  -->
<

  
</body>
</html>