package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class UserDAO extends DBContext {

    // Dữ liệu dự phòng (Fallback) khi chưa kết nối được SQL Server
    private static final List<User> FALLBACK_USERS = Collections.synchronizedList(new ArrayList<>());
    // Lưu trạng thái khóa theo UserID trong bộ nhớ để đồng bộ tức thì kể cả khi CSDL chưa có cột IsLocked
    private static final Map<Integer, Boolean> USER_LOCK_STATE = new ConcurrentHashMap<>();
    private static volatile boolean schemaChecked = false;

    static {
        FALLBACK_USERS.add(new User(1, "admin", "123456", "Quản trị viên Hệ thống", "0901234567", "FPT University Hòa Lạc", "Admin", false));
        FALLBACK_USERS.add(new User(2, "customer", "123", "Nguyễn Văn A", "0912345678", "Số 12 Cầu Giấy, Hà Nội", "Customer", false));
    }

    public UserDAO() {
        super();
        ensureIsLockedColumn();
    }

    // Tự động bổ sung cột IsLocked vào bảng Users nếu CSDL SQL Server chưa có cột này
    private void ensureIsLockedColumn() {
        if (connection == null || schemaChecked) {
            return;
        }
        synchronized (UserDAO.class) {
            if (schemaChecked) {
                return;
            }
            String sql = "IF COL_LENGTH('dbo.Users', 'IsLocked') IS NULL "
                    + "BEGIN "
                    + "ALTER TABLE dbo.Users ADD IsLocked BIT NOT NULL CONSTRAINT DF_Users_IsLocked DEFAULT 0 WITH VALUES; "
                    + "END";
            try (Statement st = connection.createStatement()) {
                st.execute(sql);
                schemaChecked = true;
            } catch (SQLException e) {
                System.err.println("Lưu ý kiểm tra cột IsLocked: " + e.getMessage());
            }
        }
    }

    private boolean resolveLockedState(int userId, ResultSet rs) {
        Boolean memState = USER_LOCK_STATE.get(userId);
        try {
            boolean dbLocked = rs.getBoolean("IsLocked");
            if (memState != null) {
                return memState;
            }
            return dbLocked;
        } catch (SQLException ignored) {
            return memState != null && memState;
        }
    }

    // 1. Hàm kiểm tra đăng nhập (Trả về Object User nếu đúng, null nếu sai)
    public User checkLogin(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        username = username.trim();

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
                    u.setRole(role != null ? role.trim() : "Customer");
                    u.setLocked(resolveLockedState(id, rs));
                    return u;
                }
                return null;
            } catch (SQLException e) {
                System.err.println("Lỗi SQL checkLogin: " + e.getMessage());
            }
        }

        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                if (u.getUsername().equalsIgnoreCase(username) && u.getPassword().equals(password)) {
                    Boolean memState = USER_LOCK_STATE.get(u.getUserId());
                    if (memState != null) {
                        u.setLocked(memState);
                    }
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
                return rs.next();
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

    // 3. Hàm tạo tài khoản mới (Mặc định Role là Customer, không bị khóa)
    public void registerUser(String user, String pass, String name, String phone, String address) {
        if (connection != null) {
            String sql = "INSERT INTO Users (Username, Password, FullName, Phone, Address, Role) VALUES (?, ?, ?, ?, ?, 'Customer')";
            try (PreparedStatement st = connection.prepareStatement(sql)) {
                st.setString(1, user != null ? user.trim() : "");
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
            FALLBACK_USERS.add(new User(nextId, user != null ? user.trim() : "", pass, name, phone, address, "Customer", false));
            USER_LOCK_STATE.put(nextId, false);
        }
    }

    // 4. Hàm lấy danh sách tất cả tài khoản cho Admin quản lý
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        if (connection != null) {
            String sql = "SELECT * FROM Users ORDER BY UserID ASC";
            try (PreparedStatement st = connection.prepareStatement(sql);
                 ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("UserID");
                    String role = rs.getString("Role") != null ? rs.getString("Role").trim() : "Customer";
                    boolean isLocked = !"Admin".equalsIgnoreCase(role) && resolveLockedState(id, rs);
                    User u = new User(
                            id,
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("FullName"),
                            rs.getString("Phone"),
                            rs.getString("Address"),
                            role,
                            isLocked
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
                Boolean memState = USER_LOCK_STATE.get(u.getUserId());
                if (memState != null && !"Admin".equalsIgnoreCase(u.getRole())) {
                    u.setLocked(memState);
                }
                list.add(u);
            }
        }
        return list;
    }

    // 5. Lấy thông tin 1 User theo ID
    public User getUserById(int userId) {
        for (User u : getAllUsers()) {
            if (u.getUserId() == userId) {
                return u;
            }
        }
        return null;
    }

    // 6. Hàm Khóa / Mở khóa tài khoản cho Admin (Không cho phép khóa Admin)
    public boolean setUserLocked(int userId, boolean locked) {
        User target = getUserById(userId);
        if (target == null) {
            return false;
        }
        if ("Admin".equalsIgnoreCase(target.getRole())) {
            return false; // Không bao giờ khóa tài khoản Admin
        }

        USER_LOCK_STATE.put(userId, locked);

        synchronized (FALLBACK_USERS) {
            for (User u : FALLBACK_USERS) {
                if (u.getUserId() == userId) {
                    u.setLocked(locked);
                }
            }
        }

        if (connection != null) {
            String sql = "UPDATE Users SET IsLocked = ? WHERE UserID = ?";
            try (PreparedStatement st = connection.prepareStatement(sql)) {
                st.setBoolean(1, locked);
                st.setInt(2, userId);
                st.executeUpdate();
            } catch (SQLException e) {
                System.err.println("Lỗi cập nhật IsLocked trong CSDL: " + e.getMessage());
            }
        }
        return true;
    }

    // 7. Hàm cập nhật thông tin cá nhân của Khách hàng / User (Họ tên, SĐT, Địa chỉ, Mật khẩu)
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
                st.executeUpdate();
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
        return true;
    }
}
