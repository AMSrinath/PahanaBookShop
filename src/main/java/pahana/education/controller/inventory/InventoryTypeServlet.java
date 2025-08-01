package pahana.education.controller.inventory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pahana.education.dao.InventoryDao;
import pahana.education.model.request.inventory.InventoryTypeRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.user.UserDataResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "inventoryTypeServlet", value = "/inventory-type")
public class InventoryTypeServlet extends HttpServlet {
    private List<String> inventoryTypes;
    public void init() {
        inventoryTypes = new ArrayList<>();
        inventoryTypes.add("Electronics");
        inventoryTypes.add("Furniture");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setAttribute("inventoryTypes", inventoryTypes);
        request.getRequestDispatcher("/inventory.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String inventoryType = request.getParameter("inventoryType");
        HashMap<String, String> errors = new HashMap<>();

        if (inventoryType == null || inventoryType.trim().isEmpty()) {
            errors.put("inventoryType", "Product type is required");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("inventoryType.jsp").forward(request, response);
            return;
        }

        InventoryTypeRequest inventoryTypeRequest = new InventoryTypeRequest();
        inventoryTypeRequest.setName(inventoryType);

        try {
            CommonResponse<UserDataResponse> inventoryDao = InventoryDao.getInstance().createInventoryType(inventoryTypeRequest);
            if (inventoryDao.getCode() == 200) {
                request.setAttribute("successMessage", inventoryDao.getMessage());
                response.sendRedirect("book-list");
            } else {
                request.setAttribute("error", inventoryDao.getMessage());
                request.getRequestDispatcher("inventoryType.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("inventory-type");
    }

    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void destroy() {}
}
