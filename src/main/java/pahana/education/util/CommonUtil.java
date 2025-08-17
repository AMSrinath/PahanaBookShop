package pahana.education.util;

import jakarta.servlet.http.HttpServletRequest;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;

public class CommonUtil {

    public static double checkDoubleValue(String value, double defaultValue) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Double.parseDouble(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static Integer checkIntValue(String value, int defaultValue) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static JSONObject getJsonData(HttpServletRequest request) throws IOException {
        StringBuilder jsonBuffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuffer.append(line);
        }

        return new JSONObject(jsonBuffer.toString());
    }
}
