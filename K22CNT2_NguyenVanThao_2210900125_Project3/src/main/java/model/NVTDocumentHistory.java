package model;

import java.sql.Timestamp;

public class NVTDocumentHistory {
    private int historyId;
    private int documentId;
    private String action;
    private int performedBy;
    private Timestamp timestamp;
    private String documentType;

    public NVTDocumentHistory(int historyId, int documentId, String action, int performedBy, Timestamp timestamp, String documentType) {
        this.historyId = historyId;
        this.documentId = documentId;
        this.action = action;
        this.performedBy = performedBy;
        this.timestamp = timestamp;
        this.documentType = documentType;
    }

    public int getHistoryId() { return historyId; }
    public int getDocumentId() { return documentId; }
    public String getAction() { return action; }
    public int getPerformedBy() { return performedBy; }
    public Timestamp getTimestamp() { return timestamp; }
    public String getDocumentType() { return documentType; }
}
