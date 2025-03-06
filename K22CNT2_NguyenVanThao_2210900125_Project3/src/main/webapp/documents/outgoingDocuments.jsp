<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,model.DocumentOutgoing" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Công Văn Đi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            <h1>Công Văn Đi</h1>
            <p>Quản lý công văn đi trong hệ thống</p>
        </div>
        <div class="mb-3 text-center">
            <a href="documents/addOutgoingDocument.jsp" class="btn btn-primary">Thêm Công Văn</a>
            <a href="index.jsp" class="btn btn-back">Quay lại Trang Chủ</a>
        </div>
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Mã</th>
                    <th>Tiêu Đề</th>
                    <th>Ngày Gửi</th>
                    <th>Trạng Thái</th>
                    <th>Người Tạo</th>
                    <th>Tệp Đính Kèm</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<DocumentOutgoing> documents = (List<DocumentOutgoing>) request.getAttribute("outgoingDocuments");
                if (documents != null) {
                    for (DocumentOutgoing doc : documents) {
                %>
                <tr>
                    <td><%= doc.getId() %></td>
                    <td><%= doc.getCode() %></td>
                    <td><%= doc.getTitle() %></td>
                    <td><%= doc.getSentDate() %></td>
                    <td>
						    <%
						        String status = doc.getStatus();
						        String statusVietnamese = "";
						        switch (status) {
						            case "Pending":
						                statusVietnamese = "Chờ xử lý";
						                break;
						            case "Processing":
						                statusVietnamese = "Đang xử lý";
						                break;
						            case "Completed":
						                statusVietnamese = "Hoàn thành";
						                break;
						            case "Received":
						                statusVietnamese = "Đã nhận";
						                break;
						            default:
						                statusVietnamese = "Không xác định";
						        }
						    %>
						    <%= statusVietnamese %>
						</td>
                    <td><%= doc.getCreatedBy() %></td>
                    <td>
                        <% if (doc.getFile() != null && !doc.getFile().isEmpty()) { %>
                            <a href="<%= doc.getFile() %>" target="_blank">Tải Xuống</a>
                        <% } else { %>
                            Không Có Tệp
                        <% } %>
                    </td>
                    <td>
                        <a href="edit-document?id=<%= doc.getId() %>" class="btn btn-warning">Sửa</a>
                        <a href="delete-document?id=<%= doc.getId() %>" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa công văn này?')">Xóa</a>
                    </td>
                </tr>
                <%
                    }
                } else { %>
                <tr>
                    <td colspan="8" class="text-center text-danger fw-bold">Không có dữ liệu.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
