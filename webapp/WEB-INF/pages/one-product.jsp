<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Your Product</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/one-product.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>
<div class="container">
  <div class="left-section">
    <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="Bose Headphones" class="product-image">
  </div>

  <div class="right-section">
    <h1>Samsung 85" Crystal UHD</h1>
    <div class="rating">★★★★☆ <span>4.5 (740)</span></div>
    <p class="description">
      Experience stunning clarity and vibrant colors with Samsung's 85-Inch Crystal LED TV. Powered by a Crystal Processor 4K, it delivers lifelike picture quality and smooth motion. With a sleek, slim design and smart features like built-in streaming apps and voice control, it transforms your living room into a cinematic paradise.
    </p>

    <div class="price">Rs. 352,000</div>
    <button class="add-to-cart">ADD TO CART</button>

    <div class="benefits">
      <h2>Benefits of buying from Hamro Karkhana:</h2>
      <p>✔ 30-day exchange policy</p>
      <p>✔ Price match promise</p>
      <p>✔ Complimentary shipping</p>
      <p>✔ Hassle-free return policy</p>
    </div>
  </div>
</div>
<div style="height: 1px; background-color: grey; width: 100%;"></div>

</main>
<jsp:include page="footer.jsp" />

</body>
</html>
