package pahana.education.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

public class FileUploads {

    public static String handleFileUpload(HttpServletRequest request, Part filePart, String UPLOAD_DIR)
            throws IOException {
        String appPath = request.getServletContext().getRealPath("");

        File uploadDir = new File(appPath + UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String fileName = UUID.randomUUID() + "-" + extractFileName(filePart);
        String filePath = uploadDir + File.separator + fileName;

        filePart.write(filePath);
        return "/" + UPLOAD_DIR + "/" + fileName;
    }

    private static String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public static String handleImageUpload(HttpServletRequest request, byte[] imageBytes, String UPLOAD_DIR)
            throws IOException {

        String uploadPath = request.getServletContext().getRealPath("") + UPLOAD_DIR;
        String fileName = UUID.randomUUID() + ".png";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try (FileOutputStream fos = new FileOutputStream(uploadPath + File.separator + fileName)) {
            fos.write(imageBytes);
        }
        return "/" + UPLOAD_DIR + "/" + fileName;
    }

}
