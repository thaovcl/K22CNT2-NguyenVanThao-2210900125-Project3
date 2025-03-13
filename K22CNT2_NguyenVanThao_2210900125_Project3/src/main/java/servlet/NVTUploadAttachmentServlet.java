package servlet;

import dao.NVTAttachmentDAO;
import model.NVTAttachment;
import util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/NVTUploadAttachment")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,     // 10MB
                 maxRequestSize = 1024 * 1024 * 50)  // 50MB
public class NVTUploadAttachmentServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int documentId = Integer.parseInt(request.getParameter("documentId"));
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        String documentType = request.getParameter("documentType");

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        try (Connection conn = DatabaseConnection.getConnection()) {
            NVTAttachmentDAO attachmentDAO = new NVTAttachmentDAO(conn);
            NVTAttachment attachment = new NVTAttachment(0, documentId, fileName, "uploads/" + fileName, 1, null, documentType);
            attachmentDAO.saveAttachment(attachment);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("attachments/document_details.jsp?documentId=" + documentId);
    }
}
