package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.UserDAO;
import model.User;

@WebServlet("/UpdateUser")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullname");
            int roleID = Integer.parseInt(request.getParameter("roleID"));

            User user = new User(userID, username, "", email, fullName, null, roleID);
            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(user);

            response.sendRedirect("UserList");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserList?error=update_failed");
        }
    }
}
