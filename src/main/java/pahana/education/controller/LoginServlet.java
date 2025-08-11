package pahana.education.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pahana.education.dao.UserDAO;
import pahana.education.model.request.LoginRequest;
import pahana.education.model.response.CommonResponse;
import pahana.education.model.response.UserDataResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    public void init() {}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userEmail = request.getParameter("username");
        String password = request.getParameter("password");

        HashMap<String, String> errors = validateUserForm(userEmail, password);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmail(userEmail);
        loginRequest.setPassword(password);

        try {
            CommonResponse<UserDataResponse> userDAO = UserDAO.getInstance().login(loginRequest);
            if (userDAO.getCode() == 200) {
                request.getSession().setAttribute("user", userDAO.getMessage());
                response.sendRedirect("dashboard");
            } else {
                request.setAttribute("error", userDAO.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static HashMap<String, String> validateUserForm(String userEmail, String password) {
        HashMap<String, String> errors = new HashMap<>();

        if (userEmail == null || userEmail.trim().isEmpty()) {
            errors.put("email", "Email is required");
        } else if (!userEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.put("email", "Invalid email format");
        } else if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password is required");
        } else if (password.length() < 6) {
            errors.put("password", "Password must be at least 6 characters long");
        }
        return errors;
    }

    public void destroy() {
    }
}
