package pahana.education.util.mappers;

import pahana.education.model.response.InventoryResponse;
import pahana.education.model.response.InventoryTypeResponse;

import java.sql.ResultSet;
import java.sql.SQLException;

public class InventoryMapper {
    public static InventoryResponse inventoryResponse(ResultSet resultSet) throws SQLException {
        String fullName = resultSet.getString("first_name") + " " + resultSet.getString("last_name");
        return new InventoryResponse(
                resultSet.getInt("id"),
                resultSet.getString("barcode"),
                resultSet.getString("name"),
                resultSet.getBoolean("is_deleted"),
                resultSet.getString("default_image"),
                resultSet.getInt("inventory_type_id"),
                resultSet.getString("inventory_type"),
                resultSet.getInt("author_id"),
                fullName,
                resultSet.getString("isbn_no"),
                resultSet.getDouble("retail_price"),
                resultSet.getDouble("cost_price"),
                resultSet.getInt("qty_hand"),
                resultSet.getInt("price_list_id")
        );
    }
}
