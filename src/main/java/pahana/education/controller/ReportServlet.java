package pahana.education.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import pahana.education.dao.ReportDao;
import pahana.education.model.response.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "reportServlet", value = "/report")
public class ReportServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String report_type = request.getParameter("report_type");
        CommonResponse<List<UserDataResponse>> userDataList = null;
        HttpSession session = request.getSession();
        UserDataResponse user = (UserDataResponse) session.getAttribute("user");

        if ("customer_purchase".equalsIgnoreCase(report_type)) {
            try {
                int userId = user.getId();
                List<ReportCustomerPurchase> reportData = ReportDao.getInstance().customerPurchaseReport(userId);
                if (reportData != null) {
                    request.setAttribute("reportDataList", reportData);
                    request.getRequestDispatcher("/src/pages/reports-customer-purchase.jsp").forward(request, response);
                    return;
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        if ("cashier_daily_sales".equalsIgnoreCase(report_type)) {
            try {
                int userId = user.getId();
                List<ReportCustomerPurchase> reportData = ReportDao.getInstance().cashierDailySalesReport(userId);
                if (reportData != null) {
                    request.setAttribute("reportDataList", reportData);
                    request.getRequestDispatcher("/src/pages/reports-cashier-daily-sales.jsp").forward(request, response);
                    return;
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        if ("cashier_wise_sales".equalsIgnoreCase(report_type)) {
            try {
                int userId = user.getId();
                List<ReportCashierWiseSales> reportData = ReportDao.getInstance().cashierWiseSalesReport();
                if (reportData != null) {
                    request.setAttribute("reportDataList", reportData);
                    request.getRequestDispatcher("/src/pages/reports-cashier-wise-sales.jsp").forward(request, response);
                    return;
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        if ("product_list".equalsIgnoreCase(report_type)) {
            try {
                int userId = user.getId();
                List<ReportProductWise> reportData = ReportDao.getInstance().productListReport();
                if (reportData != null) {
                    request.setAttribute("reportDataList", reportData);
                    request.getRequestDispatcher("/src/pages/reports-product-list.jsp").forward(request, response);
                    return;
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        if ("product_qty_list".equalsIgnoreCase(report_type)) {
            try {
                int userId = user.getId();
                List<ReportProductWise> reportData = ReportDao.getInstance().productListReport();
                if (reportData != null) {
                    request.setAttribute("reportDataList", reportData);
                    request.getRequestDispatcher("/src/pages/reports-product-qty-list.jsp").forward(request, response);
                    return;
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }



    }

}
