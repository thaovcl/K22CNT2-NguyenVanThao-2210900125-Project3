<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng</title>
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
            margin-top: 10px;
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
        .btn-submit {
            background-color: #28a745;
            color: white;
        }
        .btn-primary {
            background-color: #996633;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #af875f;
        }
        .btn-back {
            background-color: #1a2035;
            border: none;
            color: #fff;
        }
        .btn-back:hover {
            background-color: #3a3f54;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Thêm Người Dùng</h2>
        <form action="AddUser" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="fullname">Họ và Tên:</label>
            <input type="text" id="fullname" name="fullname" required>
            
            <label for="role">Vai trò:</label>
            <select id="role" name="roleID">
                <option value="2">User</option>
                <option value="1">Admin</option>
            </select>
            
            <div class="btn-container">
                <input type="submit" class="btn btn-primary" value="Thêm Người Dùng">
                <a href="UserList" class="btn btn-back">Quay lại danh sách</a>
            </div>
        </form>
    </div>
</body>
</html>