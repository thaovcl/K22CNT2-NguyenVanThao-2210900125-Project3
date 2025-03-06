<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.DocumentType" %>

<%
    DocumentType documentType = (DocumentType) request.getAttribute("documentType");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<form action="<%= request.getContextPath() %>/document-types/edit" method="post">

    <input type="hidden" name="typeID" value="<%= documentType.getTypeID() %>">
    <label>Tên loại:</label>
    <input type="text" name="typeName" value="<%= documentType.getTypeName() %>" required>
    <button type="submit">Cập nhật</button>
</form>

	
</body>
</html>