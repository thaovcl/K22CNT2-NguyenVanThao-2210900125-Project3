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
        int userID = Integer.parseInt(request.getParameter("userID"));
        User user = new User(userID, request.getParameter("username"), request.getParameter("password"),
                request.getParameter("email"), request.getParameter("fullname"), null, Integer.parseInt(request.getParameter("roleID")));
        new UserDAO().updateUser(user);
        response.sendRedirect("UserList");
    }
}
