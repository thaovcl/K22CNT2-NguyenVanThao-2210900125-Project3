package dao;

import model.NVTAttachment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NVTAttachmentDAO {
	private Connection conn;

    public NVTAttachmentDAO(Connection conn) {
        this.conn = conn;
    }

    public List<NVTAttachment> getAllAttachments() {
        List<NVTAttachment> attachments = new ArrayList<>();
        String sql = "SELECT a.NVT_AttachmentID, a.NVT_DocumentID, a.NVT_FileName, a.NVT_FilePath, " +
                     "a.NVT_UploadedBy, a.NVT_UploadedAt, a.NVT_DocumentType, " +
                     "d.NVT_Title " +
                     "FROM nvt_attachments a " +
                     "JOIN nvt_documents d ON a.NVT_DocumentID = d.NVT_DocumentID";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                NVTAttachment attachment = new NVTAttachment(
                    rs.getInt("NVT_AttachmentID"),
                    rs.getInt("NVT_DocumentID"),
                    rs.getString("NVT_FileName"),
                    rs.getString("NVT_FilePath"),
                    rs.getInt("NVT_UploadedBy"),
                    rs.getTimestamp("NVT_UploadedAt"),
                    rs.getString("NVT_DocumentType")
                );
                // Gán thêm tên tài liệu
                attachment.setDocumentTitle(rs.getString("NVT_Title"));
                attachments.add(attachment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attachments;
    }


    // Lưu file vào database
    public void saveAttachment(NVTAttachment attachment) throws SQLException {
        String sql = "INSERT INTO nvt_attachments (NVT_DocumentID, NVT_FileName, NVT_FilePath, NVT_UploadedBy, NVT_DocumentType) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, attachment.getDocumentId());
            stmt.setString(2, attachment.getFileName());
            stmt.setString(3, attachment.getFilePath());
            stmt.setInt(4, attachment.getUploadedBy());
            stmt.setString(5, attachment.getDocumentType());
            stmt.executeUpdate();
        }
    }

    // Lấy danh sách file theo documentId
    public List<NVTAttachment> getAttachmentsByDocumentId(int documentId) throws SQLException {
        List<NVTAttachment> attachments = new ArrayList<>();
        String sql = "SELECT * FROM nvt_attachments WHERE NVT_DocumentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, documentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                attachments.add(new NVTAttachment(
                    rs.getInt("NVT_AttachmentID"),
                    rs.getInt("NVT_DocumentID"),
                    rs.getString("NVT_FileName"),
                    rs.getString("NVT_FilePath"),
                    rs.getInt("NVT_UploadedBy"),
                    rs.getTimestamp("NVT_UploadedAt"),
                    rs.getString("NVT_DocumentType")
                ));
            }
        }
        return attachments;
    }
    
    public boolean updateAttachmentFile(int attachmentId, String newFileName, String newFilePath) throws SQLException {
        String query = "UPDATE nvt_attachments SET NVT_FileName = ?, NVT_FilePath = ? WHERE NVT_AttachmentID = ?";  

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, newFileName);
            stmt.setString(2, newFilePath);
            stmt.setInt(3, attachmentId);

            return stmt.executeUpdate() > 0;
        }
    }

    
    public NVTAttachment getAttachmentById(int attachmentId) throws SQLException {
        String query = "SELECT * FROM nvt_attachments WHERE NVT_AttachmentID = ?";  // Đúng tên cột

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, attachmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new NVTAttachment(
                    rs.getInt("NVT_AttachmentID"),  
                    rs.getInt("NVT_DocumentID"),
                    rs.getString("NVT_FileName"),
                    rs.getString("NVT_FilePath"),
                    rs.getInt("NVT_UploadedBy"),
                    rs.getTimestamp("NVT_UploadedAt"),
                    rs.getString("NVT_DocumentType")
                );
            }
        }
        return null;
    }


    
    public String getFilePathById(int attachmentId) throws SQLException {
        String sql = "SELECT NVT_FilePath FROM nvt_attachments WHERE NVT_AttachmentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, attachmentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("NVT_FilePath");
            }
        }
        return null;
    }

    // Xóa file theo id
    public void deleteAttachment(int attachmentId) throws SQLException {
        String sql = "DELETE FROM nvt_attachments WHERE NVT_AttachmentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, attachmentId);
            stmt.executeUpdate();
        }
    }
}
