package model;

import java.sql.Date;
import java.sql.Timestamp;

public class NVTDocument {
    private int documentID;
    private String documentCode;
    private String title;
    private String content;
    private int typeID;
    private String documentType;
    private int organizationID;
    private Date sentDate;
    private Date receivedDate;
    private String status;
    private int createdBy;
    private Timestamp createdAt;
    private String file;

    // Getters và Setters
    public int getDocumentID() { return documentID; }
    public void setDocumentID(int documentID) { this.documentID = documentID; }

    public String getDocumentCode() { return documentCode; }
    public void setDocumentCode(String documentCode) { this.documentCode = documentCode; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getTypeID() { return typeID; }
    public void setTypeID(int typeID) { this.typeID = typeID; }

    public String getDocumentType() { return documentType; }
    public void setDocumentType(String documentType) { this.documentType = documentType; }

    public int getOrganizationID() { return organizationID; }
    public void setOrganizationID(int organizationID) { this.organizationID = organizationID; }

    public Date getSentDate() { return sentDate; }
    public void setSentDate(Date sentDate) { this.sentDate = sentDate; }

    public Date getReceivedDate() { return receivedDate; }
    public void setReceivedDate(Date receivedDate) { this.receivedDate = receivedDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getFile() { return file; }
    public void setFile(String file) { this.file = file; }
}
