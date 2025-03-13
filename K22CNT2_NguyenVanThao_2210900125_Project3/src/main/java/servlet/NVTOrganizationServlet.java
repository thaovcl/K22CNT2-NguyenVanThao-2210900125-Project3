package servlet;

import dao.NVTOrganizationDAO;
import model.NVTOrganization;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/NVTOrganizationList")
public class NVTOrganizationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NVTOrganizationDAO organizationDAO = new NVTOrganizationDAO();
        List<NVTOrganization> organizations = organizationDAO.listAllOrganizations();
        request.setAttribute("organizations", organizations);
        request.getRequestDispatcher("organization/nvt_organizations.jsp").forward(request, response);
    }
}
