<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, com.hamroKarkhana.model.ProductModel" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hamro Karkhana</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/product.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>

    <section class="product-page">
      <!-- Sidebar Filters -->
      <aside class="sidebar">
        <h3>Television</h3>
        <ul class="filter-category">
          <li>QLED 8K</li>
          <li>QLED 4K Television</li>
          <li>4K UHD Television</li>
          <li>Full HD | HD Television</li>
          <li>Gaming Monitors</li>
          <li>Frame TV</li>
          <li>Neo QLED 4K Television</li>
        </ul>
    
        <h4>Price Range</h4>
        <div class="price-range">
          <input type="number" placeholder="Min">
          <input type="number" placeholder="Max">
        </div>
        <button id="filter" class="filter-class">Apply Filter</button>
    
      </aside>
    
      <!-- Product Section -->
      <div class="products">
       <form class="search-box" action="<%= request.getContextPath() %>/product" method="get">
		  <input 
		    type="text" 
		    name="query" 
		    placeholder="Search products..." 
		    value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
		  <button type="submit">Search</button>
		</form>

        <div class="sort-bar">
          <label for="sort">Sort By</label>
          <select id="sort">
            <option value="default">Default</option>
            <option value="price-low-high">Price: Low to High</option>
            <option value="price-high-low">Price: High to Low</option>
          </select>
        </div>

        <div class="product-grid-wrapper">
          <div class="product-grid" id="productGrid">

          <%
            // Get the products attribute passed from servlet
            java.util.List<com.hamroKarkhana.model.ProductModel> products = 
                (java.util.List<com.hamroKarkhana.model.ProductModel>) request.getAttribute("products");

            if (products != null && !products.isEmpty()) {
                for (com.hamroKarkhana.model.ProductModel product : products) {
          %>
                  <a href="oneProduct?modelNo=<%= product.getModelNo() %>" class="product-card">
					  <img src="<%= request.getContextPath() %>/resources/images/system/<%= product.getImage() %>" alt="<%= product.getTitle() %>">
					  <h5><%= product.getTitle() %></h5>
					  <p>Rs. <%= product.getPrice() %></p>
				</a>          <%
                }
            } else {
          %>
              <p>No products available.</p>
          <%
            }
          %>

          </div>
        
          <button id="loadMoreBtn" class="load-more-btn">Show More</button>
        </div>
    
      </div>
    </section>

  </main>

  <jsp:include page="footer.jsp" />
  
  <script>
    const loadMoreBtn = document.getElementById('loadMoreBtn');
    const productCards = document.querySelectorAll('.product-card');
    let itemsToShow = 8;
    let showingAll = false;

    // Function to show certain number of items
    function showItems(count) {
      productCards.forEach((card, index) => {
        if (index < count) {
          card.style.display = 'block';
        } else {
          card.style.display = 'none';
        }
      });
    }

    // Initial setup: show first 8 products
    showItems(itemsToShow);

    loadMoreBtn.addEventListener('click', () => {
      if (!showingAll) {
        // Show all products
        itemsToShow = productCards.length;
        showItems(itemsToShow);
        loadMoreBtn.textContent = 'Show Less';
        showingAll = true;
      } else {
        // Show only first 8 products
        itemsToShow = 8;
        showItems(itemsToShow);
        loadMoreBtn.textContent = 'Load More';
        showingAll = false;
      }
    });
  </script>
  
</body>
</html>
