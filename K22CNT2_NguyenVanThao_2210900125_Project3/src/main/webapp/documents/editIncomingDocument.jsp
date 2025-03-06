<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DocumentIncoming" %>
<%
    DocumentIncoming doc = (DocumentIncoming) request.getAttribute("editdocument");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa công văn đến</title>
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
        input, textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
        }
        input:focus, textarea:focus, select:focus {
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
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #996633;
        }
        .btn-primary:hover {
            background-color: #af875f;
        }
        .btn-secondary {
            background-color: #333;
        }
        .btn-secondary:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chỉnh sửa công văn đến</h2>
        <form action="update-incoming-document" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= doc.getId() %>">
            
            <label for="code">Mã công văn:</label>
            <input type="text" id="code" name="code" value="<%= doc.getCode() %>" required>

            <label for="title">Tiêu đề:</label>
            <input type="text" id="title" name="title" value="<%= doc.getTitle() %>" required>

            <label for="content">Nội dung:</label>
            <textarea id="content" name="content" required><%= doc.getContent() %></textarea>

            <label for="receivedDate">Ngày nhận:</label>
            <input type="date" id="receivedDate" name="receivedDate" value="<%= doc.getReceivedDate() %>" required>

            <label for="status">Trạng thái:</label>
			<select id="status" name="status" required>
			    <option value="Pending" <%= doc.getStatus().equals("Pending") ? "selected" : "" %>>Chờ xử lý</option>
			    <option value="Processing" <%= doc.getStatus().equals("Processing") ? "selected" : "" %>>Đang xử lý</option>
			    <option value="Completed" <%= doc.getStatus().equals("Completed") ? "selected" : "" %>>Hoàn thành</option>
			    <option value="Received" <%= doc.getStatus().equals("Received") ? "selected" : "" %>>Đã nhận</option>
			</select>


            <label for="createdBy">Người tạo:</label>
            <input type="number" id="createdBy" name="createdBy" value="<%= doc.getCreatedBy() %>" required>

            <label for="file">Tệp đính kèm:</label>
            <input type="file" id="file" name="file">

            <% if (doc.getFile() != null && !doc.getFile().isEmpty()) { %>
                <p>File hiện tại: <a href="<%= doc.getFile() %>" target="_blank">Xem file</a></p>
            <% } %>

            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <a href="incoming-documents" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>