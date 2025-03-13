package servlet;

import dao.NVTOrganizationDAO;
import model.NVTOrganization;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/NVTAddOrganization")
public class NVTAddOrganizationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận dữ liệu tiếng Việt đúng
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String organizationName = request.getParameter("organizationName");

        if (organizationName != null && !organizationName.trim().isEmpty()) {
            NVTOrganization organization = new NVTOrganization();
            organization.setOrganizationName(organizationName);

            NVTOrganizationDAO organizationDAO = new NVTOrganizationDAO();
            organizationDAO.addOrganization(organization);
        }

        response.sendRedirect("NVTOrganizationList");
    }
}

