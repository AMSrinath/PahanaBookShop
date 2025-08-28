package pahana.education.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.ServletException;
import pahana.education.model.request.UserRequest;
import pahana.education.model.response.AuthorDataResponse;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.AuthorMapper;
import pahana.education.util.mappers.InventoryTypeMapper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuthorDao {
    private static AuthorDao instance;

    private AuthorDao() {}

    public static synchronized  AuthorDao getInstance() throws SQLException {
        if (instance == null ) {
            instance = new AuthorDao();
        }
        return instance;
    }


    public List<AuthorDataResponse> getAllAuthorList() throws SQLException {
        List<AuthorDataResponse> authorDataResponses = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM author where is_deleted = 0");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AuthorDataResponse mappedData = AuthorMapper.authorDataResponse(rs);
                authorDataResponses.add(mappedData);
            }
            rs.close();
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return authorDataResponses;
    }

    public CommonResponse<AuthorDataResponse> getAuthorById(int id) throws SQLException {
        int statusCode = 0;
        String message = "";
        AuthorDataResponse data = null;

        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT id, first_name, last_name, date_of_birth, " +
                "phone_no,gender,email, is_deleted, title FROM author where id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            data = AuthorMapper.authorDataResponse(rs);
        }

        return new CommonResponse<>(statusCode, message, data);
    }

    public CommonResponse<List<AuthorDataResponse>> getAllAuthorPaginate(int limit, int offset) throws SQLException {
        int statusCode = 0;
        String message = "";
        int totalCount = 0;
        List<AuthorDataResponse> data = null;
        List<AuthorDataResponse> authorList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM author");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();

            PreparedStatement ps = conn.prepareStatement("SELECT id, first_name, last_name, date_of_birth, " +
                    "phone_no,gender,email, is_deleted, title FROM author where is_deleted = 0 LIMIT ? OFFSET ?");
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AuthorDataResponse  mappedData = AuthorMapper.authorDataResponse(rs);
                authorList.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Author data fetch successfully";
            data = authorList;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while author data fetch.";
        }

        return new CommonResponse<>(statusCode, message, data, totalCount);
    }

    public CommonResponse<String> createAuthor(UserRequest userRequest) throws SQLException {
        Connection conn = DBConnection.getInstance().getConnection();
        try {
            conn.setAutoCommit(false);

            String invSql = "INSERT INTO author (first_name, last_name, date_of_birth, phone_no, gender, email, title)  " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
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
            usrStmt.setString(6, userRequest.getEmail());
            usrStmt.setString(7, userRequest.getTitle());
            int authCount = usrStmt.executeUpdate();

            if (authCount == 0) {
                throw new SQLException("Author create failed, no rows affected.");
            }

            conn.commit();
            return new CommonResponse<>(200, "Author create successfully", null);

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error author create: " + e.getMessage(), null);
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

    public CommonResponse<String> updateAuthor(UserRequest userRequest) throws SQLException, ServletException {
        Connection conn = DBConnection.getInstance().getConnection();

        try{
            conn.setAutoCommit(false);
            String sql = "UPDATE author SET first_name = ?, last_name = ?, date_of_birth = ?, phone_no = ?, gender = ?, email = ?, title = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userRequest.getFirstName());
            ps.setString(2, userRequest.getLastName());
            ps.setDate(3, java.sql.Date.valueOf(userRequest.getDateOfBirth()));
            ps.setString(4, userRequest.getPhoneNo());
            ps.setString(5, userRequest.getGender().toString());
            ps.setString(6, userRequest.getEmail());
            ps.setString(7, userRequest.getTitle());
            ps.setInt(8, userRequest.getUserId());
            ps.executeUpdate();

            conn.commit();
            return new CommonResponse<>(200, "Author details updated", null);

        } catch (SQLException e) {
            try {
                conn.rollback(); // rollback only works if auto-commit is false
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return new CommonResponse<>(500, "Error updating author details: " + e.getMessage(), null);
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


}
