package servlet;

import dao.DocumentIncomingDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-incoming-document")
public class DeleteIncomingDocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            DocumentIncomingDAO documentDAO = new DocumentIncomingDAO();
            documentDAO.deleteDocument(id);
            response.sendRedirect("incoming-documents"); // Quay về danh sách sau khi xóa
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("incoming-documents?error=1");
        }
    }
}