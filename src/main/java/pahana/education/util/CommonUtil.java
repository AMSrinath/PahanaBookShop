package pahana.education.util;

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
}
