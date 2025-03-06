package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.UserDAO;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(email, password);

        if (user != null) {
            System.out.println("User found: " + user.getUsername() + " - RoleID: " + user.getRoleID());

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("roleId", user.getRoleID());

            System.out.println("Đăng nhập thành công - roleId: " + user.getRoleID());

            // Điều hướng theo RoleID
            if (user.getRoleID() != 0 ) {
                response.sendRedirect("index.jsp"); // Chuyển đến trang admin
            } 
        } else {
            System.out.println("Login failed: Invalid email or password");
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
