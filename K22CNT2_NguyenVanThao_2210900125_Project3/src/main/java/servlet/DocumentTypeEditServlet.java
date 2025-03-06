package servlet;

import dao.DocumentTypeDAO;
import model.DocumentType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/document-types/edit")
public class DocumentTypeEditServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int typeID = Integer.parseInt(request.getParameter("id"));

        DocumentTypeDAO documentTypeDAO = new DocumentTypeDAO();
        DocumentType documentType = documentTypeDAO.getDocumentTypeByID(typeID);

        request.setAttribute("documentType", documentType);
        request.getRequestDispatcher("/document-types/editDocumentType.jsp").forward(request, response);
    }
}
