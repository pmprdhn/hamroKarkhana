<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.List, com.hamroKarkhana.model.ProductModel" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>
    <section class="hero-banner">
      <div class="banner-text">
        <h1>Grow together,<br>better than ever.</h1>
        <p>Welcome to Hamro Karkhana, an all in one place for flat screens to lit up your home. Sales every day so you enjoy shopping.</p>
        <a href="product"><button class="shop-now-btn">Shop Now</button></a>
        
      </div>
      <div class="banner-slider">
        <img src="${pageContext.request.contextPath}/resources/images/system/slide1.jpeg" class="slide active" alt="Slide 1">
        <img src="${pageContext.request.contextPath}/resources/images/system/slide2.jpg" class="slide" alt="Slide 2">
        <img src="${pageContext.request.contextPath}/resources/images/system/slide3.jpg" class="slide" alt="Slide 3">
        <img src="${pageContext.request.contextPath}/resources/images/system/slide4.webp" class="slide" alt="Slide 4">
        <img src="${pageContext.request.contextPath}/resources/images/system/slide5.jpg" class="slide" alt="Slide 5">
      </div>
    </section>
    <section class="features-section">
      <div class="feature-item">
        <img src="${pageContext.request.contextPath}/resources/images/system/headset.png" alt="Responsive Icon">
        <h3>Responsive</h3>
        <p>Customer service available 24/7</p>
      </div>
      <div class="feature-item">
        <img src="${pageContext.request.contextPath}/resources/images/system/secure.jpg" alt="Secure Icon">
        <h3>Secure</h3>
        <p>Certified marketplace since 2017</p>
      </div>
      <div class="feature-item">
        <img src="${pageContext.request.contextPath}/resources/images/system/shipping.svg" alt="Shipping Icon">
        <h3>Shipping</h3>
        <p>Free, fast, and reliable worldwide</p>
      </div>
      <div class="feature-item">
        <img src="${pageContext.request.contextPath}/resources/images/system/return.png" alt="Transparent Icon">
        <h3>Transparent</h3>
        <p>Hassle-free return policy</p>
      </div>
    </section>

    <section class="recommended-products">
      <h2>Featured Products</h2>
      <div class="product-list">
      	<%
		    List<com.hamroKarkhana.model.ProductModel> featuredProducts = 
		        (List<com.hamroKarkhana.model.ProductModel>) request.getAttribute("featuredProducts");
		
		    if (featuredProducts != null) {
		        for (com.hamroKarkhana.model.ProductModel product : featuredProducts) {
		%>
		    <a href="oneProduct?modelNo=<%= product.getModelNo() %>" class="product-card"> 
		        <img src="<%= request.getContextPath() %>/resources/images/system/<%= product.getImage() %>" alt="<%= product.getTitle() %>">
		        <h3><%= product.getTitle() %></h3>
		        <p><%= product.getDescription() %></p>
		        <p class="price">₹<%= product.getPrice() %></p>
		        <button>Buy now</button>
		    </a>
		<%
		        }
		    } else {
		%>
		    <p>No featured products available.</p>
		<%
		    }
		%>

    </section>
    
          <!-- Personalized Recommendation Section -->
      <section class="personalized-recommendation">
        <h2>See personalized recommendations</h2>
        <a href="login">
		  <button class="sign-in-btn">Sign in</button>
		</a>
        
        <p>New customer? <a href="register">Start here.</a></p>
      </section>

  </main>

  <jsp:include page="footer.jsp" />
  
  <script>
    let currentSlide = 0;
    const slides = document.querySelectorAll(".slide");
  
    function showNextSlide() {
      slides[currentSlide].classList.remove("active");
      currentSlide = (currentSlide + 1) % slides.length;
      slides[currentSlide].classList.add("active");
    }
  
    setInterval(showNextSlide, 4000); // Change every 4 seconds
  </script>
  
  
  
  
</body>
</html>
