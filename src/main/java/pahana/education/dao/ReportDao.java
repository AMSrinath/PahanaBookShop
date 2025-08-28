package pahana.education.dao;

import pahana.education.model.response.ReportCashierWiseSales;
import pahana.education.model.response.ReportCustomerPurchase;
import pahana.education.model.response.ReportProductWise;
import pahana.education.model.response.UserRoleResponse;
import pahana.education.util.DBConnection;
import pahana.education.util.mappers.UserRoleMapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDao {
    private static ReportDao instance;

    private ReportDao() {}

    public static synchronized  ReportDao getInstance() throws SQLException {
        if (instance == null ) {
            instance = new ReportDao();
        }
        return instance;
    }

    public List<ReportCustomerPurchase> customerPurchaseReport(int userId) throws SQLException {
        List<ReportCustomerPurchase> dataList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select it.name as productType, i.default_image as productImage, i.name as productName, \n" +
                    "sid.unit_sell_price as retailPrice, sid.quantity as qty, si.invoice_no, \n" +
                    "sid.total_sell_price as total from sales_invoice si \n" +
                    "left join sales_invoice_detail sid on sid.sales_invoice_id = si.id \n" +
                    "left join inventory i on sid.inventory_id = i.id \n" +
                    "left join inventory_type it on i.inventory_type = it.id \n" +
                    "where si.customer_id = ? and si.is_deleted = 0");

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportCustomerPurchase data = new ReportCustomerPurchase(
                        rs.getString("productImage"),
                        rs.getString("productName"),
                        rs.getString("productType"),
                        rs.getInt("retailPrice"),
                        rs.getInt("qty"),
                        rs.getInt("total"),
                        rs.getString("invoice_no")
                );
                dataList.add(data);
            }
            rs.close();
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataList;
    }

    public List<ReportCustomerPurchase> cashierDailySalesReport(int userId) throws SQLException {
        List<ReportCustomerPurchase> dataList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select it.name as productType, i.default_image as productImage, i.name as productName, \n" +
                    "sid.unit_sell_price as retailPrice, sid.quantity as qty,  si.invoice_no,\n" +
                    "sid.total_sell_price as total from sales_invoice si \n" +
                    "left join sales_invoice_detail sid  on sid.inventory_id = si.id \n" +
                    "left join inventory i on sid.inventory_id = i.id \n" +
                    "left join inventory_type it on i.inventory_type = it.id\n" +
                    "where si.cashier_id = ? and si.is_deleted =0 and DATE(si.invoice_date) = CURDATE()");

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportCustomerPurchase data = new ReportCustomerPurchase(
                        rs.getString("productImage"),
                        rs.getString("productName"),
                        rs.getString("productType"),
                        rs.getInt("retailPrice"),
                        rs.getInt("qty"),
                        rs.getInt("total"),
                        rs.getString("invoice_no")
                );
                dataList.add(data);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataList;
    }

    public List<ReportCashierWiseSales> cashierWiseSalesReport() throws SQLException {
        List<ReportCashierWiseSales> dataList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select u.user_image_path as userImage,  u.first_name , u.last_name , u.email , u.phone_no as phoneNo, \n" +
                    "sum(sid.unit_sell_price) as retailPrice, sum(sid.quantity) as qty, \n" +
                    "sum(sid.total_sell_price) as total from sales_invoice si \n" +
                    "left join sales_invoice_detail sid  on sid.inventory_id = si.id \n" +
                    "left join inventory i on sid.inventory_id = i.id \n" +
                    "left join inventory_type it on i.inventory_type = it.id\n" +
                    "left join user u on si.cashier_id = u.id\n" +
                    "where si.is_deleted =0 group by si.cashier_id");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportCashierWiseSales data = new ReportCashierWiseSales(
                        rs.getString("userImage"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("phoneNo"),
                        rs.getInt("retailPrice"),
                        rs.getInt("qty"),
                        rs.getInt("total")
                );
                dataList.add(data);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataList;
    }

    public List<ReportProductWise> productListReport() throws SQLException {
        List<ReportProductWise> dataList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select i.name as itemName, i.default_image as itemImage, " +
                    "i.isbn_no, it.name as typeName, i.barcode, a.first_name as authorFName, a.last_name as authorLName," +
                    " pl.cost_price as costPrice, pl.retail_price as sellPrice, pl.qty_hand as qty  from inventory i \n" +
                    "left join inventory_type it on it.id= i.inventory_type\n" +
                    "left join author a on i.author_id = a.id\n" +
                    "left join price_list pl on pl.inventory_id = i.id \n" +
                    "where i.is_deleted = 0;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportProductWise data = new ReportProductWise(
                        rs.getString("itemName"),
                        rs.getString("itemImage"),
                        rs.getString("isbn_no"),
                        rs.getString("typeName"),
                        rs.getString("barcode"),
                        rs.getString("authorFName"),
                        rs.getString("authorLName"),
                        rs.getDouble("costPrice"),
                        rs.getDouble("sellPrice"),
                        rs.getInt("qty")
                );
                dataList.add(data);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataList;
    }

}
