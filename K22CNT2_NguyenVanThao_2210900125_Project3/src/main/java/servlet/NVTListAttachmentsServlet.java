package servlet;

import dao.NVTAttachmentDAO;
import model.NVTAttachment;
import util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/NVTListAttachments")
public class NVTListAttachmentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String docIdParam = request.getParameter("documentId");

        List<NVTAttachment> attachments;
        try (Connection conn = DatabaseConnection.getConnection()) {
            NVTAttachmentDAO attachmentDAO = new NVTAttachmentDAO(conn);

            if (docIdParam != null && !docIdParam.trim().isEmpty()) {
                try {
                    int documentId = Integer.parseInt(docIdParam);
                    attachments = attachmentDAO.getAttachmentsByDocumentId(documentId);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Giá trị documentId không hợp lệ");
                    return;
                }
            } else {
                // Nếu không có documentId, lấy toàn bộ file
                attachments = attachmentDAO.getAllAttachments();
            }

            request.setAttribute("attachments", attachments);
            request.getRequestDispatcher("attachments/list_attachments.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }
}




