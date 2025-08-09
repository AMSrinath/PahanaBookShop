package pahana.education.dao;

import jakarta.servlet.ServletException;
import pahana.education.model.request.inventory.InventoryTypeRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.inventory.InventoryTypeResponse;
import pahana.education.model.response.user.UserDataResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.InventoryTypeMapper;
import pahana.education.util.mappers.UserMapper;

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
            }
        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, null);
    }


    public CommonResponse<List<InventoryTypeResponse>> getAllInventoryTypes(int limit, int offset) throws SQLException {
        int statusCode = 0;
        String message = "";
        int totalCount = 0;
        List<InventoryTypeResponse> data = null;
        List<InventoryTypeResponse> inventoryTypes = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM inventory_type");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();


            PreparedStatement ps = conn.prepareStatement("SELECT * FROM inventory_type LIMIT ? OFFSET ?");
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
//            String sql = "DELETE FROM inventory_type WHERE id = ?";
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
}
