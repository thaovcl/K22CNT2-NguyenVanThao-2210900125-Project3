package dao;

import model.NVTDocument;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {
    public List<NVTDocument> getAllDocuments() {
        List<NVTDocument> documents = new ArrayList<>();
        String query = "SELECT * FROM nvt_documents";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                NVTDocument doc = new NVTDocument();
                doc.setDocumentID(rs.getInt("NVT_DocumentID"));
                doc.setDocumentCode(rs.getString("NVT_DocumentCode"));
                doc.setTitle(rs.getString("NVT_Title"));
                doc.setContent(rs.getString("NVT_Content"));

                // Kiểm tra NULL trước khi gán giá trị
                doc.setTypeID(rs.getObject("NVT_TypeID") != null ? rs.getInt("NVT_TypeID") : 0);
                doc.setDocumentType(rs.getString("NVT_DocumentType") != null ? rs.getString("NVT_DocumentType") : "Không xác định");
                doc.setOrganizationID(rs.getObject("NVT_OrganizationID") != null ? rs.getInt("NVT_OrganizationID") : 0);
                doc.setSentDate(rs.getDate("NVT_SentDate"));
                doc.setReceivedDate(rs.getDate("NVT_ReceivedDate"));

                // Kiểm tra NULL cho trạng thái
                String status = rs.getString("NVT_Status");
                doc.setStatus(status != null ? status : "Chưa xác định");

                doc.setCreatedBy(rs.getObject("NVT_CreatedBy") != null ? rs.getInt("NVT_CreatedBy") : 0);
                doc.setCreatedAt(rs.getTimestamp("NVT_CreatedAt"));
                doc.setFile(rs.getString("NVT_File") != null ? rs.getString("NVT_File") : "");

                documents.add(doc);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi truy vấn dữ liệu trong DocumentDAO!");
            e.printStackTrace();
        }

        return documents;
    }
}
