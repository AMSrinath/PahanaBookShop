package pahana.education.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
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
import pahana.education.model.response.AuthorDataResponse;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.util.CommonResponseUtil;
import pahana.education.util.CommonUtil;
import pahana.education.util.FileUploads;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "inventoryServlet", value = "/inventory")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class InventoryServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");
        CommonResponse<List<InventoryResponse>> inventoryList = null;

        if (idParam != null && !idParam.isEmpty()) {
            try {
                List<InventoryTypeResponse> inventoryType = InventoryDao.getInstance().getAllInventoryType();
                List<AuthorDataResponse> authorDataResponses = AuthorDao.getInstance().getAllAuthorList();

                int id = Integer.parseInt(idParam);
                CommonResponse<InventoryResponse> inventory = InventoryDao.getInstance().getInventoryById(id);
                if (inventory.getData() != null) {
                    request.setAttribute("inventoryTypes", inventoryType);
                    request.setAttribute("authorList", authorDataResponses);
                    request.setAttribute("inventoriesData", inventory.getData());
                    request.getRequestDispatcher("/src/pages/product-form.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("errorMessage", "Inventory type not found");
                    request.getRequestDispatcher("/src/pages/product-list.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        if ("add_new".equalsIgnoreCase(action)) {
            try {
                List<InventoryTypeResponse> inventoryType = InventoryDao.getInstance().getAllInventoryType();
                List<AuthorDataResponse> authorDataResponses = AuthorDao.getInstance().getAllAuthorList();
                request.setAttribute("inventoryTypes", inventoryType);
                request.setAttribute("authorList", authorDataResponses);
                request.getRequestDispatcher("/src/pages/product-form.jsp").forward(request, response);
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
                inventoryList = InventoryDao.getInstance().getAllInventoryPaginate(pageSize, offset);

                int totalRecords = inventoryList.getTotalCount();
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                request.setAttribute("inventoryList", inventoryList.getData());
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("totalRecords", totalRecords);

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.getRequestDispatcher("/src/pages/product-list.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        StringBuilder jsonBuffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuffer.append(line);
        }

        String action = request.getParameter("action");
        JSONObject json = new JSONObject(jsonBuffer.toString());

        String productImagePath = "";
        String productId = json.getString("productId");
        String priceListId = json.getString("priceListId");
        String barcode = json.getString("barcode");
        String itemName = json.getString("itemName");
        String inventoryTypeId = json.getString("inventoryTypeId");
        String author = json.getString("authorId") == "" ? null : json.getString("authorId");
        String isbnNo = json.getString("isbnNo");
        String retailPrice = json.getString("retailPrice");
        String costPrice = json.getString("costPrice");
        String qtyHand = json.getString("qtyHand");
        String base64DataUrl = json.getString("productImage");

        if (!base64DataUrl.equals("") && base64DataUrl != null || !base64DataUrl.isEmpty()) {
            String base64Image = base64DataUrl.split(",")[1]; // remove data:image/... prefix
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);
            productImagePath= FileUploads.handleImageUpload(request, imageBytes, UPLOAD_DIR);
        }


        Integer authorId = null;
        if (author != null && !JSONObject.NULL.equals(author)) {
            authorId = Integer.valueOf(author);
        }


        InventoryRequest invRequest = new InventoryRequest();
        invRequest.setName(itemName);
        invRequest.setBarcode(barcode);
        invRequest.setInventoryTypeId(CommonUtil.checkIntValue(inventoryTypeId, 0));
        invRequest.setAuthorId(authorId);
        invRequest.setIsbnNo(isbnNo);
        invRequest.setRetailPrice(CommonUtil.checkDoubleValue(retailPrice, 0));
        invRequest.setCostPrice(CommonUtil.checkDoubleValue(costPrice, 0));
        invRequest.setQtyHand(CommonUtil.checkIntValue(qtyHand, 0));
        invRequest.setDefaultImage(productImagePath);


        if ("delete".equalsIgnoreCase(action)) {
            doDelete(request, response);
        } else {
            try {
                CommonResponse<String> inventoryData;
                if (productId != null && !productId.isEmpty()) {
                    int id = Integer.parseInt(productId);
                    int priceId = Integer.parseInt(priceListId);
                    invRequest.setId(id);
                    invRequest.setPriceListId(priceId);
                    inventoryData = InventoryDao.getInstance().updateInventory(invRequest);
                } else {
                    CommonResponse<String> isBarcodeExist = InventoryDao.getInstance().isBarcodeExists(barcode);
                    CommonResponse<String> isbnNoExists = InventoryDao.getInstance().isIsbnNoExists(barcode);
                    if (isBarcodeExist.getCode() == 409) {
                        inventoryData = isBarcodeExist;
                    } else if (isbnNoExists.getCode() == 409) {
                        inventoryData = isbnNoExists;
                    }else {
                        inventoryData = InventoryDao.getInstance().createInventory(invRequest);
                    }
                }

                String jsonResponse = CommonResponseUtil.getJsonResponse(inventoryData);
                out.write(jsonResponse);
                out.flush();
                out.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        try {
            String id = request.getParameter("id");
            String barcode = request.getParameter("barcode");
            String itemName = request.getParameter("itemName");
            int inventoryTypeId = CommonUtil.checkIntValue(request.getParameter("inventoryTypeId"), 0);
            int authorId = CommonUtil.checkIntValue(request.getParameter("authorId"), 0);
            String isbnNo = request.getParameter("isbnNo");
            double retailPrice = CommonUtil.checkDoubleValue(request.getParameter("retailPrice"), 0);
            double costPrice =  CommonUtil.checkDoubleValue(request.getParameter("costPrice"),0);
            int qtyHand =  CommonUtil.checkIntValue(request.getParameter("qtyHand"), 0);

            String imagePath = null;
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                imagePath = FileUploads.handleFileUpload(request, filePart, UPLOAD_DIR);
            }
            CommonResponse<InventoryTypeResponse> inventoryTypeByIdData = InventoryDao.getInstance().getInventoryTypeById(inventoryTypeId);

            InventoryRequest invRequest = new InventoryRequest();
            invRequest.setId(Integer.parseInt(id));
            invRequest.setBarcode(barcode);
            invRequest.setInventoryTypeId(inventoryTypeId);
            invRequest.setAuthorId(authorId);
            invRequest.setIsbnNo(isbnNo);
            invRequest.setRetailPrice(retailPrice);
            invRequest.setCostPrice(costPrice);
            invRequest.setQtyHand(qtyHand);
            invRequest.setDefaultImage(imagePath);
            invRequest.setName(itemName);

            CommonResponse<String> result = InventoryDao.getInstance().updateInventory(invRequest);
            out.print(mapper.writeValueAsString(result));

        } catch (Exception e) {
            CommonResponse<String> error = new CommonResponse<>(
                    500,
                    "Error: " + e.getMessage(),
                    null
            );
            out.print(mapper.writeValueAsString(error));
            e.printStackTrace();
        }
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String jsonResponse = "";
        JSONObject json =  CommonUtil.getJsonData(request);

        String inventoryId =json.getString("inventoryId");

        try {
            int id = Integer.parseInt(inventoryId);
            CommonResponse<String> deleteResponse = InventoryDao.getInstance().deleteInventory(id);
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

    public void destroy() {}
}
