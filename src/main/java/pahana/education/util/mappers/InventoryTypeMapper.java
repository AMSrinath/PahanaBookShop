package pahana.education.util.mappers;

import pahana.education.model.response.inventory.InventoryTypeResponse;

import java.sql.ResultSet;
import java.sql.SQLException;

public class InventoryTypeMapper {
    public static InventoryTypeResponse inventoryTypeResponse(ResultSet resultSet) throws SQLException {
        return new InventoryTypeResponse(
                resultSet.getInt("id"),
                resultSet.getString("name"),
                resultSet.getBoolean("is_deleted"));
    }
}
