package com.hamroKarkhana.controller;

import com.hamroKarkhana.service.UserCustomerService;
import com.hamroKarkhana.model.CustomerModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/editProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 10 * 1024 * 1024,   // 10MB
    maxRequestSize = 20 * 1024 * 1024 // 20MB
)
public class EditProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserCustomerService UserCustomerService;

    public EditProfileController() {
        super();
        UserCustomerService = new UserCustomerService(); // Service instance
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");

        if (username != null) {
            CustomerModel customer = UserCustomerService.getCustomerByUsername(username);
            request.setAttribute("customer", customer);
        }

        request.getRequestDispatcher("/WEB-INF/pages/editProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");

        if (username != null) {
            CustomerModel customer = UserCustomerService.getCustomerByUsername(username);

            if (customer != null) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                String address = request.getParameter("address");
                String gender = request.getParameter("gender");

                Part filePart = request.getPart("profilePicture");
                String fileName = null;

                if (filePart != null && filePart.getSize() > 0) {
                    fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                    // Store file in the appropriate directory
                    String uploadPath = "/Users/pratikmanpradhan/eclipse-workspace/hamro-karkhana/src/main/webapp/resources/images/system";

                    System.out.println("Upload Path: " + uploadPath);
                    
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();

                    String uniqueFileName = fileName;
                    File file = new File(uploadDir, uniqueFileName);
                    int counter = 1;
                    while (file.exists()) {
                        uniqueFileName = fileName.substring(0, fileName.lastIndexOf('.')) + "_" + counter + fileName.substring(fileName.lastIndexOf('.'));
                        file = new File(uploadDir, uniqueFileName);
                        counter++;
                    }

                    try (InputStream inputStream = filePart.getInputStream()) {
                        Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    fileName = uniqueFileName;  // Set the file name for DB storage
                }

                // Set updated details in the customer object
                customer.setName(name);
                customer.setEmail(email);
                customer.setPhoneNumber(phoneNumber);
                customer.setAddress(address);
                customer.setGender(gender);
                if (fileName != null) {
                    customer.setProfilePicture(fileName); // Save the file name in the database
                }

                boolean updateSuccessful = UserCustomerService.updateCustomer(customer);

                if (updateSuccessful) {
                    // Set updated customer info in session
                    request.getSession().setAttribute("customer", customer);
                    request.getSession().setAttribute("profilePicture", customer.getProfilePicture());
                    request.getSession().setAttribute("name", customer.getName());

                    // Redirect to avoid form resubmission and show the updated data
                    response.sendRedirect(request.getContextPath() + "/editProfile");
                    return;
                } else {
                    request.setAttribute("Message", "Error updating profile.");
                    request.getRequestDispatcher("/WEB-INF/pages/editProfile.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
