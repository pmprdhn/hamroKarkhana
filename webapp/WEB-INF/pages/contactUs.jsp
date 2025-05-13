
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us-Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contactUs.css">
</head>
<body>
  <jsp:include page="header.jsp" />

   <main>
        <section class="contact-section" style="background-image: url('${pageContext.request.contextPath}/resources/images/system/shop.jpg');">
            <div>
                <p>FOR HAMRO KARKHANA INQUIRIES</p>
                <h1>CONTACT US</h1>
            </div>
        </section>
        <section class="contact-info">
            <div class="contact-details">
                <div>
                    <h3>HOURS OF OPERATION</h3>
                    <p>9:00 to 17:00, Mon-Fri (Excluding Holidays)</p>
                </div>
                <div>
                    <h3>PHONE</h3>
                    <p>+977 1234567890</p>
                </div>
                <div>
                    <h3 style="width: 300px;">GENERAL INQUIRIES</h3>
                    <p><a href="mailto:info@hamrokarkhana.com">info@hamrokarkhana.com</a></p>
                </div>
            </div>
            <p>Our customer service team is waiting to assist you</p>
            <p>Please allow up to 2-business days response time in order for us to fully address your inquiry.</p>
            <p>You can also check your order status through our website.</p>
        </section>
        <hr>
        <section class="contact-form-section">
            <h3>CONTACT FORM</h3>
            <p>PLEASE FILL OUT ALL FIELDS</p>
            <div class="contact-form">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required>
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required>
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone">
                <label for="message">Message</label>
                <textarea id="message" name="message" required></textarea>
                <button type="button" onclick="validateForm()">Send</button>
            </div>
        </section>
    </main>

  <jsp:include page="footer.jsp" />
  
  
  
  
  
</body>
</html>
