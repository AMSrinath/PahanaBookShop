package pahana.education.util.mappers;

import pahana.education.model.request.UserRequest;
import pahana.education.model.response.UserDataResponse;
import pahana.education.model.response.UserRoleResponse;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserMapper {
    public static UserDataResponse userDataResponse(ResultSet rs) throws SQLException {
        UserRoleResponse userRole = new UserRoleResponse(
                rs.getInt("roleId"),
                rs.getString("roleName"),
                rs.getString("roleTitle")
        );

        return new UserDataResponse(
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getDate("date_of_birth").toLocalDate(),
                rs.getString("phone_no"),
                UserRequest.Gender.valueOf(rs.getString("gender").toUpperCase()),
                rs.getString("address"),
                rs.getString("user_image_path"),
                rs.getString("account_no"),
                rs.getString("email"),
                rs.getString("user_name"),
                rs.getString("title"),
                userRole
        );
    }
}
