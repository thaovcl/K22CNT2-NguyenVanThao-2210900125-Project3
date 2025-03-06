package servlet;

import dao.DocumentOutgoingDAO;
import model.DocumentOutgoing;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/outgoing-documents")
public class OutgoingDocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DocumentOutgoingDAO documentDAO = new DocumentOutgoingDAO();
        List<DocumentOutgoing> outgoingDocuments = documentDAO.getOutgoingDocuments();

        request.setAttribute("outgoingDocuments", outgoingDocuments);
        request.getRequestDispatcher("/documents/outgoingDocuments.jsp").forward(request, response);
    }
}
