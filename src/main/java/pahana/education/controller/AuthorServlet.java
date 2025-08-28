package pahana.education.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import pahana.education.dao.AuthorDao;
import pahana.education.dao.UserDAO;
import pahana.education.model.request.UserRequest;
import pahana.education.model.response.AuthorDataResponse;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.UserDataResponse;
import pahana.education.model.response.UserRoleResponse;
import pahana.education.util.CommonResponseUtil;
import pahana.education.util.CommonUtil;
import pahana.education.util.FileUploads;
import pahana.education.util.enums.Gender;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "authorServlet", value = "/author")
@MultipartConfig
public class AuthorServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");
        CommonResponse<List<AuthorDataResponse>> authorList = null;

        if ("types".equalsIgnoreCase(action)) {
            getAuthorsData(request, response);
        }

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                CommonResponse<AuthorDataResponse> authorData = AuthorDao.getInstance().getAuthorById(id);

                if (authorData.getData() != null) {
                    request.setAttribute("authorData", authorData.getData());
                    request.getRequestDispatcher("/src/pages/author-form.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("errorMessage", "user not found");
                    request.getRequestDispatcher("/src/pages/author-list.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }else {
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
                CommonResponse<List<AuthorDataResponse>> authorListData = AuthorDao.getInstance().getAllAuthorPaginate(pageSize, offset);
                int totalRecords = authorListData.getTotalCount();
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                request.setAttribute("authorList", authorListData.getData());
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("totalRecords", totalRecords);

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.getRequestDispatcher("/src/pages/author-list.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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

//    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        String idParam = request.getParameter("id");
//        String action = request.getParameter("action");
//        CommonResponse<List<AuthorDataResponse>> authorDataResponses = null;
//
//        if ("types".equalsIgnoreCase(action)) {
//            getAuthorsData(request, response);
//        }
//
//        if (idParam != null && !idParam.isEmpty()) {
//            try {
//                int id = Integer.parseInt(idParam);
//                CommonResponse<AuthorDataResponse> author = AuthorDao.getInstance().getAuthorById(id);
//                if (author.getData() != null) {
//                    request.setAttribute("inventoryType", author.getData());
//                    request.getRequestDispatcher("/src/pages/author-form.jsp").forward(request, response);
//                } else {
//                    request.setAttribute("errorMessage", "Inventory type not found");
//                    request.getRequestDispatcher("/src/pages/author-list.jsp").forward(request, response);
//                }
//            } catch (Exception e) {
//                throw new RuntimeException(e);
//            }
//        } else {
//            int page = 1;
//            int pageSize = 5;
//            String pageParam = request.getParameter("page");
//            if (pageParam != null) {
//                try {
//                    page = Integer.parseInt(pageParam);
//                    if (page < 1) page = 1;
//                } catch (NumberFormatException e) {
//                    page = 1;
//                }
//            }
//
//            int offset = (page - 1) * pageSize;
//            try {
//                authorDataResponses = AuthorDao.getInstance().getAllAuthorPaginate(pageSize, offset);
//                int totalRecords = authorDataResponses.getTotalCount();
//                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
//
//                request.setAttribute("authorList", authorDataResponses.getData());
//                request.setAttribute("currentPage", page);
//                request.setAttribute("totalPages", totalPages);
//                request.setAttribute("pageSize", pageSize);
//                request.setAttribute("totalRecords", totalRecords);
//            } catch (Exception e) {
//                throw new RuntimeException(e);
//            }
//            request.getRequestDispatcher("/src/pages/author-list.jsp").forward(request, response);
//        }
//    }
//
//    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//    }
//
    private void getAuthorsData(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        try {
            List<AuthorDataResponse> types = AuthorDao.getInstance().getAllAuthorList();
            out.print(mapper.writeValueAsString(types));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(mapper.writeValueAsString(new CommonResponse<>(500, "Error fetching inventory types", null)));
        }
    }

}
