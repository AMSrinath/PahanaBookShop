package pahana.education.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.ServletException;
import pahana.education.model.request.InventoryRequest;
import pahana.education.model.request.UserRequest;
import pahana.education.model.request.LoginRequest;
import pahana.education.model.response.*;
import pahana.education.util.DBConnection;
import pahana.education.util.JwtUtil;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.InventoryMapper;
import pahana.education.util.mappers.InventoryTypeMapper;
import pahana.education.util.mappers.UserMapper;
import pahana.education.util.mappers.UserRoleMapper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

        try {
            String sql1 = "SELECT usr.id as user_id, usr.first_name AS fName, usr.last_name AS lName,usr.password, " +
                    "rl.id as role_id, rl.name as role_name, rl.title as role_title " +
                    "FROM user usr INNER JOIN user_role ur ON usr.id = ur.user_id " +
                    "INNER JOIN role rl on ur.role_id = rl.id " +
                    "WHERE usr.email=?";

            String sql ="SELECT u.id as user_id, u.first_name, u.last_name, u.user_name, u.title, \n" +
                    "u.date_of_birth, u.phone_no, u.email, u.gender, u.account_no, u.user_image_path, u.is_deleted, u.password, \n" +
                    "u.address, r.name as role_name, r.title as role_title, r.id as role_id FROM user u \n" +
                    "left join user_role ur on  u.id = ur.user_id\n" +
                    "left join role r on r.id = ur.role_id\n" +
                    "where u.is_deleted = 0 and u.email=?";
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginRequest.getEmail());
            ResultSet rs = stmt.executeQuery();

            if (!rs.next()) {
                data = null;
               statusCode = HttpStatusEnum.NOT_FOUND.getCode();
               message = "Email incorrect";
            } else {
                String hashedPassword = rs.getString("password");
                BCrypt.Result result = BCrypt.verifyer().verify(loginRequest.getPassword().toCharArray(), hashedPassword);

                if (!result.verified) {
                    data = null;
                    statusCode = HttpStatusEnum.UNAUTHORIZED.getCode();
                    message = "Invalid password";
                } else {
                    data = UserMapper.userDataResponse(rs);
                    statusCode = HttpStatusEnum.OK.getCode();
                    message = "Login successful";
                }
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

    public CommonResponse<UserDataResponse> getUserById(int id) throws SQLException {
        int statusCode = 0;
        String message = "";
        UserDataResponse data = null;

        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT u.id as user_id, u.first_name, u.last_name, u.user_name, u.title, \n" +
                "u.date_of_birth, u.phone_no, u.email, u.gender, u.account_no, u.user_image_path, u.is_deleted, \n" +
                "u.address, r.name as role_name, r.title as role_title, r.id as role_id FROM user u \n" +
                "left join user_role ur on  u.id = ur.user_id\n" +
                "left join role r on r.id = ur.role_id\n" +
                "where u.is_deleted = 0 and u.id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            data = UserMapper.userDataResponse(rs);
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public List<UserRoleResponse> getAllUserRoles() throws SQLException {
        List<UserRoleResponse> userRoleList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM role where is_deleted = 0");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserRoleResponse mappedData = UserRoleMapper.userRoleResponse(rs);
                userRoleList.add(mappedData);
            }
            rs.close();
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return userRoleList;
    }

    public CommonResponse<List<UserDataResponse>> getAllUserPaginate(int limit, int offset) throws SQLException {
        int statusCode = 0;
        String message = "";
        int totalCount = 0;
        List<UserDataResponse> data = null;
        List<UserDataResponse> userDataList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement countStmt = conn.prepareStatement("SELECT count(u.id)  FROM user u \n" +
                    "left join user_role ur on  u.id = ur.user_id\n" +
                    "left join role r on r.id = ur.role_id\n" +
                    "where u.is_deleted = 0");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();


            PreparedStatement ps = conn.prepareStatement("SELECT u.id as user_id, u.first_name, u.last_name, u.user_name, u.title, \n" +
                    "u.date_of_birth, u.phone_no, u.email, u.gender, u.account_no, u.user_image_path, u.is_deleted, \n" +
                    "u.address, r.name as role_name, r.title as role_title, r.id as role_id FROM user u \n" +
                    "left join user_role ur on  u.id = ur.user_id\n" +
                    "left join role r on r.id = ur.role_id\n" +
                    "where u.is_deleted = 0 LIMIT ? OFFSET ? ");
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDataResponse  mappedData = UserMapper.userDataResponse(rs);
                userDataList.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Inventory type created successfully";
            data = userDataList;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating inventory type.";
        }

        return new CommonResponse<>(statusCode, message, data, totalCount);
    }

    public CommonResponse<String> createUser(UserRequest userRequest) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        try {
            conn.setAutoCommit(false);

            String invSql = "INSERT INTO user (first_name, last_name, date_of_birth, phone_no, gender, address,user_image_path,password,account_no,email,title)  " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement usrStmt = conn.prepareStatement(invSql, Statement.RETURN_GENERATED_KEYS);
            usrStmt.setString(1, userRequest.getFirstName());
            usrStmt.setString(2, userRequest.getLastName());
            if (userRequest.getDateOfBirth() != null) {
                usrStmt.setDate(3, java.sql.Date.valueOf(userRequest.getDateOfBirth()));
            } else {
                usrStmt.setNull(3, java.sql.Types.DATE);
            }
            usrStmt.setString(4, userRequest.getPhoneNo());
            usrStmt.setString(5, userRequest.getGender().toString());
            usrStmt.setString(6, userRequest.getAddress());
            usrStmt.setString(7, userRequest.getUserImagePath());

            String hashedPassword = BCrypt.withDefaults().hashToString(12, userRequest.getPassword().toCharArray());
            usrStmt.setString(8, hashedPassword);
            usrStmt.setString(9, userRequest.getAccountNo());
            usrStmt.setString(10, userRequest.getEmail());
            usrStmt.setString(11, userRequest.getTitle());
            int invRows = usrStmt.executeUpdate();

            if (invRows == 0) {
                throw new SQLException("User create failed, no rows affected.");
            }

            int userId;
            try (ResultSet generatedKeys = usrStmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("User create failed, no ID obtained.");
                }
            }

            String priceSql = " INSERT INTO user_role ( user_id, role_id) VALUES (?, ?)";
            PreparedStatement priceStmt = conn.prepareStatement(priceSql);
            priceStmt.setDouble(1, userId);
            priceStmt.setDouble(2, userRequest.getCustomerTypeId());
            priceStmt.executeUpdate();

            conn.commit();
            return new CommonResponse<>(200, "User create successfully", null);

        } catch (SQLException e) {
            try {
                conn.rollback(); // rollback only works if auto-commit is false
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error user create: " + e.getMessage(), null);
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

    public CommonResponse<String> updateUser(UserRequest userRequest) throws SQLException, ServletException {
        Connection conn = DBConnection.getInstance().getConnection();

        try{
            conn.setAutoCommit(false);
            String sql = "UPDATE user SET first_name = ?, last_name = ?, date_of_birth = ?, phone_no = ?, gender = ?, address = ?,user_image_path = ?," +
                    "account_no = ?,email = ?, title = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userRequest.getFirstName());
            ps.setString(2, userRequest.getLastName());
            ps.setDate(3, java.sql.Date.valueOf(userRequest.getDateOfBirth()));
            ps.setString(4, userRequest.getPhoneNo());
            ps.setString(5, userRequest.getGender().toString());
            ps.setString(6, userRequest.getAddress());
            ps.setString(7, userRequest.getUserImagePath());
            ps.setString(8, userRequest.getAccountNo());
            ps.setString(9, userRequest.getEmail());
            ps.setString(10, userRequest.getTitle());
            ps.setInt(11, userRequest.getUserId());
            ps.executeUpdate();

            String priceSql = "UPDATE user_role SET user_id =? , role_id = ? WHERE id = ?";
            PreparedStatement priceStmt = conn.prepareStatement(priceSql);
            priceStmt.setDouble(1, userRequest.getUserId());
            priceStmt.setDouble(2, userRequest.getCustomerTypeId());
            priceStmt.setDouble(3, userRequest.getUserRoleId());
            priceStmt.executeUpdate();

            conn.commit();
            return new CommonResponse<>(200, "User details updated", null);

        } catch (SQLException e) {
            try {
                conn.rollback(); // rollback only works if auto-commit is false
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error updating user details: " + e.getMessage(), null);
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

    public  CommonResponse<String> checkEmailExists(String email) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        String sql = "SELECT COUNT(*) FROM user WHERE email = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            return new CommonResponse<>(409, "Email already exists", null);
        }
        return new CommonResponse<>(200, "Email is available", null);
    }

    public CommonResponse<String> deleteUser(int id) throws SQLException {

        try{
            String sql = "UPDATE user SET is_deleted = 1 WHERE id = ?";
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                return new CommonResponse<>(200, "User deleted successfully", null);
            } else {
                return new CommonResponse<>(404, "User not found", null);
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
