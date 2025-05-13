<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
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
        <div class="search-box">
          <input type="text" placeholder="Search products...">
        </div>
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
            <a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/samsung8k.png" alt="TV 1">
			  <h5>Samsung 85" Crystal UHD</h5>
			  <p><del>Rs. 3,93,990</del> Rs. 3,52,000</p>
			</a>
			
			<a href="oneProduct" class="product-card">
			  <img src="${pageContext.request.contextPath}/resources/images/system/LG 4k.jpeg" alt="TV 2">
			  <h5>LG 75" Crystal UHD</h5>
			  <p><del>Rs. 2,86,990</del> Rs. 2,31,000</p>
			</a>
  
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
