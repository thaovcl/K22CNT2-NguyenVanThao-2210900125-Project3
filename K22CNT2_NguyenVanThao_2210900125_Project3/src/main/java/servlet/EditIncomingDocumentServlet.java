package servlet;

import dao.DocumentIncomingDAO;
import model.DocumentIncoming;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit-incoming-document")
public class EditIncomingDocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        DocumentIncomingDAO documentDAO = new DocumentIncomingDAO();
        DocumentIncoming doc = documentDAO.getDocumentById(id);

        request.setAttribute("editdocument", doc);
        request.getRequestDispatcher("/documents/editIncomingDocument.jsp").forward(request, response);
    }
}