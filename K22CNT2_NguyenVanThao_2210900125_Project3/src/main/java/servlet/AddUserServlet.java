package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.UserDAO;
import model.User;

@WebServlet("/AddUser")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());
        User user = new User(0, request.getParameter("username"), request.getParameter("password"),
                request.getParameter("email"), request.getParameter("fullname"), createdAt, 2);
        new UserDAO().addUser(user);
        response.sendRedirect("UserList");
    }
}
