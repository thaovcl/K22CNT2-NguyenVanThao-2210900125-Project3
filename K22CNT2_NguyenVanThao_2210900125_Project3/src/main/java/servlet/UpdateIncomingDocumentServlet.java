package servlet;

import dao.DocumentIncomingDAO;
import model.DocumentIncoming;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;

@WebServlet("/update-incoming-document")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateIncomingDocumentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DocumentIncomingDAO documentDAO = new DocumentIncomingDAO();

            int id = Integer.parseInt(request.getParameter("id"));
            String code = request.getParameter("code");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String receivedDateStr = request.getParameter("receivedDate");
            Date receivedDate = (receivedDateStr != null && !receivedDateStr.isEmpty()) ? Date.valueOf(receivedDateStr) : null;
            String status = request.getParameter("status");
            String createdByStr = request.getParameter("createdBy");
            int createdBy = (createdByStr != null && !createdByStr.isEmpty()) ? Integer.parseInt(createdByStr) : 0;


            // Lấy tài liệu cũ từ database
            DocumentIncoming existingDoc = documentDAO.getDocumentById(id);
            String filePath = existingDoc.getFile(); // Giữ nguyên file cũ nếu không có file mới

            // Xử lý file upload nếu có file mới
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) { // Nếu có file mới
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // Tạo thư mục nếu chưa có
                }

                filePath = "uploads/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            }

            // Cập nhật tài liệu
            DocumentIncoming updatedDoc = new DocumentIncoming();
            updatedDoc.setId(id);
            updatedDoc.setCode(code);
            updatedDoc.setTitle(title);
            updatedDoc.setContent(content);
            updatedDoc.setReceivedDate(receivedDate);
            updatedDoc.setStatus(status);
            updatedDoc.setCreatedBy(createdBy);
            updatedDoc.setFile(filePath); // Giữ nguyên file cũ nếu không có file mới

            documentDAO.updateDocument(updatedDoc);
            response.sendRedirect("incoming-documents");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("incoming-documents?error=1");
        }
    }
}
