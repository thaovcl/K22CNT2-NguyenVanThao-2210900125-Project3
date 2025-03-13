package model;

import java.sql.Timestamp;

public class NVTAttachment {
    private int attachmentId;
    private int documentId;
    private String fileName;
    private String filePath;
    private int uploadedBy;
    private Timestamp uploadedAt;
    private String documentType;

    // Constructor
    public NVTAttachment(int attachmentId, int documentId, String fileName, String filePath, int uploadedBy, Timestamp uploadedAt, String documentType) {
        this.attachmentId = attachmentId;
        this.documentId = documentId;
        this.fileName = fileName;
        this.filePath = filePath;
        this.uploadedBy = uploadedBy;
        this.uploadedAt = uploadedAt;
        this.documentType = documentType;
    }

    // Getters và Setters
    public int getAttachmentId() { return attachmentId; }
    public void setAttachmentId(int attachmentId) { this.attachmentId = attachmentId; }

    public int getDocumentId() { return documentId; }
    public void setDocumentId(int documentId) { this.documentId = documentId; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public int getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(int uploadedBy) { this.uploadedBy = uploadedBy; }

    public Timestamp getUploadedAt() { return uploadedAt; }
    public void setUploadedAt(Timestamp uploadedAt) { this.uploadedAt = uploadedAt; }

    public String getDocumentType() { return documentType; }
    public void setDocumentType(String documentType) { this.documentType = documentType; }
    private String documentTitle;

    public String getDocumentTitle() {
        return documentTitle;
    }

    public void setDocumentTitle(String documentTitle) {
        this.documentTitle = documentTitle;
    }
}
