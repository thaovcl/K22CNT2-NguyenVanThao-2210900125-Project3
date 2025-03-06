package dao;

import model.DocumentOutgoing;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentOutgoingDAO {

    // Lấy danh sách tài liệu đi (Outgoing)
    public List<DocumentOutgoing> getOutgoingDocuments() {
        List<DocumentOutgoing> documents = new ArrayList<>();
        String sql = "SELECT * FROM nvt_documents WHERE NVT_DocumentType = 'Outgoing'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                documents.add(mapResultSetToDocument(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return documents;
    }

    // Thêm tài liệu đi
    public void insertDocument(DocumentOutgoing doc) {
        String sql = "INSERT INTO nvt_documents (NVT_DocumentCode, NVT_Title, NVT_Content, NVT_DocumentType, NVT_SentDate, NVT_Status, NVT_CreatedBy, NVT_File) VALUES (?, ?, ?, 'Outgoing', ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setDocumentParameters(stmt, doc);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy tài liệu theo ID
    public DocumentOutgoing getDocumentById(int id) {
        String sql = "SELECT * FROM nvt_documents WHERE NVT_DocumentID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToDocument(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật tài liệu đi
    public void updateDocument(DocumentOutgoing doc) {
        String sql = "UPDATE nvt_documents SET NVT_DocumentCode=?, NVT_Title=?, NVT_Content=?, NVT_SentDate=?, NVT_Status=?, NVT_CreatedBy=?, NVT_File=? WHERE NVT_DocumentID=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setDocumentParameters(stmt, doc);
            stmt.setInt(8, doc.getId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa tài liệu theo ID
    public void deleteDocument(int id) {
        String sql = "DELETE FROM nvt_documents WHERE NVT_DocumentID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Phương thức map dữ liệu từ ResultSet sang DocumentOutgoing
    private DocumentOutgoing mapResultSetToDocument(ResultSet rs) throws SQLException {
        DocumentOutgoing doc = new DocumentOutgoing();
        doc.setId(rs.getInt("NVT_DocumentID"));
        doc.setCode(rs.getString("NVT_DocumentCode"));
        doc.setTitle(rs.getString("NVT_Title"));
        doc.setContent(rs.getString("NVT_Content"));
        doc.setSentDate(rs.getDate("NVT_SentDate"));
        doc.setStatus(rs.getString("NVT_Status"));
        doc.setCreatedBy(rs.getInt("NVT_CreatedBy"));
        doc.setFile(rs.getString("NVT_File"));
        return doc;
    }

    // Phương thức thiết lập tham số cho PreparedStatement
    private void setDocumentParameters(PreparedStatement stmt, DocumentOutgoing doc) throws SQLException {
        stmt.setString(1, doc.getCode());
        stmt.setString(2, doc.getTitle());
        stmt.setString(3, doc.getContent());
        stmt.setDate(4, doc.getSentDate() != null ? new Date(doc.getSentDate().getTime()) : null);
        stmt.setString(5, doc.getStatus());
        stmt.setInt(6, doc.getCreatedBy());
        stmt.setString(7, doc.getFile());
    }
}
