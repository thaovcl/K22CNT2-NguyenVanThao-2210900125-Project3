package dao;

import model.DocumentType;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentTypeDAO {
    
    // Lấy danh sách tất cả loại tài liệu
    public List<DocumentType> getAllDocumentTypes() {
        List<DocumentType> list = new ArrayList<>();
        String query = "SELECT * FROM nvt_documenttypes";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new DocumentType(
                    rs.getInt("NVT_TypeID"),
                    rs.getString("NVT_TypeName"),
                    rs.getString("NVT_DocumentType") // Lấy giá trị của NVT_DocumentType
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm loại tài liệu mới
    public void addDocumentType(String typeName, String documentType) {
        String query = "INSERT INTO nvt_documenttypes (NVT_TypeName, NVT_DocumentType) VALUES (?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, typeName);
            ps.setString(2, documentType); // Thêm giá trị NVT_DocumentType
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy loại tài liệu theo ID
    public DocumentType getDocumentTypeByID(int typeID) {
        String query = "SELECT * FROM nvt_documenttypes WHERE NVT_TypeID = ?";
        DocumentType documentType = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, typeID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    documentType = new DocumentType(
                        rs.getInt("NVT_TypeID"),
                        rs.getString("NVT_TypeName"),
                        rs.getString("NVT_DocumentType") // Lấy giá trị của NVT_DocumentType
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documentType;
    }

    // Cập nhật loại tài liệu
    public void updateDocumentType(int typeID, String typeName, String documentType) {
        String query = "UPDATE nvt_documenttypes SET NVT_TypeName = ?, NVT_DocumentType = ? WHERE NVT_TypeID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, typeName);
            ps.setString(2, documentType); // Cập nhật NVT_DocumentType
            ps.setInt(3, typeID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa loại tài liệu
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
