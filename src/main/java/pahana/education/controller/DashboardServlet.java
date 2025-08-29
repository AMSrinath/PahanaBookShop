package pahana.education.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pahana.education.dao.DashboardDao;
import pahana.education.model.response.*;

import java.io.IOException;

@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            CommonResponse<DashBoardResponse> dashboardData = DashboardDao.getInstance().getDashboardData();
            if (dashboardData.getData() != null) {
                request.setAttribute("dashboardData", dashboardData.getData());
                request.getRequestDispatcher("/src/pages/dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

}
