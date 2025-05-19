<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.hamroKarkhana.model.ProductModel" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Product</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-product.css">
<style>
    .success-message {
        color: green;
        margin-bottom: 20px;
    }
    .error-message {
        color: red;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container">
    <jsp:include page="sidebar.jsp" />

    <main class="main-content">
        <div class="inventory-header">
            <h1>Inventory</h1>
            <button class="add-button" onclick="openModal('addModal')">Add Product</button>
        </div>

        <!-- Error/Success Messages -->
        <% 
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="error-message"><%= error %></div>
        <%
            }
            if (success != null) {
        %>
            <div class="success-message"><%= success %></div>
        <%
            }
        %>

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
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            	
                <% 
                    List<ProductModel> products = (List<ProductModel>) request.getAttribute("products");
                    if (products == null || products.isEmpty()) {
                %>
                    <tr>
                        <td colspan="8" style="text-align: center;">No products in stock.</td>
                    </tr>
                <%
                    } else {
                        for (ProductModel product : products) {
                %>
                    <tr>
                        <td>
                            <img src="${pageContext.request.contextPath}/resources/images/system/<%= product.getImage() %>" 
                                 alt="<%= product.getTitle() %>" 
                                 onerror="this.src='https://via.placeholder.com/100'" 
                                 style="width: 100px; height: auto; object-fit: cover;">
                        </td>
                        <td><%= product.getModelNo() %></td>
                        <td><%= product.getBrand() %></td>
                        <td><%= product.getTitle() %></td>
                        <td><%= product.getDescription() %></td>
                        <td>Rs.<%= product.getPrice() %></td>
                        <td><%= product.getStock() %></td>
                        <td class="action-buttons">
                            <button
							  class="update-btn"
							  onclick="openUpdateModal(this)"
							  data-modelno="<%= product.getModelNo() %>"
							  data-brand="<%= product.getBrand() %>"
							  data-title="<%= product.getTitle() %>"
							  data-description="<%= product.getDescription() %>"
							  data-price="<%= product.getPrice() %>"
							  data-stock="<%= product.getStock() %>"
							  data-image="<%= product.getImage() %>"
							>
							  Update
							</button>
                            <form action="${pageContext.request.contextPath}/deleteProduct" method="POST" style="display:inline;">
                                <input type="hidden" name="modelNo" value="<%= product.getModelNo() %>">
                                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete <%= product.getTitle() %>?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <!-- Add Modal (Unchanged) -->
        <div id="addModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal('addModal')">×</span>
                <h2>Add Product</h2>
                <form id="addProductForm" action="addProduct" method="post" enctype="multipart/form-data">
                    <label for="image">Image:</label>
                    <input type="file" name="image" id="image" accept="image/*" required>
                    <label for="modelNo">Model No:</label>
                    <input type="text" name="modelNo" id="modelNo" placeholder="Model No" required>
                    <label for="brand">Brand:</label>
                    <input type="text" name="brand" id="brand" placeholder="Brand" required>
                    <label for="title">Title:</label>
                    <input type="text" name="title" id="title" placeholder="Title" required>
                    <label for="description">Description:</label>
                    <textarea name="description" id="description" placeholder="Description" required></textarea>
                    <label for="price">Price:</label>
                    <input type="text" name="price" id="price" placeholder="Price" pattern="^\d+$" title="Price must be a number" required>
                    <label for="stock">Stock:</label>
                    <input type="number" name="stock" id="stock" placeholder="Stock" min="0" required>
                    <button class="add-button" type="submit">Submit</button>
                </form>
            </div>
        </div>

       
<!-- Update Modal -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('updateModal')">×</span>
        <h2>Edit Product</h2>
        <form id="updateProductForm" action="${pageContext.request.contextPath}/updateProduct" method="post" enctype="multipart/form-data">
            <input type="hidden" name="editModelNo" id="editModelNoHidden">
            <label for="editImage">Image:</label>
            <input type="file" name="image" id="editImage" accept="image/*">
            <img id="editImagePreview" src="https://via.placeholder.com/100" alt="Product Image" style="width: 100px; height: auto; margin: 10px 0;">
            
            <label for="editModelNo">Model No:</label>
            <input type="text" name="modelNo" id="editModelNo" placeholder="Model No" readonly>
            
            <label for="editBrand">Brand:</label>
            <input type="text" name="brand" id="editBrand" placeholder="Brand" required>
            
            <label for="editTitle">Title:</label>
            <input type="text" name="title" id="editTitle" placeholder="Title" required>
            
            <label for="editDescription">Description:</label>
            <textarea name="description" id="editDescription" placeholder="Description" required></textarea>
            
            <label for="editPrice">Price:</label>
            <input type="text" name="price" id="editPrice" placeholder="Price" pattern="^\d+$" title="Price must be a number" required>
            
            <label for="editStock">Stock:</label>
            <input type="number" name="stock" id="editStock" placeholder="Stock" min="0" required>
            
            <div class="modal-buttons">
                <button type="submit" class="update-btn">Update</button>
                <button type="button" class="cancel-btn" onclick="closeModal('updateModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

    </main>
</div>

<jsp:include page="footer.jsp" />

<script>
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
        if (modalId === 'updateModal') {
            document.getElementById('updateProductForm').reset();
            document.getElementById('editImagePreview').src = 'https://via.placeholder.com/100';
            document.getElementById('editModelNo').value = '';
        }
    }

    function openUpdateModal(button) {
        const product = {
            modelNo: button.getAttribute('data-modelno'),
            brand: button.getAttribute('data-brand'),
            title: button.getAttribute('data-title'),
            description: button.getAttribute('data-description'),
            price: button.getAttribute('data-price'),
            stock: button.getAttribute('data-stock'),
            image: button.getAttribute('data-image')
        };

        document.getElementById('editModelNoHidden').value = product.modelNo;
        document.getElementById('editModelNo').value = product.modelNo;
        document.getElementById('editBrand').value = product.brand;
        document.getElementById('editTitle').value = product.title;
        document.getElementById('editDescription').value = product.description;
        document.getElementById('editPrice').value = product.price;
        document.getElementById('editStock').value = product.stock;
        document.getElementById('editImagePreview').src = `${window.location.origin}/resources/images/system/${product.image || 'placeholder.jpg'}`;
        document.getElementById('updateModal').style.display = 'block';
    }

    // Image preview for update modal
    document.addEventListener('DOMContentLoaded', function() {
        const editImageInput = document.getElementById('editImage');
        if (editImageInput) {
            editImageInput.addEventListener('change', function () {
                const file = this.files[0];
                const preview = document.getElementById('editImagePreview');
                if (file && file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function (event) {
                        preview.src = event.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
    });

    // Close modals on outside click
    window.onclick = function(event) {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            if (event.target === modal) {
                closeModal(modal.id);
            }
        });
    };
</script>

</body>
</html>