<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Television Inventory Stock</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/inventoryManagement.css">
     <script src="https://cdn.tailwindcss.com"></script>
</head>
 

<body>
<jsp:include page="header.jsp" />

<div class="wrapper">
    <!-- Sidebar -->
    <aside class="sidebar">
        <h2>Admin Panel</h2>
        <nav>
            <ul>
                <li><a href="dashboard"><svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" /></svg> Dashboard</a></li>
                <li><a href="inventory"><svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd" /></svg> Products</a></li>
                <li><a href="order"><svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 2a4 4 0 00-4 4v1H5a1 1 0 00-.994.89l-1 9A1 1 0 004 18h12a1 1 0 00.994-1.11l-1-9A1 1 0 0015 7h-1V6a4 4 0 00-4-4zm2 5V6a2 2 0 10-4 0v1h4zm-6 3a1 1 0 112 0 1 1 0 01-2 0zm7-1a1 1 0 100 2 1 1 0 000-2z" clip-rule="evenodd" /></svg> Orders</a></li>
                <li><a href="customer"><svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v1h8v-1zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-1a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v1h-3zM4.75 12.094A5.973 5.973 0 004 15v1H1v-1a3 3 0 013.75-2.906z" /></svg> Customers</a></li>
                <li><a href="#"><svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd" /></svg> Settings</a></li>
                <li><a href="#"><svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm10.293 9.293a1 1 0 001.414 1.414l3-3a1 1 0 000-1.414l-3-3a1 1 0 10-1.414 1.414L14.586 9H7a1 1 0 100 2h7.586l-1.293 1.293z" clip-rule="evenodd" /></svg> Logout</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content -->
    <div class="container">
        <div class="header">
            <h2>Television Inventory</h2>
            <button type="button" onclick="openModal('addProductModal')">Add Product</button>
        </div>

        <!-- Search and Filter -->
        <div class="search-filter-container">
            <div class="search-box">
                <div class="search-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                    </svg>
                </div>
                <input type="text" placeholder="Search products...">
            </div>
            <div class="filter-dropdown">
                <select>
                    <option value="">All Categories</option>
                    <option value="led">LED TVs</option>
                    <option value="oled">OLED TVs</option>
                    <option value="qled">QLED TVs</option>
                    <option value="smart">Smart TVs</option>
                </select>
            </div>
        </div>

        <!-- Error/Success Messages -->
        <% if (request.getAttribute("error") != null) { %>
            <div style="color: red; margin-bottom: 20px;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div style="color: green; margin-bottom: 20px;">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Model No</th>
                        <th>Brand</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="productTableBody">
                    <%
                        java.util.List<com.hamroKarkhana.model.ProductModel> products = 
                            (java.util.List<com.hamroKarkhana.model.ProductModel>) request.getAttribute("products");
                        if (products == null || products.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="9" style="text-align: center;">No products in stock.</td>
                        </tr>
                    <%
                        } else {
                            for (com.hamroKarkhana.model.ProductModel product : products) {
                                String statusClass = product.getStock() == 0 ? "status-out-of-stock" : 
                                                    product.getStock() <= 3 ? "status-low-stock" : "status-in-stock";
                                String statusText = product.getStock() == 0 ? "Out of Stock" : 
                                                    product.getStock() <= 3 ? "Low Stock" : "In Stock";
                    %>
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/resources/images/system/<%= product.getImage() %>" 
                                     alt="<%= product.getTitle() %>" 
                                     onerror="this.src='https://via.placeholder.com/50'" 
                                     style="width: 50px; height: auto; border-radius: 4px; object-fit: cover;">
                            </td>
                            <td><%= product.getModelNo() %></td>
                            <td><%= product.getBrand() %></td>
                            <td><%= product.getTitle() %></td>
                            <td><%= product.getDescription() %></td>
                            <td>Rs.<%= product.getPrice() %></td>
                            <td><%= product.getStock() %></td>
                            <td>
                                <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                            </td>
                            <td>
                                <button class="btn btn-update" onclick="openUpdateModal('<%= product.getModelNo() %>')" title="Update">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                                        <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
                                    </svg>
                                </button>
                                <button class="btn btn-delete" onclick="openDeleteModal('<%= product.getModelNo() %>')" title="Delete">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                                    </svg>
                                </button>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Product Modal -->
<div class="modal" id="addProductModal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('addProductModal')">&times;</span>
    <h2>Add Product</h2>
    <form>
      <!-- Add Product Form Fields -->
      <input type="text" placeholder="Product Name" required><br>
      <button type="submit">Save</button>
    </form>
  </div>
</div>

<!-- Update Product Modal -->
<div class="modal" id="updateProductModal">
    <div class="modal-content">
        <h3>Update Television</h3>
        <form id="updateProductForm">
            <input type="hidden" name="modelNo" id="updateModelNoHidden">
            <label for="updateImage">Television Image</label>
            <input type="file" id="updateImage" name="image" accept="image/*">
            <div class="profile-pic-label">
                <img src="https://via.placeholder.com/150x100" id="updateImagePreview" alt="Preview" class="preview-image">
                <div class="overlay-text">Change Product Image</div>
            </div>
            <input type="hidden" id="updateImageHidden" name="imageHidden">

            <label for="updateModelNo">Model Number</label>
            <input type="text" id="updateModelNo" name="modelNo" readonly>

            <label for="updateCompany">Brand</label>
            <select id="updateCompany" name="company">
                <option value="">Select Brand</option>
                <option value="Samsung">Samsung</option>
                <option value="LG">LG</option>
                <option value="Sony">Sony</option>
                <option value="TCL">TCL</option>
                <option value="Hisense">Hisense</option>
                <option value="Vizio">Vizio</option>
            </select>

            <label for="updateTitle">Product Title</label>
            <input type="text" id="updateTitle" name="title">

            <label for="updateDescription">Description</label>
            <textarea id="updateDescription" name="description"></textarea>

            <label for="updatePrice">Price (Rs.)</label>
            <input type="text" id="updatePrice" name="price">

            <label for="updateStock">Stock Quantity</label>
            <input type="number" id="updateStock" name="stock">

            <div class="modal-buttons">
                <button type="button" class="btn btn-cancel" onclick="closeModal('updateProductModal')">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Product</button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="confirm-modal" id="deleteConfirmModal">
    <div class="confirm-modal-content">
        <p>Are you sure you want to delete this product?</p>
        <div class="confirm-modal-buttons">
            <button class="btn btn-cancel" onclick="closeModal('deleteConfirmModal')">Cancel</button>
            <button class="btn btn-delete" onclick="deleteProduct()">Delete</button>
        </div>
    </div>
</div>

<script>
    let currentModelNo = null;

    // Open Add Product Modal
    // Open Add Product Modal (Corrected single listener)
	document.getElementById('addProductBtn').addEventListener('click', () => {
    document.getElementById('addProductModal').style.display = 'flex';
    const addPreview = document.getElementById('addImagePreview');
    addPreview.src = 'https://via.placeholder.com/150x100';
    addPreview.removeAttribute('data-preview');
		});

    // Open Update Product Modal (Placeholder - requires server-side implementation)
    function openUpdateModal(modelNo) {
        currentModelNo = modelNo;
        // Fetch product data via AJAX (placeholder endpoint)
        fetch(`getProduct?modelNo=${modelNo}`)
            .then(response => response.json())
            .then(product => {
                if (!product) {
                    alert('Product not found.');
                    return;
                }
                document.getElementById('updateModelNoHidden').value = product.modelNo;
                document.getElementById('updateModelNo').value = product.modelNo;
                document.getElementById('updateCompany').value = product.brand;
                document.getElementById('updateTitle').value = product.title;
                document.getElementById('updateDescription').value = product.description;
                document.getElementById('updatePrice').value = product.price;
                document.getElementById('updateStock').value = product.stock;
                const updatePreview = document.getElementById('updateImagePreview');
                if (updatePreview) {
                    updatePreview.src = ${window.location.origin}/hamro-karkhana/resources/images/system/${product.image};
                }
                document.getElementById('updateProductModal').style.display = 'flex';
            })
            .catch(error => {
                console.error('Error fetching product:', error);
                alert('Failed to load product data. Update functionality not yet implemented.');
            });
    }

    // Open Delete Confirmation Modal
    function openDeleteModal(modelNo) {
        currentModelNo = modelNo;
        document.getElementById('deleteConfirmModal').style.display = 'flex';
    }

    // Close Modal
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
        if (modalId === 'addProductModal') {
            const addPreview = document.getElementById('addImagePreview');
            addPreview.src = 'https://via.placeholder.com/150x100';
            addPreview.removeAttribute('data-preview');
        }
    }

    // Delete Product (Placeholder)
    function deleteProduct() {
        fetch('deleteProduct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `modelNo=${currentModelNo}`
        })
        .then(response => {
            if (response.ok) {
                closeModal('deleteConfirmModal');
                window.location.reload(); // Reload to refresh table
            } else {
                throw new Error('Failed to delete product');
            }
        })
        .catch(error => {
            console.error('Error deleting product:', error);
            alert('Failed to delete product. Delete functionality not yet implemented.');
        });
    }

    // Handle Update Product Form Submission (Placeholder)
    document.getElementById('updateProductForm').addEventListener('submit', (e) => {
        e.preventDefault();
        const formData = new FormData(e.target);
        fetch('updateProduct', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (response.ok) {
                closeModal('updateProductModal');
                window.location.reload(); // Reload to refresh table
            } else {
                throw new Error('Failed to update product');
            }
        })
        .catch(error => {
            console.error('Error updating product:', error);
            alert('Failed to update product. Update functionality not yet implemented.');
        });
    });

    // Preview image in Add Modal
    document.getElementById('addImage').addEventListener('change', function () {
        const file = this.files[0];
        const preview = document.getElementById('addImagePreview');
        if (file && file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function (event) {
                preview.src = event.target.result;
                preview.setAttribute('data-preview', 'true');
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = 'https://via.placeholder.com/150x100';
            preview.removeAttribute('data-preview');
        }
    });

    // Preview image in Update Modal
    document.getElementById('updateImage').addEventListener('change', function () {
        const file = this.files[0];
        const preview = document.getElementById('updateImagePreview');
        if (file && file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function (event) {
                preview.src = event.target.result;
                preview.setAttribute('data-preview', 'true');
            };
            reader.readAsDataURL(file);
        }
    });

    // Click to trigger file input for Add Modal
    document.getElementById('addImagePreview').addEventListener('click', () => {
        const fileInput = document.getElementById('addImage');
        if (fileInput) {
            fileInput.click();
        } else {
            console.error('addImage file input not found');
        }
    });

    // Click to trigger file input for Update Modal
    document.addEventListener('click', (event) => {
        const updateImagePreview = document.getElementById('updateImagePreview');
        const updateImageInput = document.getElementById('updateImage');
        if (event.target === updateImagePreview && updateImageInput) {
            updateImageInput.click();
        }
    });
    
    // added jsut now
    
   

    // Function to close any modal by ID
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    // Optional: Close modal when clicking outside of modal content
    window.onclick = function (event) {
        const addModal = document.getElementById("addProductModal");
        if (event.target === addModal) {
            addModal.style.display = "none";
        }
    };
</script>

<jsp:include page="footer.jsp" />
</body>
</html>
