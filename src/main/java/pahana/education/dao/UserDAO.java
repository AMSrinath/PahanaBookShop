package pahana.education.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import pahana.education.model.request.UserRequest;
import pahana.education.model.request.LoginRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.UserDataResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.UserMapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private static UserDAO instance;

    private UserDAO() {}

    public static synchronized  UserDAO getInstance() throws SQLException {
        if (instance == null ) {
            instance = new UserDAO();
        }
        return instance;
    }

    public CommonResponse<UserDataResponse> login(LoginRequest loginRequest) throws SQLException {
        int statusCode = 0;
        String message = "";
        UserDataResponse data = null;
        CommonResponse<UserDataResponse> response = null;

        try {
            String sql = "SELECT usr.id, usr.first_name AS fName, usr.last_name AS lName, rl.id as roleId, rl.name as roleName, rl.title as roleTitle " +
                    "FROM user usr INNER JOIN user_role ur ON usr.id = ur.user_id " +
                    "INNER JOIN role rl on ur.role_id = rl.id " +
                    "WHERE usr.email=?";
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginRequest.getEmail());
            ResultSet rs = stmt.executeQuery();

            if (!rs.next()) {
               statusCode = HttpStatusEnum.NOT_FOUND.getCode();
               message = "Email does not exist";
            }

            String hashedPassword = rs.getString("password");
            BCrypt.Result result = BCrypt.verifyer().verify(loginRequest.getPassword().toCharArray(), hashedPassword);
            if (result.verified) {
                statusCode = HttpStatusEnum.OK.getCode();
                message = "Login successful";
                data = UserMapper.userDataResponse(rs);
            } else {
                statusCode = HttpStatusEnum.UNAUTHORIZED.getCode();
                message = "Invalid password";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public boolean registerUser(UserRequest userRequest) {
        boolean isSuccess = false;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "INSERT INTO user (user_name, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            String pwd = "123";
            String hashedPassword = BCrypt.withDefaults().hashToString(12, pwd.toCharArray());

            stmt.setString(1, userRequest.getUserName());
            stmt.setString(2, userRequest.getEmail());
            stmt.setString(3, hashedPassword);

            int rowsInserted = stmt.executeUpdate();
            isSuccess = rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

}
