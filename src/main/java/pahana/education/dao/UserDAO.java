package pahana.education.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import pahana.education.model.request.UserRequest;
import pahana.education.model.request.LoginRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;

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

    public CommonResponse<UserRequest> login(LoginRequest loginRequest) throws SQLException {
        int statusCode = 0;
        String message = "";
        UserRequest data = null;
        CommonResponse<UserRequest> response = null;

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT user.* FROM user  WHERE user.email=?");

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
                UserRequest userRequest = new UserRequest();
                userRequest.setId(rs.getInt("id"));
                userRequest.setUserName(rs.getString("user_name"));
                userRequest.setEmail(rs.getString("email"));
                data = userRequest;
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
