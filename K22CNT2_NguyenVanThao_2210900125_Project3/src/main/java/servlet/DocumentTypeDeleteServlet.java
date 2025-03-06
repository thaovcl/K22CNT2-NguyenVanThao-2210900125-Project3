package servlet;

import dao.DocumentTypeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/document-types/delete")
public class DocumentTypeDeleteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int typeID = Integer.parseInt(request.getParameter("id"));

        DocumentTypeDAO documentTypeDAO = new DocumentTypeDAO();
        documentTypeDAO.deleteDocumentType(typeID);

        response.sendRedirect(request.getContextPath() + "/document-types");
    }
}
