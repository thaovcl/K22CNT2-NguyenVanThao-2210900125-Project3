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

@WebServlet("/NVTEditAttachment")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,     // 10MB
                 maxRequestSize = 1024 * 1024 * 50)  // 50MB
public class NVTEditAttachmentServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int attachmentId;
        try {
            attachmentId = Integer.parseInt(request.getParameter("attachmentId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi: attachmentId không hợp lệ");
            return;
        }

        Part filePart = request.getPart("file");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi: Không có file nào được chọn");
            return;
        }

        String newFileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String newFilePath = uploadPath + File.separator + newFileName;
        filePart.write(newFilePath);

        try (Connection conn = DatabaseConnection.getConnection()) {
            NVTAttachmentDAO attachmentDAO = new NVTAttachmentDAO(conn);
            boolean updated = attachmentDAO.updateAttachmentFile(attachmentId, newFileName, "uploads/" + newFileName);

            if (updated) {
                response.sendRedirect("NVTListAttachments");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cập nhật file thất bại");
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi cập nhật file đính kèm", e);
        }
    }
}


