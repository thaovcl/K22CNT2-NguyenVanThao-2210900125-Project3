package servlet;

import dao.DocumentOutgoingDAO;
import model.DocumentOutgoing;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit-document")
public class EditOutgoingDocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        DocumentOutgoingDAO documentDAO = new DocumentOutgoingDAO();
        DocumentOutgoing doc = documentDAO.getDocumentById(id);

        request.setAttribute("document", doc);
        request.getRequestDispatcher("/documents/editOutgoingDocument.jsp").forward(request, response);
    }
}
