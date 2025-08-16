package pahana.education.controller.author;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import pahana.education.dao.AuthorDao;
import pahana.education.dao.InventoryDao;
import pahana.education.model.request.InventoryRequest;
import pahana.education.model.response.AuthorDataResponse;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.util.FileUploads;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "authorServlet", value = "/author")
@MultipartConfig
public class AuthorServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "/src/assets/images/uploads";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");
        CommonResponse<List<AuthorDataResponse>> authorDataResponses = null;

        if ("types".equalsIgnoreCase(action)) {
            getAuthorsData(request, response);
        }

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                CommonResponse<AuthorDataResponse> author = AuthorDao.getInstance().getAuthorById(id);
                if (author.getData() != null) {
                    request.setAttribute("inventoryType", author.getData());
                    request.getRequestDispatcher("/src/pages/author-form.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Inventory type not found");
                    request.getRequestDispatcher("/src/pages/author-list.jsp").forward(request, response);
                }
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
                authorDataResponses = AuthorDao.getInstance().getAllAuthorPaginate(pageSize, offset);
                request.setAttribute("authorList", authorDataResponses);
                request.getRequestDispatcher("/src/pages/author-form.jsp").forward(request, response);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }


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
