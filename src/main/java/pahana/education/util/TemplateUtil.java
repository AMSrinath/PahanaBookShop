package pahana.education.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;


public class TemplateUtil {
    public static String loadTemplateFromWebapp(HttpServletRequest request, String filePath) throws IOException {
        ServletContext context = request.getServletContext();
        InputStream is = context.getResourceAsStream("/templates/" + filePath);
        if (is == null) {
            throw new FileNotFoundException("Template file not found: /WEB-INF/templates/" + filePath);
        }
        return new String(is.readAllBytes(), StandardCharsets.UTF_8);
    }

    public static String fillTemplate(String template, java.util.Map<String, String> values) {
        for (String key : values.keySet()) {
            template = template.replace("${" + key + "}", values.get(key));
        }
        return template;
    }
}