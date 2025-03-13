package servlet;

import util.DatabaseConnection;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NVTDownloadAttachment")
public class NVTDownloadAttachmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int attachmentId = Integer.parseInt(request.getParameter("attachmentId"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT NVT_FileName, NVT_FilePath FROM nvt_attachments WHERE NVT_AttachmentID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, attachmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String fileName = rs.getString("NVT_FileName");
                String filePath = rs.getString("NVT_FilePath");
                
                File file = new File(filePath);
                if (!file.exists()) {
                    response.getWriter().println("File không tồn tại.");
                    return;
                }

                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

                try (FileInputStream in = new FileInputStream(file);
                     OutputStream out = response.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
