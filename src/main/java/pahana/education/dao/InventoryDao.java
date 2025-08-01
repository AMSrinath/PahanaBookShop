package pahana.education.dao;

import pahana.education.model.request.inventory.InventoryTypeRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.user.UserDataResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;

import java.sql.*;

public class InventoryDao {
    private static InventoryDao instance;

    private InventoryDao() {}

    public static synchronized  InventoryDao getInstance() throws SQLException {
        if (instance == null ) {
            instance = new InventoryDao();
        }
        return instance;
    }

    public CommonResponse<UserDataResponse> createInventoryType(InventoryTypeRequest inventoryType) throws SQLException {
        int statusCode = 0;
        String message = "";
        UserDataResponse data = null;
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

        return new CommonResponse<>(statusCode, message, data);
    }
}
