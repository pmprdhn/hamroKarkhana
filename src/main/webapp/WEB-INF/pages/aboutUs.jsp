<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us-Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutUs.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>
   <div class="hero" style="background-image: url('${pageContext.request.contextPath}/resources/images/system/handshake.jpg');">
  <div class="hero-content">
    <h1>About Us</h1>
    <p>A collaborative platform supporting local industries, innovators, and Nepali craftsmanship with pride and purpose.</p>
  </div>
</div>

  </div>

  <section class="section">
    <div class="text-content">
      <h2>Our Mission</h2>
      <p>
        At Hamro Karkhana, we believe in more than just building products — we believe in building responsibly. Growing a business doesn't have to come at the cost of people or the planet. Our mission is to empower local industries by promoting sustainable manufacturing, ethical practices, and community-driven innovation. We’re here to prove that Nepali craftsmanship can thrive with integrity, purpose, and pride.
      </p>
      <p>
        Through transparency, technology, and teamwork, we aim to foster an ecosystem where entrepreneurs, workers, and consumers grow together — the right way. We want to inspire a generation of creators and problem-solvers who are not just consumers but contributors to Nepal’s economic and cultural development.
      </p>
    </div>
    <div class="image-content">
      <img src="${pageContext.request.contextPath}/resources/images/system/mission.jpeg" alt="Mission Image">
    </div>
  </section>

  <section class="section">
    <div class="image-content">
      <img src="${pageContext.request.contextPath}/resources/images/system/team.webp" alt="Founders Image">
    </div>
    <div class="text-content">
      <h2>Our Story</h2>
      <p>
        Founded with a vision to revolutionize Nepal’s production landscape, Hamro Karkhana was born from a simple idea: “Why import what we can create better at home?”
      </p>
      <p>
        What began as a small initiative to support local craftsmen has now evolved into a growing movement that connects small manufacturers with modern tools, market access, and a voice. We are passionate about showcasing Nepali innovation, improving industry standards, and creating opportunities where they’re needed most.
      </p>
      <p>
        From humble beginnings to bold ambitions — our story is rooted in the belief that real progress starts from within. Every step we take is guided by our commitment to community, culture, and capability.
      </p>
      <p>
        As our network grew, so did our aspirations. We began collaborating with young designers, engineers, and artisans to co-create innovative, quality-first products proudly made in Nepal. 
      </p>
      <p>
        Today, Hamro Karkhana stands as a symbol of self-reliance, creativity, and connection. We're not just building factories — we're building futures, one locally-made product at a time.
      </p>
      
    </div>
  </section>

  </main>

  <jsp:include page="footer.jsp" />
  
  
  
  
  
</body>
</html>
