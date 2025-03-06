package servlet;

import dao.DocumentTypeDAO;
import model.DocumentType;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/document-types")
public class DocumentTypeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DocumentTypeDAO documentTypeDAO = new DocumentTypeDAO();
        List<DocumentType> documentTypes = documentTypeDAO.getAllDocumentTypes();

        request.setAttribute("documentTypes", documentTypes);
        request.getRequestDispatcher("document-types/documentTypeList.jsp").forward(request, response);
    }
}
