package servlet;

import dao.NVTOrganizationDAO;
import model.NVTOrganization;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/NVTUpdateOrganization")
public class NVTUpdateOrganizationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int organizationID = Integer.parseInt(request.getParameter("organizationID"));
        String organizationName = request.getParameter("organizationName");

        if (organizationName != null && !organizationName.trim().isEmpty()) {
            NVTOrganization organization = new NVTOrganization(organizationID, organizationName);
            
            NVTOrganizationDAO organizationDAO = new NVTOrganizationDAO();
            organizationDAO.updateOrganization(organization);
        }

        response.sendRedirect("NVTOrganizationList");
    }
}
