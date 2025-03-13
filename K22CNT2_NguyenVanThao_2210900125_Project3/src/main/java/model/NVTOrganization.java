package model;

public class NVTOrganization {
    private int organizationID;
    private String organizationName;

    public NVTOrganization() {}

    public NVTOrganization(int organizationID, String organizationName) {
        this.organizationID = organizationID;
        this.organizationName = organizationName;
    }

    public int getOrganizationID() { return organizationID; }
    public void setOrganizationID(int organizationID) { this.organizationID = organizationID; }

    public String getOrganizationName() { return organizationName; }
    public void setOrganizationName(String organizationName) { this.organizationName = organizationName; }
}
