package servlet;

import dao.DocumentIncomingDAO;
import model.DocumentIncoming;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/incoming-documents")
public class IncomingDocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DocumentIncomingDAO documentDAO = new DocumentIncomingDAO();
        List<DocumentIncoming> incomingDocuments = documentDAO.getIncomingDocuments();

        request.setAttribute("incomingDocuments", incomingDocuments);
        request.getRequestDispatcher("/documents/incomingDocuments.jsp").forward(request, response);
    }
    
}
