package servlet;

import dao.DocumentOutgoingDAO;
import model.DocumentOutgoing;

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

@WebServlet("/update-document")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateOutgoingDocumentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DocumentOutgoingDAO documentDAO = new DocumentOutgoingDAO();

        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Date sentDate = Date.valueOf(request.getParameter("sentDate"));
        String status = request.getParameter("status");
        int createdBy = Integer.parseInt(request.getParameter("createdBy"));

        // Lấy thông tin tài liệu cũ
        DocumentOutgoing existingDoc = documentDAO.getDocumentById(id);
        String filePath = existingDoc.getFile(); // Giữ nguyên file cũ

        // Xử lý file upload nếu có file mới
        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            filePath = "uploads/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Cập nhật tài liệu
        DocumentOutgoing updatedDoc = new DocumentOutgoing();
        updatedDoc.setId(id);
        updatedDoc.setCode(code);
        updatedDoc.setTitle(title);
        updatedDoc.setContent(content);
        updatedDoc.setSentDate(sentDate);
        updatedDoc.setStatus(status);
        updatedDoc.setCreatedBy(createdBy);
        updatedDoc.setFile(filePath);

        documentDAO.updateDocument(updatedDoc);
        response.sendRedirect("outgoing-documents");
    }
}
