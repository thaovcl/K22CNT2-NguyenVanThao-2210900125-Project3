package dao;

import model.NVTDocumentHistory;
import util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

public class NVTDocumentHistoryDAO {
    
    // Lấy tất cả lịch sử tài liệu
    public List<NVTDocumentHistory> getAllHistory() {
        List<NVTDocumentHistory> historyList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM nvt_documenthistory");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                NVTDocumentHistory history = new NVTDocumentHistory(
                    rs.getInt("NVT_HistoryID"),
                    rs.getInt("NVT_DocumentID"),
                    rs.getString("NVT_Action"),
                    rs.getInt("NVT_PerformedBy"),
                    rs.getTimestamp("NVT_Timestamp"),
                    rs.getString("NVT_DocumentType")
                );
                historyList.add(history);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }

    // Lấy lịch sử theo ID tài liệu
    public List<NVTDocumentHistory> getHistoryByDocumentId(int documentId) {
        List<NVTDocumentHistory> historyList = new ArrayList<>();
        String sql = "SELECT * FROM nvt_documenthistory WHERE NVT_DocumentID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, documentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                historyList.add(new NVTDocumentHistory(
                    rs.getInt("NVT_HistoryID"),
                    rs.getInt("NVT_DocumentID"),
                    rs.getString("NVT_Action"),
                    rs.getInt("NVT_PerformedBy"),
                    rs.getTimestamp("NVT_Timestamp"),
                    rs.getString("NVT_DocumentType")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }
}
