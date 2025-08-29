package pahana.education.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import pahana.education.dao.UserDAO;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.UserDataResponse;
import pahana.education.util.CommonResponseUtil;
import pahana.education.util.CommonUtil;
import pahana.education.util.EmailUtil;
import pahana.education.util.TemplateUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@WebServlet(name = "changePasswordServlet", value = "/change-password")
public class ChangePasswordServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        UserDataResponse user = (UserDataResponse) session.getAttribute("user");

        JSONObject json =  CommonUtil.getJsonData(request);
        String changePassword = json.getString("newPassword");
        try {
            CommonResponse<UserDataResponse> userDataResponse = UserDAO.getInstance().getUserById(user.getId());
            CommonResponse<String> userData = UserDAO.getInstance().changePassword(changePassword ,user.getId());
            if (userData.getCode() == 200) {
                Map<String, String> values = new HashMap<>();
                values.put("userName", userDataResponse.getData().getFirstName());
                values.put("changeDate", new Date().toString());

                String template = TemplateUtil.loadTemplateFromWebapp(request,"password-changed.html");
                String filledHtml = TemplateUtil.fillTemplate(template, values);

                EmailUtil.sendEmail(userDataResponse.getData().getEmail(), "Your Password Has Been Changed", filledHtml);
            }
            String jsonResponse = CommonResponseUtil.getJsonResponse(userData);

            out.write(jsonResponse);
            out.flush();
            out.close();
        }catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

}
