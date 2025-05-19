<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Retrieve the product object passed from the servlet
    com.hamroKarkhana.model.ProductModel product = (com.hamroKarkhana.model.ProductModel) request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><%= product != null ? product.getTitle() : "Product Not Found" %></title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/one-product.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>
  <% String message = (String) request.getAttribute("orderPlacedMessage"); %>
<% if (message != null) { %>
  <div class="order-message"><%= message %></div>
<% } %>
  
    <div class="container">
      <% if (product != null) { %>
      <div class="left-section">
        <img src="<%= request.getContextPath() + "/resources/images/system/" + product.getImage() %>" 
             alt="<%= product.getTitle() %>" class="product-image">
      </div>

      <div class="right-section">
        <h1><%= product.getTitle() %></h1>

        <%-- You can add rating dynamically if you have it in product model, otherwise keep static --%>
        <div class="rating">★★★★☆ <span>4.5 (740)</span></div>

        <p class="description">
          <%= product.getDescription() != null ? product.getDescription() : "No description available." %>
        </p>

        <div class="price">Rs. <%= product.getPrice() %></div>

		<form action="<%= request.getContextPath() %>/oneProduct" method="post">
		  <input type="hidden" name="modelNo" value="<%= product.getModelNo() %>">
		  <button type="submit" class="add-to-cart">BUY NOW</button>
		</form>



        <div class="benefits">
          <h2>Benefits of buying from Hamro Karkhana:</h2>
          <p>✔ 30-day exchange policy</p>
          <p>✔ Price match promise</p>
          <p>✔ Complimentary shipping</p>
          <p>✔ Hassle-free return policy</p>
        </div>
      </div>
      <% } else { %>
        <h2>Product not found.</h2>
      <% } %>
    </div>
    <div style="height: 1px; background-color: grey; width: 100%;"></div>
  </main>

  <jsp:include page="footer.jsp" />
</body>
</html>
