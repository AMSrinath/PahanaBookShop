package pahana.education.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import pahana.education.model.request.SaleItemRequest;
import pahana.education.model.request.SaleRequest;
import pahana.education.model.request.UserRequest;
import pahana.education.model.response.AuthorDataResponse;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryResponse;
import pahana.education.model.response.UserDataResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.AuthorMapper;
import pahana.education.util.mappers.InventoryMapper;
import pahana.education.util.mappers.UserMapper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SaleDao {
    private static SaleDao instance;

    private SaleDao() {}

    public static synchronized  SaleDao getInstance() throws SQLException {
        if (instance == null ) {
            instance = new SaleDao();
        }
        return instance;
    }

    public CommonResponse<List<InventoryResponse>> getAllInventory(String keyWord) throws SQLException {
        int statusCode = 0;
        String message = "";
        List<InventoryResponse> data = null;
        List<InventoryResponse> inventoryList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT i.id, i.barcode, i.default_image, " +
                    "i.inventory_type as inventory_type_id, it.name as inventory_type,i.name, \n" +
                    "it.name as inventory_type_name, i.author_id, a.first_name,\n" +
                    "a.last_name, i.isbn_no, pl.cost_price, pl.retail_price, pl.qty_hand, i.is_deleted,pl.id as price_list_id   FROM inventory i\n" +
                    "left join inventory_type it ON i.inventory_type = it.id \n" +
                    "left join author a on i.author_id = a.id\n" +
                    "left join price_list pl on pl.inventory_id = i.id \n" +
                    " WHERE i.is_deleted = 0 AND i.barcode like ? OR i.name like ?");;

            ps.setString(1, "%" + keyWord + "%");
            ps.setString(2, "%" + keyWord + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                InventoryResponse  mappedData = InventoryMapper.inventoryResponse(rs);
                inventoryList.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Inventory data fetch successfully";
            data = inventoryList;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public CommonResponse<List<UserDataResponse>> getAllCustomers(String keyWord) throws SQLException {
        int statusCode = 0;
        String message = "";
        int totalCount = 0;
        List<UserDataResponse> data = null;
        List<UserDataResponse> userDataResponsesList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT u.id as user_id, u.first_name, u.last_name, u.user_name, u.title, \n" +
                    "u.date_of_birth, u.phone_no, u.email, u.gender, u.account_no, u.user_image_path, u.is_deleted, \n" +
                    "u.address, r.name as role_name, r.title as role_title, r.id as role_id FROM user u \n" +
                    "left join user_role ur on  u.id = ur.user_id \n" +
                    "left join role r on r.id = ur.role_id \n" +
                    "where u.is_deleted = 0 AND r.name = 'customer' AND (u.account_no like ? OR u.first_name like ?)");

            ps.setString(1, "%" + keyWord + "%");
            ps.setString(2, "%" + keyWord + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDataResponse mappedData = UserMapper.userDataResponse(rs);
                userDataResponsesList.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Customer data fetch successfully";
            data = userDataResponsesList;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public CommonResponse<String> createSale(SaleRequest saleRequest) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        try {
            conn.setAutoCommit(false);

            String invSql = "INSERT INTO sales_invoice (invoice_total_gross, invoice_total_net, customer_id, cashier_id, tax_amount,invoice_no) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement invStmt = conn.prepareStatement(invSql, Statement.RETURN_GENERATED_KEYS);
            invStmt.setDouble(1, saleRequest.getTotalGross());
            invStmt.setDouble(2, saleRequest.getTotalNet());
            invStmt.setInt(3, saleRequest.getCustomerId());
            invStmt.setInt(4, saleRequest.getCashierId());
            invStmt.setDouble(5, saleRequest.getTaxAmount());
            invStmt.setString(6, saleRequest.getInvoiceNo());

            int getProductRows = invStmt.executeUpdate();

            if (getProductRows == 0) {
                throw new SQLException("User create failed, no rows affected.");
            }

            int invoiceId;
            try (ResultSet generatedKeys = invStmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    invoiceId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("User create failed, no ID obtained.");
                }
            }

            List<SaleItemRequest> saleItemRequests = saleRequest.getSaleItems();

            for (SaleItemRequest item : saleItemRequests) {
                String itemSql = "INSERT INTO sales_invoice_detail (sales_invoice_id, inventory_id, quantity, unit_sell_price, unit_cost_price, total_sell_price, total_cost_price, price_list_id) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                itemStmt.setInt(1, invoiceId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setDouble(3, item.getQty());
                itemStmt.setDouble(4, item.getRetailPrice());
                itemStmt.setDouble(5, item.getCostPrice());
                itemStmt.setDouble(6,item.getQty() * item.getRetailPrice());
                itemStmt.setInt(7,item.getQty() * item.getCostPrice());
                itemStmt.setInt(8, item.getPriceListId());
                itemStmt.executeUpdate();

                // Update the quantity in the price_list table
                String updateQtySql = "UPDATE price_list SET qty_hand = qty_hand - ? WHERE id = ?";
                PreparedStatement updateQtyStmt = conn.prepareStatement(updateQtySql);
                updateQtyStmt.setDouble(1, item.getQty());
                updateQtyStmt.setInt(2, item.getPriceListId());
                updateQtyStmt.executeUpdate();
            }

            conn.commit();
            return new CommonResponse<>(200, "Sale create successfully", null);

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error user sale: " + e.getMessage(), null);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }


}
