package dao;

import java.sql.*;
import java.util.*;
import model.User;
import util.DatabaseConnection;

public class UserDAO {
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM nvt_users";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(new User(
                    rs.getInt("NVT_UserID"),
                    rs.getString("NVT_Username"),
                    rs.getString("NVT_PasswordHash"),
                    rs.getString("NVT_Email"),
                    rs.getString("NVT_FullName"),
                    rs.getTimestamp("NVT_CreatedAt"),
                    rs.getInt("NVT_RoleID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public User getUserByID(int userID) {
        User user = null;
        String sql = "SELECT * FROM nvt_users WHERE NVT_UserID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("NVT_UserID"),
                    rs.getString("NVT_Username"),
                    rs.getString("NVT_PasswordHash"),
                    rs.getString("NVT_Email"),
                    rs.getString("NVT_FullName"),
                    rs.getTimestamp("NVT_CreatedAt"),
                    rs.getInt("NVT_RoleID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public User validateUser(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM nvt_users WHERE NVT_Email = ? AND NVT_PasswordHash = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("NVT_UserID"),
                    rs.getString("NVT_Username"),
                    rs.getString("NVT_PasswordHash"),
                    rs.getString("NVT_Email"),
                    rs.getString("NVT_FullName"),
                    rs.getTimestamp("NVT_CreatedAt"),
                    rs.getInt("NVT_RoleID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void addUser(User user) {
        String sql = "INSERT INTO nvt_users (NVT_Username, NVT_PasswordHash, NVT_Email, NVT_FullName, NVT_CreatedAt, NVT_RoleID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPasswordHash());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getFullName());
            pstmt.setTimestamp(5, user.getCreatedAt());
            pstmt.setInt(6, user.getRoleID());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE nvt_users SET NVT_Username=?, NVT_PasswordHash=?, NVT_Email=?, NVT_FullName=?, NVT_RoleID=? WHERE NVT_UserID=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPasswordHash());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getFullName());
            pstmt.setInt(5, user.getRoleID());
            pstmt.setInt(6, user.getUserID());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public void deleteUser(int userID) {
        String sql = "DELETE FROM nvt_users WHERE NVT_UserID=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
