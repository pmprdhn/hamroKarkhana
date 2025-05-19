<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Edit Profile - Hamro Karkhana</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editProfile.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <main>
    <div class="center-wrapper">
      <div class="container">
      <div class="success-message" style="color: green; font-weight: bold; padding: 25px;
    text-align: center;">${Message}</div>

      
        <div class="profile-section">
          <form class="profile-form" action="${pageContext.request.contextPath}/editProfile" method="post" enctype="multipart/form-data">
            <div class="profile-pic">
              <label for="uploadPic" class="profile-pic-label">
              	<img src="${pageContext.request.contextPath}/resources/images/system/${empty customer.profilePicture ? 'default.png' : customer.profilePicture}?t=${Math.random()}" id="profileImage" alt="Profile Picture">

          
             
                <div class="overlay-text">Choose New Profile Picture</div>
              </label>
              <input type="file" id="uploadPic" name="profilePicture" accept="image/*" hidden>
            </div>
  
            <div class="input-group">
              <label>Name</label>
              <input type="text" name="name" value="${customer.name}" placeholder="Enter your name">
            </div>
  
            <div class="input-group">
              <label>Email</label>
              <input type="email" name="email" value="${customer.email}" placeholder="Enter your email">
            </div>
  
            <div class="input-group">
              <label>Phone Number</label>
              <input type="text" name="phoneNumber" value="${customer.phoneNumber}" placeholder="Enter your phone number">
            </div>
  
            <div class="input-group">
              <label>Address</label>
              <input type="text" name="address" value="${customer.address}" placeholder="Enter your address">
            </div>
  
            <div class="input-group">
             <%
			    com.hamroKarkhana.model.CustomerModel customer = (com.hamroKarkhana.model.CustomerModel) request.getAttribute("customer");
			    String gender = customer != null ? customer.getGender() : "";
			%>
			<label for="gender">Gender:</label>
			<select name="gender" id="gender">
			   <option value="Male" <%= "male".equalsIgnoreCase(gender) ? "selected" : "" %>>Male</option>
			   <option value="Female" <%= "female".equalsIgnoreCase(gender) ? "selected" : "" %>>Female</option>

			</select>

            </div>
            <button type="submit" class="save-btn">Submit</button>
          </form>
        </div>
      </div>
    </div>
  </main>

<jsp:include page="footer.jsp" />

<script>
const fileInput = document.getElementById('uploadPic');
const previewImage = document.getElementById('profileImage');
const saveBtn = document.querySelector('.save-btn');
const form = document.querySelector('.profile-form');

// Image Preview Logic
if (fileInput && previewImage) {
  fileInput.addEventListener('change', function () {
    const file = this.files[0];
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader();
      reader.onload = function (event) {
        previewImage.src = event.target.result;
      };
      reader.readAsDataURL(file);
    }
  });
}

if (previewImage) {
  previewImage.addEventListener('click', () => {
    fileInput.click();
  });
}

// Form Submission Logic
if (saveBtn && form) {
  form.addEventListener('submit', function (e) {
    e.preventDefault(); // Prevent the form from submitting immediately

    // Change the button text to "Saving changes..." and disable it
    saveBtn.disabled = true;
    saveBtn.textContent = "Saving changes...";

    // Save the button state in sessionStorage so we can refer to it after reload
    sessionStorage.setItem('isSaving', 'true');

    // Submit the form after a short delay to allow the button text change to render
    setTimeout(() => {
      form.submit(); // Submit the form
    }, 100);
  });
}

// Check if the form was submitted and the page is being reloaded
if (sessionStorage.getItem('isSaving') === 'true') {
  // Wait for 11 seconds after the page reload, then reload the page
  saveBtn.textContent = "Saving changes...";
  setTimeout(() => {
    // Reset the button text and re-enable the button after 11 seconds
    saveBtn.disabled = false;
    saveBtn.textContent = "Save Changes"; // Reset the text back to default
    sessionStorage.removeItem('isSaving'); // Clean up session storage
    location.reload(); // Reload the page
  }, 11000); // Wait for 11 seconds
}

</script>


</body>
</html>
