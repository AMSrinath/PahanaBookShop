package pahana.education.util.mappers;

import pahana.education.model.response.AuthorDataResponse;
import pahana.education.util.enums.Gender;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthorMapper {
    public static AuthorDataResponse authorDataResponse(ResultSet resultSet) throws SQLException {
        return new AuthorDataResponse(
//               LocalDate dob = resultSet.getDate("date_of_birth").toLocalDate();
                resultSet.getString("first_name"),
                resultSet.getString("last_name"),
                resultSet.getString("date_of_birth"),
                resultSet.getString("phone_no"),
                Gender.valueOf(resultSet.getString("gender").toUpperCase()),
                resultSet.getString("email")
        );
    }
}
