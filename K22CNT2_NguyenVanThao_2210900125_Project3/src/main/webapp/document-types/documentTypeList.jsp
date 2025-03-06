<%@ page import="java.util.List, model.DocumentType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Loại Công Văn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h1 {
            font-size: 2.5rem;
            color: #2d3436;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .table th {
            background-color: #2d3436;
            color: white;
        }
        .table td {
            border-bottom: 1px solid #ddd;
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
        <div class="header">
            <h1>Danh sách Loại Công Văn</h1>
            <p>Quản lý các loại công văn trong hệ thống</p>
        </div>
        <div class="mb-3 text-center">
            <a href="document-types/addDocumentType.jsp" class="btn btn-primary">Thêm Loại Công Văn</a>
            <a href="index.jsp" class="btn btn-back">Quay lại trang chủ</a>
        </div>
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Loại</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% List<DocumentType> list = (List<DocumentType>) request.getAttribute("documentTypes");
                   if (list != null && !list.isEmpty()) {
                       for (DocumentType dt : list) { %>
                <tr>
                    <td><%= dt.getTypeID() %></td>
                    <td><%= dt.getTypeName() %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/document-types/edit?id=<%= dt.getTypeID() %>" class="btn btn-warning">Sửa</a>
                        <a href="document-types/delete?id=<%= dt.getTypeID() %>" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="3" class="text-center text-danger fw-bold">Không có dữ liệu.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
