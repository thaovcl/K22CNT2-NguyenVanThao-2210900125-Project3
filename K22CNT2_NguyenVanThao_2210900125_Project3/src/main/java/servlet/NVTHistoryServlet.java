package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.NVTDocumentHistoryDAO;
import model.NVTDocumentHistory;

@WebServlet("/HistoryList")
public class NVTHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String docIdParam = request.getParameter("documentId");
        List<NVTDocumentHistory> historyList;

        if (docIdParam != null && !docIdParam.isEmpty()) {
            try {
                int documentId = Integer.parseInt(docIdParam);
                historyList = new NVTDocumentHistoryDAO().getHistoryByDocumentId(documentId);
                request.setAttribute("documentId", documentId);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID tài liệu không hợp lệ!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
        } else {
            // Nếu không có documentId, lấy toàn bộ lịch sử
            historyList = new NVTDocumentHistoryDAO().getAllHistory();
            request.setAttribute("documentId", null);
        }

        request.setAttribute("historyList", historyList);
        request.getRequestDispatcher("attachments/nvt_document_history.jsp").forward(request, response);
    }
}
