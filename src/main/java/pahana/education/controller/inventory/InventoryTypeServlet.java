package pahana.education.controller.inventory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pahana.education.dao.InventoryDao;
import pahana.education.model.request.InventoryTypeRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.util.CommonResponseUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "inventoryTypeServlet", value = "/inventory-type")
@MultipartConfig
public class InventoryTypeServlet extends HttpServlet {
    private List<String> inventoryTypes;
    public void init() {
        inventoryTypes = new ArrayList<>();
        inventoryTypes.add("Electronics");
        inventoryTypes.add("Furniture");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");
        CommonResponse<List<InventoryTypeResponse>> inventoryTypes = null;

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                CommonResponse<InventoryTypeResponse> inventoryType = InventoryDao.getInstance().getInventoryTypeById(id);
                if (inventoryType.getData() != null) {
                    request.setAttribute("inventoryType", inventoryType.getData());
                    request.getRequestDispatcher("/src/pages/product-type-form.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Inventory type not found");
                    request.getRequestDispatcher("/src/pages/product-type-list.jsp").forward(request, response);
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
                inventoryTypes = InventoryDao.getInstance().getAllInventoryTypesPaginate(pageSize, offset);

                int totalRecords = inventoryTypes.getTotalCount(); // add getter in CommonResponse
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                request.setAttribute("inventoryTypes", inventoryTypes.getData());
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("totalRecords", totalRecords);

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.getRequestDispatcher("/src/pages/product-type-list.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String action = request.getParameter("action");
        String productTypeName = request.getParameter("productTypeName");

        InventoryTypeRequest inventoryTypeRequest = new InventoryTypeRequest();
        inventoryTypeRequest.setName(productTypeName);

        if ("DELETE".equalsIgnoreCase(action)) {
            doDelete(request, response);
        } else {
            try {
                CommonResponse<String> inventoryType;
                if (id != null && !id.isEmpty()) {
                    int typeId = Integer.parseInt(id);
                    inventoryTypeRequest.setId(typeId);
                    inventoryType = InventoryDao.getInstance().updateInventoryType(inventoryTypeRequest);
                } else {
                    inventoryType = InventoryDao.getInstance().createInventoryType(inventoryTypeRequest);
                }

                String jsonResponse = CommonResponseUtil.getJsonResponse(inventoryType);
                out.write(jsonResponse);
                out.flush();
                out.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID parameter");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            CommonResponse<String> deleteResponse = InventoryDao.getInstance().deleteInventoryType(id);

            if (deleteResponse.getCode() == 200) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(deleteResponse.getMessage());
            } else {
                response.sendError(deleteResponse.getCode(), deleteResponse.getMessage());
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Delete failed: " + e.getMessage());
        }
    }

    public void destroy() {}
}
