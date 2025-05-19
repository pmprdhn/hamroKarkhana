<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hamro Karkhana-Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
</head>
<body>
	 <div class="container">
	    <div class="left-section">
	      <div class="logo-brand">
			  <img src="${pageContext.request.contextPath}/resources/images/system/final.png" alt="Logo" class="logo-img">
			  <h1 class="brand">हाम्रो कारखाना</h1>
		  </div>
	      <h2 class="tagline">Login into <br />your account</h2>
	      <p class="slogan">Grow together, better than ever!</p>
	      <footer>&copy;2025 Hamro Karkhana. All Rights Reserved.</footer>
	    </div>
	
	    <div class="right-section">
	    
		
	    
	      <form class="login-form" action="${pageContext.request.contextPath}/login" method="post">
	      	<% String error = (String) request.getAttribute("error");
		       if (error != null) { %>
		       <p style="color: red;"><%= error %></p>
		    <% } %>
		       <% String success = (String) request.getAttribute("success");
		       if (success != null) { %>
		       <p style="color: green;"><%= success %></p>
		    <% } %>
	        <label for="username">Username</label>
			<input type="text" name="username" placeholder="Enter your username" required />

	
	        <label for="password">Password</label>
	        <input type="password" name="password" placeholder="Enter your password" required />
	
	        <div class="form-footer">
	          <a href="#">Forgot your password?</a>
	        </div>
	
	        <button type="submit">Login</button>
	
	        <p class="register-link">No account? <a href="register">Register Now!</a></p>
	      </form>
	    </div>
	  </div>
	  
</body>
</html>