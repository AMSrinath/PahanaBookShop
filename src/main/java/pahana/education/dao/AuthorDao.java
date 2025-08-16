package pahana.education.dao;

import pahana.education.model.response.AuthorDataResponse;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.InventoryTypeResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.enums.HttpStatusEnum;
import pahana.education.util.mappers.AuthorMapper;
import pahana.education.util.mappers.InventoryTypeMapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM author WHERE id = ?");
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
        List<AuthorDataResponse> inventoryTypes = new ArrayList<>();

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM author");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();


            PreparedStatement ps = conn.prepareStatement("SELECT * FROM author LIMIT ? OFFSET ?");
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AuthorDataResponse  mappedData = AuthorMapper.authorDataResponse(rs);
                inventoryTypes.add(mappedData);
            }

            statusCode = HttpStatusEnum.OK.getCode();
            message = "Author created successfully";
            data = inventoryTypes;

        } catch (Exception e) {
            e.printStackTrace();
            statusCode = HttpStatusEnum.INTERNAL_SERVER_ERROR.getCode();
            message = "An error occurred while creating author.";
        }

        return new CommonResponse<>(statusCode, message, data, totalCount);
    }


}
