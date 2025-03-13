package model;

public class DocumentType {
    private int typeID;
    private String typeName;
    private String documentType; // Thêm biến để lưu 'Incoming' hoặc 'Outgoing'

    public DocumentType(int typeID, String typeName, String documentType) {
        this.typeID = typeID;
        this.typeName = typeName;
        this.documentType = documentType;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }
}
