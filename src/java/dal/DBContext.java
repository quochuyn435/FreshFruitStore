package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    // Biến connection để các lớp DAO con (UserDAO, ProductDAO...) có thể dùng chung
    protected Connection connection;

    public DBContext() {
        try {
            // Nhớ sửa lại tài khoản sa và mật khẩu cho đúng với SQL Server của máy bạn nhé
            String user = "sa";
            String pass = "123456";
            
            // URL trỏ thẳng vào database FreshFruitStore, thêm trustServerCertificate để tránh lỗi SSL
            String url = "jdbc:sqlserver://localhost:1433;databaseName=FreshFruitStore;encrypt=true;trustServerCertificate=true";
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
            
        } catch (ClassNotFoundException | SQLException ex) {
            System.err.println("Lỗi kết nối CSDL tại DBContext: " + ex.getMessage());
        }
    }
}