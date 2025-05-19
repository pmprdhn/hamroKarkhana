package com.hamroKarkhana.util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

public class ImageUtil {

    // Modify the method signature to accept folder name
    public boolean uploadImage(Part image, String realPath, String folderName) throws IOException {
        // Get the file name from the image part
        String fileName = extractFileName(image);
        
        // Create the folder path where the image will be saved
        String folderPath = realPath + File.separator + "images" + File.separator + folderName;
        
        // Ensure the folder exists, create it if it doesn't
        File folder = new File(folderPath);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        // Define the path to save the image
        String imagePath = folderPath + File.separator + fileName;

        // Write the image file to disk
        try (InputStream inputStream = image.getInputStream();
             OutputStream outputStream = Files.newOutputStream(Paths.get(imagePath))) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        return true;
    }

    // Helper method to extract the file name from the Part object
    private String extractFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String cd : header.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName;
            }
        }
        return null;
    }

    // Helper method to get the image name from Part
    public String getImageNameFromPart(Part part) throws IOException {
        return extractFileName(part);
    }
}
