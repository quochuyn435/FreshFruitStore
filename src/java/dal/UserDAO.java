package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO extends DBContext {

    // 1. Hàm kiểm tra đăng nhập (Trả về Object User nếu đúng, null nếu sai)
    public User checkLogin(String username, String password) {
        String sql = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("UserID"));
                u.setUsername(rs.getString("Username"));
                u.setFullName(rs.getString("FullName"));
                u.setRole(rs.getString("Role")); // Thu thập Role để Controller bẻ lái
                return u;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL checkLogin: " + e.getMessage());
        }
        return null;
    }

    // 2. Hàm kiểm tra trùng tài khoản (trả về true/false)
    public boolean checkUserExist(String username) {
        String sql = "SELECT 1 FROM Users WHERE Username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true; // Đã tồn tại
            }
        } catch (SQLException e) {
            System.err.println("Lỗi checkUserExist: " + e.getMessage());
        }
        return false;
    }

    // 3. Hàm tạo tài khoản mới (Mặc định Role là Customer)
    public void registerUser(String user, String pass, String name, String phone, String address) {
        String sql = "INSERT INTO Users (Username, Password, FullName, Phone, Address, Role) VALUES (?, ?, ?, ?, ?, 'Customer')";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, user);
            st.setString(2, pass);
            st.setString(3, name);
            st.setString(4, phone);
            st.setString(5, address);
            st.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi registerUser: " + e.getMessage());
        }
    }
}
