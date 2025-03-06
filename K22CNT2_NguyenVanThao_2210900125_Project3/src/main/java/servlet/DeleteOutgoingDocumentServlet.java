package servlet;

import dao.DocumentOutgoingDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-document")
public class DeleteOutgoingDocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            DocumentOutgoingDAO documentDAO = new DocumentOutgoingDAO();
            documentDAO.deleteDocument(id);
            response.sendRedirect("outgoing-documents"); // Quay về danh sách sau khi xóa
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("outgoing-documents?error=1");
        }
    }
}
