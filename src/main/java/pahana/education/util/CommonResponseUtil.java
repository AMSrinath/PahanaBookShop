package pahana.education.util;

import pahana.education.model.response.CommonResponse;

public class CommonResponseUtil {
    public static String getJsonResponse(CommonResponse<String> response) {
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
}
