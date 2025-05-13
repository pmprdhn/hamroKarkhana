<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      	<a href="oneProduct" class="product-card"> 
      	
          <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="4k Samsung">
          <h3>UA85DU8000RSHE Samsung Smart TV</h3>
          <p>Size: 85" inch</p>
          <p>Resolution: 4k UHD</p>
          <p><span class="old-price">₹393990.00</span> <span class="discount">Save ₹41990.00</span></p>
          <p class="price">₹35200.00</p>
          <button>Buy now</button>
      
        </a>
       <a href="oneProduct" class="product-card"> 
      	
          <img src="${pageContext.request.contextPath}/resources/images/system/TCL 4k.webp" alt="TCL 4k">
          <h3>C655KLST TCL Premium Smart TV</h3>
          <p>Size: 65" inch</p>
          <p>Resolution: 4K UHD </p>
          <p><span class="old-price">₹309990.00</span> <span class="discount">Save ₹40990.00</span></p>
          <p class="price">₹269000.00</p>
          <button>Buy now</button>
        
        </a>
        <a href="oneProduct" class="product-card"> 
      	
          <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="LG 8k">
          <h3>LG evo AI Smart TV 2025 with Supplied Wall Mount</h3>
          <p>Size: 75" inch</p>
          <p>Resolution: 8k OLED</p>
          <p><span class="old-price">₹350990.00</span> <span class="discount">Save ₹31990.00</span></p>
          <p class="price">₹319000.00</p>
          <button>Buy now</button>
        
        </a>
        <a href="oneProduct" class="product-card"> 
      	
          <img src="${pageContext.request.contextPath}/resources/images/system/Sony.jpg" alt="Washing Machine">
          <h3>Sony Bravia Smart TV KD-75X82L</h3>
          <p>Size: 75 " inch</p>
          <p>Resolution: 4k Ultra HD</p>
          <p><span class="old-price">₹295500.00</span> <span class="discount">Save ₹50000.00</span></p>
          <p class="price">₹245500.00</p>
          <button>Buy now</button>
        
      
        </a>
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
