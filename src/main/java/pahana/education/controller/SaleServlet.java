package pahana.education.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.json.JSONArray;
import org.json.JSONObject;
import pahana.education.dao.AuthorDao;
import pahana.education.dao.InventoryDao;
import pahana.education.dao.SaleDao;
import pahana.education.dao.UserDAO;
import pahana.education.model.request.InventoryRequest;
import pahana.education.model.request.SaleItemRequest;
import pahana.education.model.request.SaleRequest;
import pahana.education.model.response.*;
import pahana.education.util.CommonResponseUtil;
import pahana.education.util.CommonUtil;
import pahana.education.util.FileUploads;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "saleServlet", value = "/sale")
public class SaleServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        PrintWriter out = response.getWriter();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject json =  CommonUtil.getJsonData(request);

        String action = request.getParameter("action");

        if ("search_products".equalsIgnoreCase(action)) {
            String keyword = json.getString("keywords");
            try {
                CommonResponse<List<InventoryResponse>> inventoryList = SaleDao.getInstance().getAllInventory(keyword);
                String jsonResponse = CommonResponseUtil.getJsonResponse(inventoryList);
                out.write(jsonResponse);
                out.flush();
                out.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if ("search_customers".equalsIgnoreCase(action)) {
            String keyword = json.getString("keywords");
            try {
                CommonResponse<List<UserDataResponse>> customerList = SaleDao.getInstance().getAllCustomers(keyword);
                String jsonResponse = CommonResponseUtil.getJsonResponse(customerList);
                out.write(jsonResponse);
                out.flush();
                out.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if ("complete_sale".equalsIgnoreCase(action)) {
            int cashierId = json.getInt("cashierId");
            int customerId = json.getInt("customerId");
            int cashReceived = json.getInt("cashReceived");
            int totalNet = json.getInt("total");
            int taxAmount = json.getInt("taxAmount");
            JSONArray itemsArray = json.getJSONArray("saleItems");

            List<SaleItemRequest> itemList = new ArrayList<>();

            for (int i = 0; i < itemsArray.length(); i++) {
                JSONObject itemJson = itemsArray.getJSONObject(i);

                SaleItemRequest item = new SaleItemRequest();
                item.setProductId(itemJson.getInt("productId"));
                item.setRetailPrice(itemJson.getInt("price"));
                item.setQty(itemJson.getInt("qty"));
                item.setTotal(itemJson.getInt("total"));
                item.setCostPrice(itemJson.getInt("costPrice"));
                item.setPriceListId(itemJson.getInt("priceListId"));

                itemList.add(item);
            }

//            double totalNet = CommonUtil.checkDoubleValue(total,0);
//            double tax = CommonUtil.checkDoubleValue(taxAmount,0);
            SaleRequest saleRequest = new SaleRequest();
            saleRequest.setCashierId(cashierId);
            saleRequest.setCustomerId(customerId);
            saleRequest.setCashReceived(cashReceived);
            saleRequest.setTotalGross(totalNet - taxAmount);
            saleRequest.setTotalNet(totalNet);
            saleRequest.setTaxAmount(taxAmount);
            saleRequest.setSaleItems(itemList);

            try {
                CommonResponse<String> saleData = SaleDao.getInstance().createSale(saleRequest);
                String jsonResponse = CommonResponseUtil.getJsonResponse(saleData);
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

            boolean isBarcodeExist = InventoryDao.getInstance().isBarcodeExists(barcode);
            boolean isbnNoExists = InventoryDao.getInstance().isIsbnNoExists(barcode);
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
