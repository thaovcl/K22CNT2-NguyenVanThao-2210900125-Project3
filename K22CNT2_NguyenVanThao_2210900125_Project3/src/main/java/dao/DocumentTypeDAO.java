package dao;

import model.DocumentType;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentTypeDAO {
    public List<DocumentType> getAllDocumentTypes() {
        List<DocumentType> list = new ArrayList<>();
        String query = "SELECT * FROM nvt_documenttypes";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new DocumentType(rs.getInt("NVT_TypeID"), rs.getString("NVT_TypeName")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addDocumentType(String typeName) {
        String query = "INSERT INTO nvt_documenttypes (NVT_TypeName) VALUES (?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, typeName);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public DocumentType getDocumentTypeByID(int typeID) {
        String query = "SELECT * FROM nvt_documenttypes WHERE NVT_TypeID = ?";
        DocumentType documentType = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, typeID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    documentType = new DocumentType(rs.getInt("NVT_TypeID"), rs.getString("NVT_TypeName"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documentType;
    }

    public void updateDocumentType(int typeID, String typeName) {
        String query = "UPDATE nvt_documenttypes SET NVT_TypeName = ? WHERE NVT_TypeID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, typeName);
            ps.setInt(2, typeID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDocumentType(int typeID) {
        String query = "DELETE FROM nvt_documenttypes WHERE NVT_TypeID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, typeID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
