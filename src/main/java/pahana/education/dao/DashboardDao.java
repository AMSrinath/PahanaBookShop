package pahana.education.dao;

import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.DashBoardResponse;
import pahana.education.model.response.InventoryResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.mappers.InventoryMapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardDao {
    private static DashboardDao instance;
    private DashboardDao() {
    }
    public static synchronized DashboardDao getInstance() {
        if (instance == null) {
            instance = new DashboardDao();
        }
        return instance;
    }

    public CommonResponse<DashBoardResponse> getDashboardData() throws SQLException {
        int statusCode = 0;
        String message = "";
        int saleCount = 0, inventoryCount= 0, userCount=0, customerCount=0, stockCount =0;
        double saleTotal = 0.00, dailySales =0.00, stockValue =0.00, currentMonth=0.00, lastMonth=0.00;
        DashBoardResponse data = null;

        Connection conn = DBConnection.getInstance().getConnection();
        PreparedStatement salesSql = conn.prepareStatement("SELECT COUNT(*) FROM sales_invoice where is_deleted = 0");
        ResultSet salesCountRs = salesSql.executeQuery();
        if (salesCountRs.next()) {
            saleCount = salesCountRs.getInt(1);
        }

        PreparedStatement salesTotalSql = conn.prepareStatement("SELECT sum(si.invoice_total_gross) as saleTotal " +
                "FROM sales_invoice si where si.is_deleted = 0");
        ResultSet salesTotalRs = salesTotalSql.executeQuery();
        if (salesTotalRs.next()) {
            saleTotal = salesTotalRs.getDouble(1);
        }

        PreparedStatement dailySalesSql = conn.prepareStatement("SELECT sum(si.invoice_total_gross) as saleTotal " +
                "FROM sales_invoice si where si.is_deleted = 0 and DATE(si.invoice_date) = CURDATE()");
        ResultSet dailySalesRs = dailySalesSql.executeQuery();
        if (dailySalesRs.next()) {
            dailySales = dailySalesRs.getDouble(1);
        }


        PreparedStatement invSql = conn.prepareStatement("SELECT COUNT(*) FROM inventory where is_deleted = 0");
        ResultSet invCountRs = invSql.executeQuery();
        if (invCountRs.next()) {
            inventoryCount = invCountRs.getInt(1);
        }

        PreparedStatement userSql = conn.prepareStatement("SELECT COUNT(*) FROM user where is_deleted = 0");
        ResultSet userCountRs = userSql.executeQuery();
        if (userCountRs.next()) {
            userCount = userCountRs.getInt(1);
        }

        PreparedStatement customerSql = conn.prepareStatement("SELECT COUNT(*) FROM user u \n" +
                "left join user_role ur on ur.user_id = u.id \n" +
                "where u.is_deleted = 0 and ur.role_id =3");
        ResultSet customerCountRs = customerSql.executeQuery();
        if (userCountRs.next()) {
            customerCount = customerCountRs.getInt(1);
        }

        PreparedStatement stockSql = conn.prepareStatement("SELECT sum(u.qty_hand) FROM price_list u where u.is_deleted = 0 and u.qty_hand > 0");
        ResultSet stockCountRs = stockSql.executeQuery();
        if (stockCountRs.next()) {
            stockCount = stockCountRs.getInt(1);
        }

        PreparedStatement stockValueSql = conn.prepareStatement("SELECT sum(u.retail_price) FROM price_list u  where u.is_deleted = 0 and u.qty_hand > 0");
        ResultSet stockValueRs = stockValueSql.executeQuery();
        if (stockValueRs.next()) {
            stockValue = stockValueRs.getInt(1);
        }


        PreparedStatement saleMonthSql = conn.prepareStatement("SELECT \n" +
                "    SUM(CASE \n" +
                "        WHEN YEAR(si.created_at) = YEAR(CURRENT_DATE()) \n" +
                "         AND MONTH(si.created_at) = MONTH(CURRENT_DATE()) \n" +
                "        THEN si.invoice_total_gross ELSE 0 END) AS current_month_total,\n" +
                "    SUM(CASE \n" +
                "        WHEN YEAR(si.created_at) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) \n" +
                "         AND MONTH(si.created_at) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) \n" +
                "        THEN si.invoice_total_gross ELSE 0 END) AS last_month_total\n" +
                "FROM sales_invoice si WHERE si.is_deleted = 0");

        ResultSet saleMonthRs = saleMonthSql.executeQuery();
        if (saleMonthRs.next()) {
            currentMonth = saleMonthRs.getDouble("current_month_total");
            lastMonth = saleMonthRs.getDouble("last_month_total");
        }

        DashBoardResponse db = new DashBoardResponse();
        db.setSaleCount(saleCount);
        db.setInventoryCount(inventoryCount);
        db.setUserCount(userCount);
        db.setCustomerCount(customerCount);
        db.setStockCount(stockCount);
        db.setSaleTotal(saleTotal);
        db.setDailySales(dailySales);
        db.setStockValue(stockValue);
        db.setCurrentMonth(currentMonth);
        db.setLastMonth(lastMonth);
        data = db;

        return new CommonResponse<>(statusCode, message, data);
    }

}
