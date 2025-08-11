package pahana.education.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class FileUploads {

    public static String handleFileUpload(HttpServletRequest request, Part filePart, String UPLOAD_DIR)
            throws IOException {
        String appPath = request.getServletContext().getRealPath("/uploads");

        File uploadDir = new File(appPath + UPLOAD_DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String fileName = UUID.randomUUID() + "-" + extractFileName(filePart);
        String filePath = uploadDir + File.separator + fileName;

        filePart.write(filePath);
        return UPLOAD_DIR + "/" + fileName;
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
}
