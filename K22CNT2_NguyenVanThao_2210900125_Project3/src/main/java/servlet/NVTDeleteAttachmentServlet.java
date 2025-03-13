package servlet;

import dao.NVTAttachmentDAO;
import util.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/NVTDeleteAttachment")
public class NVTDeleteAttachmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID của file cần xóa
            int attachmentId = Integer.parseInt(request.getParameter("attachmentId"));
            String documentId = request.getParameter("documentId"); // Giữ lại documentId để redirect

            try (Connection conn = DatabaseConnection.getConnection()) {
                NVTAttachmentDAO attachmentDAO = new NVTAttachmentDAO(conn);

                // Lấy đường dẫn file từ database
                String filePath = attachmentDAO.getFilePathById(attachmentId);
                if (filePath != null) {
                    File file = new File(filePath);
                    if (file.exists()) {
                        file.delete(); // Xóa file khỏi hệ thống
                    }
                }

                // Xóa khỏi database
                attachmentDAO.deleteAttachment(attachmentId);
            }

            // Chuyển hướng về danh sách file
            response.sendRedirect("document_details.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
