package pahana.education.dao;

import jakarta.servlet.ServletException;
import pahana.education.model.request.InventoryRequest;
import pahana.education.model.request.InventoryTypeRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.model.response.UserDataResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.InventoryMapper;
import pahana.education.util.mappers.InventoryTypeMapper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryDao {
    private static InventoryDao instance;

    private InventoryDao() {}

    public static synchronized  InventoryDao getInstance() throws SQLException {
        if (instance == null ) {
            instance = new InventoryDao();
        }
        return instance;
    }

    /** Inventory Type Business Process*/
    public CommonResponse<String> createInventoryType(InventoryTypeRequest inventoryType) throws SQLException {
        int statusCode = 0;
        String message = "";
        CommonResponse<UserDataResponse> response = null;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "INSERT INTO inventory_type (name) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, inventoryType.getName());
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet keys = stmt.getGeneratedKeys();
                if (keys.next()) {
                    statusCode = HttpStatusEnum.OK.getCode();
                    message = "Inventory type created successfully";
                }
            } else {
                return new CommonResponse<>(400, "Inventory type not create,", null);
            }
        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, null);
    }

    public CommonResponse<List<InventoryTypeResponse>> getAllInventoryTypesPaginate(int limit, int offset) throws SQLException {
        int statusCode = 0;
        String message = "";
        int totalCount = 0;
        List<InventoryTypeResponse> data = null;
        List<InventoryTypeResponse> inventoryTypes = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM inventory_type where is_deleted = 0");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();


            PreparedStatement ps = conn.prepareStatement("SELECT * FROM inventory_type where is_deleted = 0 LIMIT ? OFFSET ? ");
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                InventoryTypeResponse  mappedData = InventoryTypeMapper.inventoryTypeResponse(rs);
                inventoryTypes.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Inventory type created successfully";
            data = inventoryTypes;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, data, totalCount);
    }

    public CommonResponse<InventoryTypeResponse> getInventoryTypeById(int id) throws SQLException {
        int statusCode = 0;
        String message = "";
        InventoryTypeResponse data = null;

        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM inventory_type WHERE id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            data = InventoryTypeMapper.inventoryTypeResponse(rs);
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public CommonResponse<String> updateInventoryType(InventoryTypeRequest request) throws SQLException, ServletException {
        try{
            String sql = "UPDATE inventory_type SET name = ? WHERE id = ?";
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, request.getName());
            ps.setInt(2, request.getId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                return new CommonResponse<>(200, "Update successful", null);
            } else {
                return new CommonResponse<>(400, "Update failed", null);
            }
        } catch (Exception e) {
            throw new ServletException("Invalid ID format.");
        }
    }

    public CommonResponse<String> deleteInventoryType(int id) throws SQLException {

        try{
            String sql = "UPDATE inventory_type SET is_deleted = 1 WHERE id = ?";
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                return new CommonResponse<>(200, "Inventory type deleted successfully", null);
            } else {
                return new CommonResponse<>(404, "Inventory type not found", null);
            }
        } catch (SQLException e) {
            return new CommonResponse<>(
                    500,
                    "Database error: " + e.getMessage(),
                    null
            );
        }
    }

    public List<InventoryTypeResponse> getAllInventoryType() throws SQLException {
        List<InventoryTypeResponse> inventoryTypes = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM inventory_type where is_deleted = 0");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                InventoryTypeResponse mappedData = InventoryTypeMapper.inventoryTypeResponse(rs);
                inventoryTypes.add(mappedData);
            }
            rs.close();
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return inventoryTypes;
    }


    /***************************************************************************************************/
    /** Inventory Business Process */
    public List<InventoryResponse> getAllInventory() throws SQLException {
        List<InventoryResponse> inventory = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT i.id, i.barcode, i.default_image, i.inventory_type,i.name, \n" +
                    "it.name as inventory_type_name, i.author_id, a.first_name,\n" +
                    "a.last_name, i.isbn_no, pl.cost_price, pl.retail_price, pl.qty_hand  FROM inventory i\n" +
                    "left join inventory_type it ON i.inventory_type = it.id \n" +
                    "left join author a on i.author_id = a.id\n" +
                    "left join price_list pl on pl.inventory_id = i.id \n" +
                    "where i.is_deleted = 0");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                InventoryResponse mappedData = InventoryMapper.inventoryResponse(rs);
                inventory.add(mappedData);
            }
            rs.close();
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return inventory;
    }

    public CommonResponse<InventoryResponse> getInventoryById(int id) throws SQLException {
        int statusCode = 0;
        String message = "";
        InventoryResponse data = null;

        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT i.id, i.barcode, i.default_image, " +
                "i.inventory_type as inventory_type_id, it.name as inventory_type,i.name, \n" +
                "it.name as inventory_type_name, i.author_id, a.first_name,\n" +
                "a.last_name, i.isbn_no, pl.cost_price, pl.retail_price, pl.qty_hand, i.is_deleted, pl.id as price_list_id  FROM inventory i\n" +
                "left join inventory_type it ON i.inventory_type = it.id \n" +
                "left join author a on i.author_id = a.id\n" +
                "left join price_list pl on pl.inventory_id = i.id \n" +
                " WHERE i.is_deleted = 0 and i.id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            data = InventoryMapper.inventoryResponse(rs);
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public CommonResponse<List<InventoryResponse>> getAllInventoryPaginate(int limit, int offset) throws SQLException {
        int statusCode = 0;
        String message = "";
        int totalCount = 0;
        List<InventoryResponse> data = null;
        List<InventoryResponse> inventoryList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM inventory where is_deleted = 0");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();


            PreparedStatement ps = conn.prepareStatement("SELECT i.id, i.barcode, i.default_image, " +
                    "i.inventory_type as inventory_type_id, it.name as inventory_type,i.name, \n" +
                    "it.name as inventory_type_name, i.author_id, a.first_name,\n" +
                    "a.last_name, i.isbn_no, pl.cost_price, pl.retail_price, pl.qty_hand, i.is_deleted,pl.id as price_list_id   FROM inventory i\n" +
                    "left join inventory_type it ON i.inventory_type = it.id \n" +
                    "left join author a on i.author_id = a.id\n" +
                    "left join price_list pl on pl.inventory_id = i.id \n" +
                    " WHERE i.is_deleted = 0 LIMIT ? OFFSET ?");
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                InventoryResponse  mappedData = InventoryMapper.inventoryResponse(rs);
                inventoryList.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Inventory type created successfully";
            data = inventoryList;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, data, totalCount);
    }

    public CommonResponse<String> createInventory(InventoryRequest inventoryRequest) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        try {
            conn.setAutoCommit(false);

            // Insert into inventory
            String invSql = "INSERT INTO inventory (barcode,name, default_image, inventory_type, author_id, isbn_no) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement invStmt = conn.prepareStatement(invSql, Statement.RETURN_GENERATED_KEYS);
            invStmt.setString(1, inventoryRequest.getBarcode());
            invStmt.setString(2, inventoryRequest.getName());
            invStmt.setString(3, inventoryRequest.getDefaultImage());
            invStmt.setInt(4, inventoryRequest.getInventoryTypeId());

            if (inventoryRequest.getAuthorId() != null) {
                invStmt.setInt(5, inventoryRequest.getAuthorId());
            } else {
                invStmt.setNull(5, Types.INTEGER);
            }
            invStmt.setString(6, inventoryRequest.getIsbnNo());

            int invRows = invStmt.executeUpdate();
            if (invRows == 0) {
                throw new SQLException("Creating inventory failed, no rows affected.");
            }

            int inventoryId;
            try (ResultSet generatedKeys = invStmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    inventoryId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating inventory failed, no ID obtained.");
                }
            }

            // Insert into price_list
            String priceSql = "INSERT INTO price_list (retail_price, cost_price, qty_hand, inventory_id) VALUES (?, ?, ?, ?)";
            PreparedStatement priceStmt = conn.prepareStatement(priceSql);
            priceStmt.setDouble(1, inventoryRequest.getRetailPrice());
            priceStmt.setDouble(2, inventoryRequest.getCostPrice());
            priceStmt.setInt(3, inventoryRequest.getQtyHand());
            priceStmt.setInt(4, inventoryId);

            priceStmt.executeUpdate();

            // Commit the transaction
            conn.commit();
            return new CommonResponse<>(200, "Product created successfully", null);

        } catch (SQLException e) {
            try {
                conn.rollback(); // rollback only works if auto-commit is false
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error creating product: " + e.getMessage(), null);
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

    public CommonResponse<String> deleteInventory(int id) throws SQLException {

        try{
            String sql = "UPDATE inventory SET is_deleted = 1 WHERE id = ?";
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                return new CommonResponse<>(200, "Inventory deleted successfully", null);
            } else {
                return new CommonResponse<>(404, "Inventory not found", null);
            }
        } catch (SQLException e) {
            return new CommonResponse<>(
                    500,
                    "Database error: " + e.getMessage(),
                    null
            );
        }
    }

    public CommonResponse<String> updateInventory(InventoryRequest request) throws SQLException, ServletException {
        Connection conn = DBConnection.getInstance().getConnection();

        try{
            conn.setAutoCommit(false);
            String sql = "UPDATE inventory SET barcode = ?, name = ?, default_image = ?, inventory_type = ?, author_id = ?, isbn_no = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, request.getBarcode());
            ps.setString(2, request.getName());
            ps.setString(3, request.getDefaultImage());
            ps.setInt(4, request.getInventoryTypeId());
            ps.setInt(5, request.getAuthorId());
            ps.setString(6, request.getIsbnNo());
            ps.setInt(7, request.getId());
            ps.executeUpdate();

            String priceSql = "UPDATE price_list SET retail_price = ? , cost_price = ?, qty_hand= ? WHERE id = ?";
            PreparedStatement priceStmt = conn.prepareStatement(priceSql);
            priceStmt.setDouble(1, request.getRetailPrice());
            priceStmt.setDouble(2, request.getCostPrice());
            priceStmt.setInt(3, request.getQtyHand());
            priceStmt.setInt(4, request.getPriceListId());
            priceStmt.executeUpdate();

            conn.commit();
            return new CommonResponse<>(200, "Product created successfully", null);

        } catch (SQLException e) {
            try {
                conn.rollback(); // rollback only works if auto-commit is false
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error creating product: " + e.getMessage(), null);
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

    public boolean isBarcodeExists(String barcode) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        String sql = "SELECT COUNT(*) FROM inventory WHERE barcode = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, barcode);
        ResultSet rs = ps.executeQuery();

        return rs.next() && rs.getInt(1) > 0;
    }

    public boolean isIsbnNoExists(String isbnNo) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        String sql = "SELECT COUNT(*) FROM inventory WHERE isbn_no = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, isbnNo);
        ResultSet rs = ps.executeQuery();

        return rs.next() && rs.getInt(1) > 0;
    }
}
