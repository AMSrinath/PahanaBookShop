package pahana.education.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import pahana.education.model.request.UserRequest;
import pahana.education.model.request.LoginRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.model.response.UserDataResponse;
import pahana.education.model.response.UserRoleResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.JwtUtil;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.InventoryTypeMapper;
import pahana.education.util.mappers.UserMapper;
import pahana.education.util.mappers.UserRoleMapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
            String sql = "SELECT usr.id as user_id, usr.first_name AS fName, usr.last_name AS lName,usr.password, " +
                    "rl.id as role_id, rl.name as role_name, rl.title as role_title " +
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
            } else {
                String hashedPassword = rs.getString("password");
                BCrypt.Result result = BCrypt.verifyer().verify(loginRequest.getPassword().toCharArray(), hashedPassword);

                if (!result.verified) {
                    statusCode = HttpStatusEnum.UNAUTHORIZED.getCode();
                    message = "Invalid password";
                } else {
                    data = UserMapper.userDataResponse(rs);
                    String token = JwtUtil.generateToken(data);

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

    public CommonResponse<List<UserDataResponse>> getAllCustomerPaginate(int limit, int offset) throws SQLException {
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
                    "where u.is_deleted = 0 and r.name = 'customer'");
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
                    "where u.is_deleted = 0 and r.name ='customer' LIMIT ? OFFSET ? ");
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

    public CommonResponse<List<UserDataResponse>> getAllStaffPaginate(int limit, int offset) throws SQLException {
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
                    "where u.is_deleted = 0 and r.name = `customer`");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();


            PreparedStatement ps = conn.prepareStatement("SELECT u.id as user_id, u.first_name, u.last_name, \n" +
                    "u.date_of_birth, u.phone_no, u.email, u.gender, u.account_no, u.user_image_path, u.is_deleted, \n" +
                    "u.address, r.name as role_name, r.id as role_id FROM user u \n" +
                    "left join user_role ur on  u.id = ur.user_id\n" +
                    "left join role r on r.id = ur.role_id\n" +
                    "where u.is_deleted = 0 and r.name =`customer` LIMIT ? OFFSET ? ");
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



}
