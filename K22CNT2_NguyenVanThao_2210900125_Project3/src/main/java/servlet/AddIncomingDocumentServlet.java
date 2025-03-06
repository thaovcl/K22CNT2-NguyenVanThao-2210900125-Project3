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

@WebServlet("/add-incoming-document")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AddIncomingDocumentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DocumentIncomingDAO documentDAO = new DocumentIncomingDAO();

        String code = request.getParameter("code");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Date receivedDate = Date.valueOf(request.getParameter("receivedDate"));
        String status = request.getParameter("status");
        int createdBy = Integer.parseInt(request.getParameter("createdBy"));

        // Xử lý file upload
        Part filePart = request.getPart("file");
        String fileName = null;
        String filePath = null;

        if (filePart != null && filePart.getSize() > 0) { // Chỉ xử lý nếu có file
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // Tạo thư mục nếu chưa có
            }

            filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
        }

        // Lưu thông tin vào database
        DocumentIncoming doc = new DocumentIncoming();
        doc.setCode(code);
        doc.setTitle(title);
        doc.setContent(content);
        doc.setReceivedDate(receivedDate);
        doc.setStatus(status);
        doc.setCreatedBy(createdBy);

        if (fileName != null) { // Chỉ lưu file vào database nếu có
            doc.setFile("uploads/" + fileName);
        } else {
            doc.setFile(null); // Nếu không có file, để null hoặc chuỗi rỗng
        }

        documentDAO.insertDocument(doc);
        response.sendRedirect("incoming-documents");
    }
}
