package dao;

import model.NVTOrganization;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NVTOrganizationDAO {
    public List<NVTOrganization> listAllOrganizations() {
        List<NVTOrganization> organizations = new ArrayList<>();
        String sql = "SELECT * FROM nvt_organizations";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                organizations.add(new NVTOrganization(
                    rs.getInt("NVT_OrganizationID"),
                    rs.getString("NVT_OrganizationName")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return organizations;
    }

    public void addOrganization(NVTOrganization organization) {
        String sql = "INSERT INTO nvt_organizations (NVT_OrganizationName) VALUES (?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, organization.getOrganizationName());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public NVTOrganization getOrganizationByID(int id) {
        NVTOrganization organization = null;
        String sql = "SELECT * FROM nvt_organizations WHERE NVT_OrganizationID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                organization = new NVTOrganization(rs.getInt("NVT_OrganizationID"), rs.getString("NVT_OrganizationName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return organization;
    }

    public void updateOrganization(NVTOrganization organization) {
        String sql = "UPDATE nvt_organizations SET NVT_OrganizationName = ? WHERE NVT_OrganizationID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, organization.getOrganizationName());
            pstmt.setInt(2, organization.getOrganizationID());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteOrganization(int id) {
        String sql = "DELETE FROM nvt_organizations WHERE NVT_OrganizationID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
