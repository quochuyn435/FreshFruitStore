package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class UserDAO extends DBContext {

    // Dữ liệu dự phòng (Fallback) khớp với FreshFruitStore.sql để không bị lỗi NullPointerException khi chưa gắn mssql-jdbc.jar
    private static final List<User> FALLBACK_USERS = Collections.synchronizedList(new ArrayList<>());
    // Lưu danh sách ID tài khoản bị khóa bởi Admin
    private static final Set<Integer> LOCKED_USER_IDS = Collections.synchronizedSet(new HashSet<>());

    static {
        FALLBACK_USERS.add(new User(1, "admin", "123456", "Quản trị viên Hệ thống", "0901234567", "FPT University Hòa Lạc", "Admin", false));
        FALLBACK_USERS.add(new User(2, "customer", "123", "Nguyễn Văn A", "0912345678", "Số 12 Cầu Giấy, Hà Nội", "Customer", false));
        FALLBACK_USERS.add(new User(3, "khachhang02", "123", "Trần Thị B", "0987654321", "Quận 1, TP. Hồ Chí Minh", "Customer", true));
        LOCKED_USER_IDS.add(3);
    }

    // 1. Hàm kiểm tra đăng nhập (Trả về Object User nếu đúng, null nếu sai)
    public User checkLogin(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        username = username.trim();

        // Nếu đã kết nối SQL Server thành công
        if (connection != null) {
            String sql = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
            try (PreparedStatement st = connection.prepareStatement(sql)) {
                st.setString(1, username);
                st.setString(2, password);
                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    User u = new User();
                    int id = rs.getInt("UserID");
                    u.setUserId(id);
                    u.setUsername(rs.getString("Username"));
                    u.setPassword(rs.getString("Password"));
                    u.setFullName(rs.getString("FullName"));
                    u.setPhone(rs.getString("Phone"));
                    u.setAddress(rs.getString("Address"));
                    String role = rs.getString("Role");
                    u.setRole(role != null ? role.trim() : "Customer"); // Thu thập Role để Controller bẻ lái
                    u.setLocked(LOCKED_USER_IDS.contains(id));
                    return u;
                }
                return null;
            } catch (SQLException e) {
                System.err.println("Lỗi SQL checkLogin: " + e.getMessage());
            }
        }

        // Fallback khi chưa có kết nối CSDL (tránh lỗi 500 NullPointerException)
        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                if (u.getUsername().equalsIgnoreCase(username) && u.getPassword().equals(password)) {
                    u.setLocked(LOCKED_USER_IDS.contains(u.getUserId()));
                    return u;
                }
            }
        }
        return null;
    }

    // 2. Hàm kiểm tra trùng tài khoản (trả về true/false)
    public boolean checkUserExist(String username) {
        if (username == null) {
            return false;
        }
        username = username.trim();

        if (connection != null) {
            String sql = "SELECT 1 FROM Users WHERE Username = ?";
            try (PreparedStatement st = connection.prepareStatement(sql)) {
                st.setString(1, username);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return true; // Đã tồn tại
                }
                return false;
            } catch (SQLException e) {
                System.err.println("Lỗi checkUserExist: " + e.getMessage());
            }
        }

        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                if (u.getUsername().equalsIgnoreCase(username)) {
                    return true;
                }
            }
        }
        return false;
    }

    // 3. Hàm tạo tài khoản mới (Mặc định Role là Customer)
    public void registerUser(String user, String pass, String name, String phone, String address) {
        if (connection != null) {
            String sql = "INSERT INTO Users (Username, Password, FullName, Phone, Address, Role) VALUES (?, ?, ?, ?, ?, 'Customer')";
            try (PreparedStatement st = connection.prepareStatement(sql)) {
                st.setString(1, user);
                st.setString(2, pass);
                st.setString(3, name);
                st.setString(4, phone);
                st.setString(5, address);
                st.executeUpdate();
                return;
            } catch (SQLException e) {
                System.err.println("Lỗi registerUser: " + e.getMessage());
            }
        }

        synchronized (FALLBACK_USERS) {
            int nextId = FALLBACK_USERS.size() + 1;
            FALLBACK_USERS.add(new User(nextId, user, pass, name, phone, address, "Customer", false));
        }
    }

    // 4. Hàm cập nhật thông tin cá nhân của User (Họ tên, SĐT, Địa chỉ, Mật khẩu)
    public boolean updateUserProfile(int userId, String fullName, String phone, String address, String newPassword) {
        boolean changePass = (newPassword != null && !newPassword.trim().isEmpty());

        if (connection != null) {
            String sql = changePass
                    ? "UPDATE Users SET FullName = ?, Phone = ?, Address = ?, Password = ? WHERE UserID = ?"
                    : "UPDATE Users SET FullName = ?, Phone = ?, Address = ? WHERE UserID = ?";
            try (PreparedStatement st = connection.prepareStatement(sql)) {
                st.setString(1, fullName);
                st.setString(2, phone);
                st.setString(3, address);
                if (changePass) {
                    st.setString(4, newPassword.trim());
                    st.setInt(5, userId);
                } else {
                    st.setInt(4, userId);
                }
                return st.executeUpdate() > 0;
            } catch (SQLException e) {
                System.err.println("Lỗi updateUserProfile: " + e.getMessage());
            }
        }

        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                if (u.getUserId() == userId) {
                    u.setFullName(fullName);
                    u.setPhone(phone);
                    u.setAddress(address);
                    if (changePass) {
                        u.setPassword(newPassword.trim());
                    }
                    return true;
                }
            }
        }
        return false;
    }

    // 5. Hàm lấy danh sách tất cả tài khoản cho Admin quản lý
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        if (connection != null) {
            String sql = "SELECT * FROM Users ORDER BY UserID ASC";
            try (PreparedStatement st = connection.prepareStatement(sql);
                 ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("UserID");
                    User u = new User(
                            id,
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("FullName"),
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            rs.getString("Role") != null ? rs.getString("Role").trim() : "Customer",
                            LOCKED_USER_IDS.contains(id)
                    );
                    list.add(u);
                }
                return list;
            } catch (SQLException e) {
                System.err.println("Lỗi getAllUsers: " + e.getMessage());
            }
        }

        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                u.setLocked(LOCKED_USER_IDS.contains(u.getUserId()));
                list.add(u);
            }
        }
        return list;
    }

    // 6. Hàm Khóa / Mở khóa tài khoản cho Admin
    public void setUserLocked(int userId, boolean locked) {
        if (locked) {
            LOCKED_USER_IDS.add(userId);
        } else {
            LOCKED_USER_IDS.remove(userId);
        }
        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                if (u.getUserId() == userId) {
                    u.setLocked(locked);
                }
            }
        }
    }
}
