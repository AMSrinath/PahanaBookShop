package pahana.education.util.mappers;

import pahana.education.model.response.UserRoleResponse;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRoleMapper {
    public static UserRoleResponse userRoleResponse(ResultSet rs) throws SQLException {
        return new UserRoleResponse(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("title")
        );
    }
}
