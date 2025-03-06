<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Loại Công Văn</title>
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
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
        }
        input:focus {
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
            text-decoration: none;
            display: inline-block;
        }
        .btn-submit {
            background-color: #28a745;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        .btn-back {
            background-color: #1a2035;
        }
        .btn-back:hover {
            background-color: #3a3f54;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Thêm Loại Công Văn</h2>
        <form action="<%= request.getContextPath() %>/document-types/add" method="post">

            <label for="typeName">Tên loại:</label>
            <input type="text" id="typeName" name="typeName" required>
            <div class="btn-container">
                <button type="submit" class="btn btn-submit">Thêm</button>
                <a href="<%= request.getContextPath() %>/document-types" class="btn btn-back">Quay lại danh sách</a>

            </div>
        </form>
    </div>
</body>
</html>
