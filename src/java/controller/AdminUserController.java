package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        List<User> listUser = dao.getAllUsers();
        req.setAttribute("listUser", listUser);
        req.getRequestDispatcher("/admin-user.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String userIdRaw = req.getParameter("userId");
        String action = req.getParameter("action");

        UserDAO dao = new UserDAO();
        if (userIdRaw != null) {
            try {
                int userId = Integer.parseInt(userIdRaw);
                boolean lock = !"unlock".equalsIgnoreCase(action);
                dao.setUserLocked(userId, lock);
                req.setAttribute("message", lock ? "Đã khóa tài khoản #" + userId : "Đã mở khóa tài khoản #" + userId);
            } catch (NumberFormatException ignored) {
            }
        }

        List<User> listUser = dao.getAllUsers();
        req.setAttribute("listUser", listUser);
        req.getRequestDispatcher("/admin-user.jsp").forward(req, resp);
    }
}
