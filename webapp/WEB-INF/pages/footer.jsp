<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
<footer>
    <!-- Map on top -->
    <div class="footer-map-top">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d26978.176420381995!2d85.33065819848069!3d27.71167633646749!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb1908434cb3c5%3A0x1fdf1a6d41d2512d!2sIslington%20College!5e0!3m2!1sen!2snp!4v1745427941954!5m2!1sen!2snp" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade" class="map"></iframe>
    </div>
  
    <!-- Footer main content -->
    <div class="footer-container">
      <div class="footer-left">
        <h3>Hamro Karkhana</h3>
        <p>© 2025 Hamro Karkhana. All rights reserved.</p>
      </div>
      <div class="footer-middle">
        <h4>Quick Links</h4>
        <ul>
          <li><a href="home">Home</a></li>
          <li><a href="#">About Us</a></li>
          <li><a href="product">Products</a></li>
          <li><a href="#">Contact Us</a></li>
        </ul>
      </div>
      <div class="footer-right">
        <h4>Follow Us</h4>
        <div class="social-media">
          <a href="https://www.facebook.com/">Facebook</a>
          <a href="https://www.instagram.com">Instagram</a>
          <a href="https://www.x.com">Twitter</a>
        </div>
        <h4>Legal</h4>
        <ul>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms & Conditions</a></li>
          <li><a href="#">Cookie Policy</a></li>
        </ul>
      </div>
    </div>
    <div class="back-to-top" onclick="scrollToTop()">
      ↑ Back to Top
    </div>

  </footer>
  <script>
  //Back to top JS

  const container = document.querySelector('.products-container');
    const leftBtn = document.querySelector('.slide-btn.left');
    const rightBtn = document.querySelector('.slide-btn.right');

    leftBtn.addEventListener('click', () => {
      container.scrollBy({ left: -300, behavior: 'smooth' });
    });

    rightBtn.addEventListener('click', () => {
      container.scrollBy({ left: 300, behavior: 'smooth' });
    });

    function scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    }

    //Scroll footer

      window.addEventListener('scroll', function() {
        document.getElementById('footer').style.display = 'block';
      });


</script>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">