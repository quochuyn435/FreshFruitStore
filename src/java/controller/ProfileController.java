package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User account = (User) session.getAttribute("account");

        String fullName = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String newPassword = req.getParameter("password");

        int userId = 2;
        if (account != null) {
            userId = account.getUserId();
        } else if (req.getParameter("userId") != null && !req.getParameter("userId").isEmpty()) {
            try {
                userId = Integer.parseInt(req.getParameter("userId"));
            } catch (NumberFormatException ignored) {
            }
        }

        UserDAO dao = new UserDAO();
        boolean updated = dao.updateUserProfile(userId, fullName, phone, address, newPassword);

        if (account != null) {
            account.setFullName(fullName);
            account.setPhone(phone);
            account.setAddress(address);
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                account.setPassword(newPassword.trim());
            }
            session.setAttribute("account", account);
        }

        if (updated || account != null) {
            req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        } else {
            req.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng đăng nhập lại!");
        }
        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }
}
