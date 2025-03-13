package servlet;

import dao.NVTOrganizationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/NVTDeleteOrganization")
public class NVTDeleteOrganizationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int organizationID = Integer.parseInt(request.getParameter("id"));

        NVTOrganizationDAO organizationDAO = new NVTOrganizationDAO();
        organizationDAO.deleteOrganization(organizationID);

        response.sendRedirect("NVTOrganizationList");
    }
}
