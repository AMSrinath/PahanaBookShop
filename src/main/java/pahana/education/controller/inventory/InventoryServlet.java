package pahana.education.controller.inventory;

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
import pahana.education.util.CommonUtil;
import pahana.education.util.FileUploads;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "inventoryServlet", value = "/inventory")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class InventoryServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "/src/assets/images/uploads";
    private List<String> inventoryTypes;
    public void init() {
        inventoryTypes = List.of("Electronics", "Furniture", "Books", "Clothing", "Toys");
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
                    request.getRequestDispatcher("/src/pages/inventory-form.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Inventory type not found");
                    request.getRequestDispatcher("/src/pages/inventory-list.jsp").forward(request, response);
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
                List<InventoryTypeResponse> inventoryType = InventoryDao.getInstance().getAllInventoryType();
                List<AuthorDataResponse> authorDataResponses = AuthorDao.getInstance().getAllAuthorList();
                request.setAttribute("inventoryTypes", inventoryType);
                request.setAttribute("authorList", authorDataResponses);
                request.getRequestDispatcher("/src/pages/product-form.jsp").forward(request, response);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HashMap<String, String> errors = new HashMap<>();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        try {
            String barcode = request.getParameter("barcode");
            String itemName = request.getParameter("itemName");
            int inventoryTypeId = CommonUtil.checkIntValue(request.getParameter("inventoryType"), 0);
            int authorId = CommonUtil.checkIntValue(request.getParameter("author"), 0);
            String isbnNo = request.getParameter("isbnNo");
            double retailPrice = CommonUtil.checkDoubleValue(request.getParameter("retailPrice"), 0);
            double costPrice =  CommonUtil.checkDoubleValue(request.getParameter("costPrice"),0);
            int qtyHand =  CommonUtil.checkIntValue(request.getParameter("qtyHand"), 0);

            // Handle file upload
            String imagePath = null;
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                imagePath = FileUploads.handleFileUpload(request, filePart, UPLOAD_DIR);
            }


            boolean isBarcodeExist = InventoryDao.getInstance().isBarcodeExists(barcode);

            boolean isbnNoExists = InventoryDao.getInstance().isIsbnNoExists(barcode);

            CommonResponse<InventoryTypeResponse> inventoryTypeByIdData = InventoryDao.getInstance().getInventoryTypeById(inventoryTypeId);

            String inventoryTypes = inventoryTypeByIdData.getData().getName().toUpperCase();


//            if (barcode == null || barcode.trim().isEmpty()) {
//                errors.put("barcode", "Barcode is required");
//            } else if (isBarcodeExist) {
//                errors.put("barcode", "Barcode already exists");
//            } else if(inventoryTypeId == 0 ) {
//                errors.put("inventoryType", "Inventory type is required");
//            } else if(inventoryTypes == "NOVELS" &&  ) {
//
//            }

            // Create request object
            InventoryRequest invRequest = new InventoryRequest();
            invRequest.setBarcode(barcode);
            invRequest.setInventoryType(inventoryTypeId);
            invRequest.setAuthorId(authorId);
            invRequest.setIsbnNo(isbnNo);
            invRequest.setRetailPrice(retailPrice);
            invRequest.setCostPrice(costPrice);
            invRequest.setQtyHand(qtyHand);
            invRequest.setDefaultImage(imagePath);
            invRequest.setName(itemName);

            CommonResponse<String> result = InventoryDao.getInstance().createInventory(invRequest);

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

    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void destroy() {}
}
