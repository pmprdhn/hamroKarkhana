package com.hamroKarkhana.controller;

import java.io.IOException;


import com.hamroKarkhana.model.CustomerModel;
import com.hamroKarkhana.service.RegisterService;
import com.hamroKarkhana.util.ImageUtil;
import com.hamroKarkhana.util.PasswordUtil;
import com.hamroKarkhana.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ImageUtil imageUtil = new ImageUtil();
	private final RegisterService registerService = new RegisterService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[DEBUG] GET /register called");
		req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("[DEBUG] POST /register called");
	    try {
	        String validationMessage = validateRegistrationForm(req);
	        if (validationMessage != null) {
	            System.out.println("[DEBUG] Validation failed: " + validationMessage);
	            handleError(req, resp, validationMessage);
	            return;
	        }

	        System.out.println("[DEBUG] Validation passed");

	        // First extract customerModel
	        CustomerModel customerModel = extractCustomerModel(req);
	        System.out.println("[DEBUG] Extracted customer model: " + customerModel);

	        // Now call registerService using customerModel
	        String registrationResult = registerService.registerCustomer(customerModel);
	        System.out.println("[DEBUG] RegisterService result: " + registrationResult);

	        switch (registrationResult) {
	            case "success":
	                if (uploadImage(req)) {
	                    System.out.println("[DEBUG] Image uploaded successfully");
	                    handleSuccess(req, resp, "Your account has been successfully created.", "/WEB-INF/pages/login.jsp");
	                } else {
	                    System.out.println("[DEBUG] Image upload failed");
	                    handleError(req, resp, "Failed to upload profile picture. Please try again.");
	                }
	                break;

	            case "username_exists":
	                handleError(req, resp, "Username already exists. Please select a new username.");
	                break;

	            case "email_exists":
	                handleError(req, resp, "Email already exists. Please use a different email address.");
	                break;

	            case "insert_failed":
	                handleError(req, resp, "Could not register your account. Please try again.");
	                break;

	            default:
	                handleError(req, resp, "An unexpected error occurred. Please try again later.");
	                break;
	        }

	    } catch (Exception e) {
	        System.out.println("[ERROR] Unexpected exception: " + e.getMessage());
	        e.printStackTrace();
	        handleError(req, resp, "An unexpected error occurred. Please try again.");
	    }

	}

	private String validateRegistrationForm(HttpServletRequest req) {
		System.out.println("[DEBUG] Validating registration form");

		String name = req.getParameter("name");
		String username = req.getParameter("username");
		String gender = req.getParameter("gender");
		String email = req.getParameter("email");
		String phoneNumber = req.getParameter("phoneNumber");
		String address = req.getParameter("address");
		String password = req.getParameter("password");
		String retypePassword = req.getParameter("retypePassword");

		if (ValidationUtil.isNullOrEmpty(name)) return "Name is required.";
		if (ValidationUtil.isNullOrEmpty(username)) return "Username is required.";
		if (ValidationUtil.isNullOrEmpty(gender)) return "Gender is required.";
		if (ValidationUtil.isNullOrEmpty(email)) return "Email is required.";
		if (ValidationUtil.isNullOrEmpty(phoneNumber)) return "Phone number is required.";
		if (ValidationUtil.isNullOrEmpty(address)) return "Address is required.";
		if (ValidationUtil.isNullOrEmpty(password)) return "Password is required.";
		if (ValidationUtil.isNullOrEmpty(retypePassword)) return "Please retype the password.";
		if (ValidationUtil.isNullOrEmpty(name)) return "Name is required.";
		if (!ValidationUtil.isValidName(name)) return "Name must contain only letters and spaces.";
		if (!ValidationUtil.isAlphanumericStartingWithLetter(username)) return "Username must start with a letter and only contain letters and numbers.";
		if (!ValidationUtil.isValidGender(gender)) return "Gender must be 'male' or 'female'.";
		if (!ValidationUtil.isValidEmail(email)) return "Invalid email format.";
		if (!ValidationUtil.isValidPhoneNumber(phoneNumber)) return "Phone number must be 10 digits and start with 98.";
		if (!ValidationUtil.isValidPassword(password)) return "Password must be at least 8 characters long with 1 uppercase letter, 1 number, and 1 symbol.";
		if (!ValidationUtil.doPasswordsMatch(password, retypePassword)) return "Passwords do not match.";

		try {
			Part image = req.getPart("image");
			if (!ValidationUtil.isValidImageExtension(image)) return "Invalid image format. Only jpg, jpeg, png, and gif are allowed.";
		} catch (IOException | ServletException e) {
			System.out.println("[ERROR] Exception while validating image: " + e.getMessage());
			return "Error handling image file. Please ensure the file is valid.";
		}

		System.out.println("[DEBUG] Registration form validated successfully");
		return null;
	}

	private CustomerModel extractCustomerModel(HttpServletRequest req) throws Exception {
		System.out.println("[DEBUG] Extracting customer model from request");

		String name = req.getParameter("name");
		String username = req.getParameter("username");
		String gender = req.getParameter("gender");
		String email = req.getParameter("email");
		String phoneNumber = req.getParameter("phoneNumber");
		String address = req.getParameter("address");
		String password = req.getParameter("password");

		password = PasswordUtil.encrypt(username, password);
		System.out.println("[DEBUG] Encrypted password");

		Part image = req.getPart("image");
		String imageUrl = imageUtil.getImageNameFromPart(image);
		System.out.println("[DEBUG] Image file name: " + imageUrl);

		return new CustomerModel(name, username, email, phoneNumber, address, gender, password, imageUrl);
	}

	private boolean uploadImage(HttpServletRequest req) throws IOException, ServletException {
		System.out.println("[DEBUG] Uploading image");
		Part image = req.getPart("image");
		return imageUtil.uploadImage(image, req.getServletContext().getRealPath("/"), "customer");
	}

	private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
			throws ServletException, IOException {
		System.out.println("[DEBUG] Registration successful: " + message);
		req.setAttribute("success", message);
		req.getRequestDispatcher(redirectPage).forward(req, resp);
	}

	private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
			throws ServletException, IOException {
		System.out.println("[DEBUG] Registration error: " + message);
		req.setAttribute("error", message);
		req.setAttribute("name", req.getParameter("name"));
		req.setAttribute("username", req.getParameter("username"));
		req.setAttribute("gender", req.getParameter("gender"));
		req.setAttribute("email", req.getParameter("email"));
		req.setAttribute("phoneNumber", req.getParameter("phoneNumber"));
		req.setAttribute("address", req.getParameter("address"));
		req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
	}
}
