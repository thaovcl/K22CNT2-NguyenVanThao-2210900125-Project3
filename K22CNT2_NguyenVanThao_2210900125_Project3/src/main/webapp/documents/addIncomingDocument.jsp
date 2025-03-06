<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Công Văn Đến</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 30px;
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
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
        }
        input:focus, select:focus, textarea:focus {
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
        .btn-success {
            background-color: #996633;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-success:hover {
            background-color: #af875f;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Thêm Công Văn Đến</h2>
        <form action="/K22CNT2_NguyenVanThao_2210900125_Project3/add-incoming-document" method="post" enctype="multipart/form-data">

            <label>Mã Công Văn:</label>
            <input type="text" name="code" required>

            <label>Tiêu Đề:</label>
            <input type="text" name="title" required>

            <label>Nội Dung:</label>
            <textarea name="content" required></textarea>

            <label>Ngày Nhận:</label>
            <input type="date" name="receivedDate" required>

            <label>Trạng Thái:</label>
            <select name="status">
                <option value="Pending">Chờ xử lý</option>
                <option value="Processing">Đang xử lý</option>
                <option value="Completed">Hoàn thành</option>
                <option value="Received">Đã nhận</option>
            </select>

            <label>Người Tạo (Mã Người Dùng):</label>
            <select name="createdBy" required>
                <option value="1">1</option>
                <option value="2">2</option>
            </select>

            <label>Đính Kèm Tệp:</label>
            <input type="file" name="file">

            <div class="btn-container">
                <button type="submit" class="btn btn-success">Thêm Công Văn</button>
                <a href="incoming-documents" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>
