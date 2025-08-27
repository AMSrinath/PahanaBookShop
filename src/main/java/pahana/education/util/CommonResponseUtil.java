package pahana.education.util;

import org.json.JSONArray;
import org.json.JSONObject;
import pahana.education.model.response.CommonResponse;

import java.util.Collection;
import java.util.Map;

public class CommonResponseUtil {
    public static String getJsonResponse11(CommonResponse<String> response) {
        String jsonResponse = "";
        if (response.getCode() == 400 || response.getCode() == 500) {
            jsonResponse = String.format("{\"code\": %d, \"message\": \"%s\"}",
                    response.getCode(),
                    response.getMessage().replace("\"", "\\\"")); // escape quotes
        }  else {
            jsonResponse = String.format("{\"code\": %d, \"message\": \"%s\"}",
                    response.getCode(),
                    response.getMessage().replace("\"", "\\\"")); // escape quotes
        }
        return jsonResponse;
    }


    public static <T> String getJsonResponse22(CommonResponse<T> response) {
        String jsonResponse;

        if (response.getCode() == 400 || response.getCode() == 500 || response.getCode() == 404) {
            jsonResponse = String.format(
                    "{\"code\": %d, \"message\": \"%s\"}",
                    response.getCode(),
                    response.getMessage().replace("\"", "\\\"")
            );
        } else {
            String dataPart = "null";  // default if data is null

            if (response.getData() != null) {
                if (response.getData() instanceof String) {
                    dataPart = String.format("\"%s\"", response.getData().toString().replace("\"", "\\\""));
                } else if (response.getData() instanceof Map) {
                    dataPart = new JSONObject((Map<?, ?>) response.getData()).toString();
                } else {
                    dataPart = new JSONObject(response.getData()).toString();
                }
            }

            jsonResponse = String.format(
                    "{\"code\": %d, \"message\": \"%s\", \"data\": %s}",
                    response.getCode(),
                    response.getMessage().replace("\"", "\\\""),
                    dataPart
            );
        }

        return jsonResponse;
    }


    public static <T> String getJsonResponse(CommonResponse<T> response) {
        String jsonResponse;

        if (response.getCode() == 400 || response.getCode() == 500 || response.getCode() == 404) {
            jsonResponse = String.format(
                    "{\"code\": %d, \"message\": \"%s\"}",
                    response.getCode(),
                    response.getMessage().replace("\"", "\\\"")
            );
        } else {
            String dataPart = "null";

            if (response.getData() != null) {
                if (response.getData() instanceof String) {
                    dataPart = String.format("\"%s\"", response.getData().toString().replace("\"", "\\\""));
                } else if (response.getData() instanceof Map) {
                    dataPart = new JSONObject((Map<?, ?>) response.getData()).toString();
                } else if (response.getData() instanceof Collection) {
                    dataPart = new JSONArray((Collection<?>) response.getData()).toString();
                } else {
                    dataPart = new JSONObject(response.getData()).toString();
                }
            }

            jsonResponse = String.format(
                    "{\"code\": %d, \"message\": \"%s\", \"data\": %s}",
                    response.getCode(),
                    response.getMessage().replace("\"", "\\\""),
                    dataPart
            );
        }

        return jsonResponse;
    }

}
