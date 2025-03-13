<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<html>
<head>
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="assets/css/login.css" />
</head>
<body>
    <!-- Wrapper for centering the form -->
    <div class="center-wrapper">
        <div class="container">
            <form action="LoginServlet" method="POST" class="form">
                <h3 class="heading">Đăng nhập</h3>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
                <% } %>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="text" placeholder="Nhập email" required>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input id="password" name="password" type="password" placeholder="Nhập mật khẩu" required>
                </div>

                <button type="submit" class="form-submit">Đăng nhập</button>

                <div class="back-forgot-container">
				    <a href="index.jsp" class="back-button">← Quay lại</a>
				    <div class="forgot-password">
				        <a href="#">Quên mật khẩu?</a>
				    </div>
				</div>
            </form>
        </div>
    </div>
</body>
</html>
