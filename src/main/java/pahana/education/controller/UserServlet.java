package pahana.education.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.json.JSONObject;
import pahana.education.dao.AuthorDao;
import pahana.education.dao.InventoryDao;
import pahana.education.dao.UserDAO;
import pahana.education.model.request.InventoryRequest;
import pahana.education.model.request.UserRequest;
import pahana.education.model.response.*;
import pahana.education.util.CommonResponseUtil;
import pahana.education.util.CommonUtil;
import pahana.education.util.FileUploads;
import pahana.education.util.enums.Gender;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "userServlet", value = "/user")
public class UserServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");
        String type = request.getParameter("type");
        String action = request.getParameter("action");
        CommonResponse<List<UserDataResponse>> userDataList = null;

        if (idParam != null && !idParam.isEmpty()) {
            try {
                List<UserRoleResponse> userRoles = UserDAO.getInstance().getAllUserRoles();

                int id = Integer.parseInt(idParam);
                CommonResponse<UserDataResponse> userData = UserDAO.getInstance().getUserById(id);
                if (userData.getData() != null) {
                    request.setAttribute("userRoleList", userRoles);
                    request.setAttribute("userData", userData.getData());
                    request.getRequestDispatcher("/src/pages/user-form.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("errorMessage", "user not found");
                    request.getRequestDispatcher("/src/pages/user-list.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        if ("user".equalsIgnoreCase(type)) {
            if ("add_new".equalsIgnoreCase(action)) {
                try {
                    List<UserRoleResponse> userRoles = UserDAO.getInstance().getAllUserRoles();
                    request.setAttribute("userRoleList", userRoles);
                    request.getRequestDispatcher("/src/pages/user-form.jsp").forward(request, response);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            } else {
                int page = 1;
                int pageSize = 5;
                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    try {
                        page = Integer.parseInt(pageParam);
                        if (page < 1) page = 1;
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                }

                int offset = (page - 1) * pageSize;
                try {
                    userDataList = UserDAO.getInstance().getAllUserPaginate(pageSize, offset);
                    int totalRecords = userDataList.getTotalCount();
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                    request.setAttribute("customerList", userDataList.getData());
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("totalRecords", totalRecords);

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                request.getRequestDispatcher("/src/pages/user-list.jsp").forward(request, response);
            }

        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String jsonResponse = "";

        String action = request.getParameter("action");

        JSONObject json =  CommonUtil.getJsonData(request);

        String productImagePath = "";
        String userId = json.getString("userId");
        String roleId = json.getString("userRoleId");
        String firstName = json.getString("firstName");
        String lastName = json.getString("lastName");
        String phoneNo = json.getString("phoneNo");
        String email = json.getString("email");
        String password = json.getString("password");
        String dateOfBirth = json.getString("dateOfBirth");
        String gender = json.getString("gender");
        String address = json.getString("address");
        String customerTypeId = json.getString("customerTypeId");
        String accountNo = json.getString("accountNo");
        String base64DataUrl = json.getString("userImage");

        if (!base64DataUrl.equals("") && base64DataUrl != null || !base64DataUrl.isEmpty()) {
            String base64Image = base64DataUrl.split(",")[1]; // remove data:image/... prefix
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);
            productImagePath= FileUploads.handleImageUpload(request, imageBytes, UPLOAD_DIR);
        }

        LocalDate dob = null;
        if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
            dob = LocalDate.parse(dateOfBirth);
        }

        UserRequest usrRequest = new UserRequest();
        usrRequest.setFirstName(firstName);
        usrRequest.setLastName(lastName);
        usrRequest.setPhoneNo(phoneNo);
        usrRequest.setEmail(email);
        usrRequest.setPassword(password);
        usrRequest.setDateOfBirth(dob);
        usrRequest.setGender(Gender.valueOf(gender.toUpperCase()));
        usrRequest.setAddress(address);
        usrRequest.setAccountNo(accountNo);
        usrRequest.setCustomerTypeId(CommonUtil.checkIntValue(customerTypeId, 0));
        usrRequest.setUserImagePath(productImagePath);

        try {
            CommonResponse<String> userData;
            if (userId != null && !userId.isEmpty()) {
                int id = Integer.parseInt(userId);
                int userRoleId = Integer.parseInt(roleId);
                usrRequest.setUserId(id);
                usrRequest.setUserRoleId(userRoleId);
                userData = UserDAO.getInstance().updateUser(usrRequest);
            } else {
                CommonResponse<String> emailExists = UserDAO.getInstance().checkEmailExists(email);
                if (emailExists.getCode() == 409) {
                    userData = emailExists;
                } else {
                    userData = UserDAO.getInstance().createUser(usrRequest);
                }
            }

            jsonResponse = CommonResponseUtil.getJsonResponse(userData);
            out.write(jsonResponse);
            out.flush();
            out.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String jsonResponse = "";
        JSONObject json =  CommonUtil.getJsonData(request);

        String userId =json.getString("userId");

        try {
            CommonResponse<String> returnData;
            int id = Integer.parseInt(userId);
            CommonResponse<String> deleteResponse = UserDAO.getInstance().deleteUser(id);
            jsonResponse = CommonResponseUtil.getJsonResponse(deleteResponse);
            out.write(jsonResponse);
            out.flush();
            out.close();

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Delete failed: " + e.getMessage());
        }
    }


}
