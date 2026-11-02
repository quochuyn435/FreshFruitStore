/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author livsu
 */
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }
   
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String name = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        UserDAO dao = new UserDAO();
        
        // Cần check trùng Username trước khi insert
        if (dao.checkUserExist(user)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } else {
            dao.registerUser(user, pass, name, phone, address);
            // Đăng ký xong tự động nhảy về trang login
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
