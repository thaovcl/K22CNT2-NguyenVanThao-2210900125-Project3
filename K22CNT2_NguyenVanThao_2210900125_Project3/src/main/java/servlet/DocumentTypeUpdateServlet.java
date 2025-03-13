package servlet;

import dao.DocumentTypeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/document-types/update")
public class DocumentTypeUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int typeID = Integer.parseInt(request.getParameter("typeID"));
        String typeName = request.getParameter("typeName");
        String documentType = request.getParameter("documentType"); // Lấy giá trị Incoming / Outgoing

        // Kiểm tra nếu giá trị documentType hợp lệ
        if (!"Incoming".equals(documentType) && !"Outgoing".equals(documentType)) {
            response.sendRedirect(request.getContextPath() + "/document-types?error=InvalidType");
            return;
        }

        DocumentTypeDAO documentTypeDAO = new DocumentTypeDAO();
        documentTypeDAO.updateDocumentType(typeID, typeName, documentType);

        response.sendRedirect(request.getContextPath() + "/document-types");
    }
}
