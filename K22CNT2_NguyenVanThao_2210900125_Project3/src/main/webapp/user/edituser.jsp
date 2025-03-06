<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.UserDAO, model.User" %>

<%
    int userID = Integer.parseInt(request.getParameter("userID"));
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserByID(userID);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
        }
        .container {
            width: 35%;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            text-align: left;
            margin: 10px 0 5px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
        }
        input:focus, select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }
        .btn-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            width: 150px;
            padding: 10px;
            font-size: 14px;
            text-align: center;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
            color: white;
            background-color: #996633;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #af875f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chỉnh sửa thông tin người dùng</h2>
        <form action="UpdateUser" method="post">
            <input type="hidden" name="userID" value="<%= user.getUserID() %>">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" value="">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>

            <label for="fullname">Họ tên:</label>
            <input type="text" id="fullname" name="fullname" value="<%= user.getFullName() %>" required>

            <label for="roleID">Vai trò:</label>
            <select id="roleID" name="roleID">
                <option value="1" <%= user.getRoleID() == 1 ? "selected" : "" %>>Admin</option>
                <option value="2" <%= user.getRoleID() == 2 ? "selected" : "" %>>User</option>
            </select>

            <div class="btn-container">
                <input type="submit" class="btn" value="Cập nhật">
                <a href="<%= request.getContextPath() %>/UserList" class="btn">Quay lại</a>
            </div>
        </form>
    </div>
</body>
</html>
