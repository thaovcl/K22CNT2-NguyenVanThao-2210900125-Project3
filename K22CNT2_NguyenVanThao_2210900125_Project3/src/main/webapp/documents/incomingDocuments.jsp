<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,java.sql.*,java.util.ArrayList,java.util.List,model.NVTDocument" %>
<%@ page session="true" %>

<%@ page import="java.util.List,model.DocumentIncoming" %>
  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <title>Quản Lý Công Văn Đến Công Văn Đi - Nguyễn Văn Thạo</title>
      <meta
        content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
        name="viewport"
      />
      <link
        rel="icon"
        href="assets/img/kaiadmin/favicon.ico"
        type="image/x-icon"
      />

      <!-- Fonts and icons -->
      <script src="assets/js/plugin/webfont/webfont.min.js"></script>
      <script>
        WebFont.load({
          google: { families: ["Public Sans:300,400,500,600,700"] },
          custom: {
            families: [
              "Font Awesome 5 Solid",
              "Font Awesome 5 Regular",
              "Font Awesome 5 Brands",
              "simple-line-icons",
            ],
            urls: ["assets/css/fonts.min.css"],
          },
          active: function () {
            sessionStorage.fonts = true;
          },
        });
      </script>

      <!-- CSS Files -->
      <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
      <link rel="stylesheet" href="assets/css/plugins.min.css" />
      <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />
      <link rel="stylesheet" href="assets/css/header.css" />
      <link rel="stylesheet" href="assets/css/login.css" />

      <!-- CSS Just for demo purpose, don't include it in your project -->
      <link rel="stylesheet" href="assets/css/demo.css" />
    </head>
    <body>
      <div class="wrapper">
	        <!-- Sidebar -->
	        <div class="sidebar" data-background-color="dark">
	          <div class="sidebar-logo">
	            <!-- Logo Header -->
	            <div class="logo-header" data-background-color="dark">
	              <a href="index.jsp" class="logo">
	                <h5 style="color: aliceblue; margin: auto;">Quản Lý Công Văn</h5>
	              </a>
	              <div class="nav-toggle">
	                <button class="btn btn-toggle toggle-sidebar">
	                  <i class="gg-menu-right"></i>
	                </button>
	                <button class="btn btn-toggle sidenav-toggler">
	                  <i class="gg-menu-left"></i>
	                </button>
	              </div>
	              <button class="topbar-toggler more">
	                <i class="gg-more-vertical-alt"></i>
	              </button>
	            </div>
	            <!-- End Logo Header -->
	          </div>
	          <div class="sidebar-wrapper scrollbar scrollbar-inner">
	            <div class="sidebar-content">
	              <ul class="nav nav-secondary">
	                <li class="nav-item active">
	                  <a href="index.jsp" class="collapsed" aria-expanded="false">
	                      <i class="fas fa-home"></i>
	                      <p>Trang chủ</p>
	                  </a>
	                </li>
	              
	                <li class="nav-section">
	                    <span class="sidebar-mini-icon"><i class="fa fa-ellipsis-h"></i></span>
	                    <h4 class="text-section">Quản lý văn bản</h4>
	                </li>
	                
	                <li class="nav-item">
					    <a href="index.jsp" id="alldocuments" onclick="searchDocuments()">
					        <i class="fas fa-layer-group"></i>
					        <p>Tất cả văn bản</p>
					    </a>
					</li>
	                
	                <li class="nav-item">
	                    <a href="#" onclick="return checkLogin('document-types');">
	                        <i class="fas fa-th-list"></i>
	                        <p>Loại văn bản</p>
	                    </a>
	                </li>
	                
	                <li class="nav-item">
					    <a href="#" onclick="return checkLogin('outgoing-documents');">
					        <i class="fas fa-paper-plane"></i>
					        <p>Văn bản đi</p>
					    </a>
					</li>
					
					<li class="nav-item">
					    <a href="#" onclick="return checkLogin('incoming-documents');">
					        <i class="fas fa-inbox"></i>
					        <p>Văn bản đến</p>
					    </a>
					</li>
	                
	                <li class="nav-section">
	                    <span class="sidebar-mini-icon"><i class="fa fa-ellipsis-h"></i></span>
	                    <h4 class="text-section">Quản lý khác</h4>
	                </li>
	                
	                <li class="nav-item">
					    <a href="#" onclick="return checkLogin('NVTOrganizationList');">
					        <i class="fas fa-inbox"></i>
					        <p>Quản lý tổ chức</p>
					    </a>
					</li>
	                
	                <li class="nav-item">
					    <a href="#" onclick="return checkLogin('UserList', true);">
					        <i class="fas fa-user"></i>
					        <p>Quản lý người dùng</p>
					    </a>
					</li>
	                
	                <li class="nav-item">
	                    <a href="#">
	                        <i class="fas fa-key"></i>
	                        <p>Phân quyền</p>
	                    </a>
	                </li>
	                
	                <li class="nav-item">
					    <a href="#" onclick="return checkLogin('NVTListAttachments');">
					        <i class="fas fa-user"></i>
					        <p>Quản lý tệp đính kèm</p>
					    </a>
					</li>
	                
	                <li class="nav-item">
					    <a href="#" onclick="return checkLogin('HistoryList');">
					        <i class="fas fa-user"></i>
					        <p>Quản lý lịch sử văn bán</p>
					    </a>
					</li>
	                
	                <li class="nav-item">
	                    <a href="#">
	                        <i class="fas fa-bell"></i>
	                        <p>Thông báo</p>
	                    </a>
	                </li>
	                
	                <!-- Xử lý đăng nhập khi ấn vào menu -->
					<script>
					    function checkLogin(targetPage, isAdminRequired = false) {
					        var roleId = "<%= session.getAttribute("roleId") != null ? session.getAttribute("roleId") : "0" %>";
					        roleId = parseInt(roleId); // Chuyển thành số nguyên
					
					        if (roleId === 0) {
					            alert("Vui lòng đăng nhập để tiếp tục!");
					            window.location.href = "<%= request.getContextPath() %>/login.jsp";
					            return false;
					        }
					
					        // Chuyển hướng đến trang đích nếu đủ điều kiện
					        window.location.href = "<%= request.getContextPath() %>/" + targetPage;
					        return false;
					    }
					</script>
	              </ul>
	            </div>
	          </div>
	        </div>
	        <!-- End Sidebar -->
	
	        <div class="main-panel">
	          <div class="main-header">
	            <div class="main-header-logo">
	              <!-- Logo Header -->
	              <div class="logo-header" data-background-color="dark">
	                <a href="index.html" class="logo">
	                  <img
	                    src="assets/img/kaiadmin/logo_light.svg"
	                    alt="navbar brand"
	                    class="navbar-brand"
	                    height="20"
	                  />
	                </a>
	                <div class="nav-toggle">
	                  <button class="btn btn-toggle toggle-sidebar">
	                    <i class="gg-menu-right"></i>
	                  </button>
	                  <button class="btn btn-toggle sidenav-toggler">
	                    <i class="gg-menu-left"></i>
	                  </button>
	                </div>
	                <button class="topbar-toggler more">
	                  <i class="gg-more-vertical-alt"></i>
	                </button>
	              </div>
	              <!-- End Logo Header -->
	            </div>
	            <!-- Navbar Header -->
	            <nav
	              class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom"
	            >
	              <div class="container-fluid">
	                <nav
	                  class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"
	                >
	                  
	                </nav>
	
	                <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
	                  <li
	                    class="nav-item topbar-icon dropdown hidden-caret d-flex d-lg-none"
	                  >
	                    <a
	                      class="nav-link dropdown-toggle"
	                      data-bs-toggle="dropdown"
	                      href="#"
	                      role="button"
	                      aria-expanded="false"
	                      aria-haspopup="true"
	                    >
	                      <i class="fa fa-search"></i>
	                    </a>
	                    <ul class="dropdown-menu dropdown-search animated fadeIn">
	                      <form class="navbar-left navbar-form nav-search">
	                        <div class="input-group">
	                          <input
	                            type="text"
	                            placeholder="Search ..."
	                            class="form-control"
	                          />
	                        </div>
	                      </form>
	                    </ul>
	                  </li>
	                  <li class="nav-item topbar-icon dropdown hidden-caret">
	                    <a
	                      class="nav-link dropdown-toggle"
	                      href="#"
	                      id="messageDropdown"
	                      role="button"
	                      data-bs-toggle="dropdown"
	                      aria-haspopup="true"
	                      aria-expanded="false"
	                    >
	                      <i class="fa fa-envelope"></i>
	                    </a>
	                    <ul
	                      class="dropdown-menu messages-notif-box animated fadeIn"
	                      aria-labelledby="messageDropdown"
	                    >
	                      <li>
	                        <div
	                          class="dropdown-title d-flex justify-content-between align-items-center"
	                        >
	                          Messages
	                          <a href="#" class="small">Mark all as read</a>
	                        </div>
	                      </li>
	                      <li>
	                        <div class="message-notif-scroll scrollbar-outer">
	                          <div class="notif-center">
	                            <a href="#">
	                              <div class="notif-img">
	                                <img
	                                  src="assets/img/jm_denis.jpg"
	                                  alt="Img Profile"
	                                />
	                              </div>
	                              <div class="notif-content">
	                                <span class="subject">Jimmy Denis</span>
	                                <span class="block"> How are you ? </span>
	                                <span class="time">5 minutes ago</span>
	                              </div>
	                            </a>
	                          </div>
	                        </div>
	                      </li>
	                      <li>
	                        <a class="see-all" href="javascript:void(0);"
	                          >See all messages<i class="fa fa-angle-right"></i>
	                        </a>
	                      </li>
	                    </ul>
	                  </li>
	                  <li class="nav-item topbar-icon dropdown hidden-caret">
	                    <a
	                      class="nav-link dropdown-toggle"
	                      href="#"
	                      id="notifDropdown"
	                      role="button"
	                      data-bs-toggle="dropdown"
	                      aria-haspopup="true"
	                      aria-expanded="false"
	                    >
	                      <i class="fa fa-bell"></i>
	                      <span class="notification">4</span>
	                    </a>
	                    <ul
	                      class="dropdown-menu notif-box animated fadeIn"
	                      aria-labelledby="notifDropdown"
	                    >
	                      <li>
	                        <div class="dropdown-title">
	                          You have 4 new notification
	                        </div>
	                      </li>
	                      <li>
	                        <div class="notif-scroll scrollbar-outer">
	                          <div class="notif-center">
	                            <a href="#">
	                              <div class="notif-icon notif-success">
	                                <i class="fa fa-comment"></i>
	                              </div>
	                              <div class="notif-content">
	                                <span class="block">
	                                  Rahmad commented on Admin
	                                </span>
	                                <span class="time">12 minutes ago</span>
	                              </div>
	                            </a>
	                          </div>
	                        </div>
	                      </li>
	                      <li>
	                        <a class="see-all" href="javascript:void(0);"
	                          >See all notifications<i class="fa fa-angle-right"></i>
	                        </a>
	                      </li>
	                    </ul>
	                  </li>
	                  <li class="nav-item topbar-icon dropdown hidden-caret">
	                    <a
	                      class="nav-link"
	                      data-bs-toggle="dropdown"
	                      href="#"
	                      aria-expanded="false"
	                    >
	                      <i class="fas fa-layer-group"></i>
	                    </a>
	                    <div class="dropdown-menu quick-actions animated fadeIn">
	                      <div class="quick-actions-header">
	                        <span class="title mb-1">Quick Actions</span>
	                        <span class="subtitle op-7">Shortcuts</span>
	                      </div>
	                      <div class="quick-actions-scroll scrollbar-outer">
	                        <div class="quick-actions-items">
	                          <div class="row m-0">
	                            <a class="col-6 col-md-4 p-0" href="#">
	                              <div class="quick-actions-item">
	                                <div class="avatar-item bg-danger rounded-circle">
	                                  <i class="far fa-calendar-alt"></i>
	                                </div>
	                                <span class="text">Calendar</span>
	                              </div>
	                            </a>
	                            <a class="col-6 col-md-4 p-0" href="#">
	                              <div class="quick-actions-item">
	                                <div
	                                  class="avatar-item bg-warning rounded-circle"
	                                >
	                                  <i class="fas fa-map"></i>
	                                </div>
	                                <span class="text">Maps</span>
	                              </div>
	                            </a>
	                            <a class="col-6 col-md-4 p-0" href="#">
	                              <div class="quick-actions-item">
	                                <div class="avatar-item bg-info rounded-circle">
	                                  <i class="fas fa-file-excel"></i>
	                                </div>
	                                <span class="text">Reports</span>
	                              </div>
	                            </a>
	                          </div>
	                        </div>
	                      </div>
	                    </div>
	                  </li>
	
	                 <!-- Thông tin người dùng -->
			        <div class="user-info">
					    <%
					    			    			        if (session.getAttribute("user") != null) {
					    			    			            User loggedInUser = (User) session.getAttribute("user");
					    %>
					        <div id="userDropdown" class="user-dropdown">
					            <span id="username">Chào mừng, 👤 <%= loggedInUser.getFullName() %>!</span>
					            <a href="LogoutServlet" class="logout-btn">Đăng xuất</a>
					        </div>
					    <%
					        } else {
					    %>
					        <a href="#" class="login-btn" id="loginButton">Đăng nhập</a>
					    <%
					        }
					    %>
					</div>
	
	
	
	
	<script>
	    document.getElementById("loginButton").addEventListener("click", function(event) {
	        event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ <a>
	        window.location.href = "login.jsp"; // Chuyển hướng sang trang login.jsp
	    });
	</script>
	
	        
	                
	
	                </ul>
	              </div>
	            </nav>
	            <!-- End Navbar -->
	          </div>
	
	          <div class="header-parallax">
	            <img src="./assets/img/AI-qlcv.webp" alt="Header Image">
	        </div>
	        
	        <!-- Button Mở Modal -->
			<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDocumentModal">Thêm Công Văn</button>
	        
	        <table class="table table-bordered table-striped">
	            <thead>
	                <tr>
	                    <th>ID</th>
	                    <th>Mã</th>
	                    <th>Tiêu Đề</th>
	                    <th>Ngày Nhận</th>
	                    <th>Trạng Thái</th>
	                    <th>Người Nhận</th>
	                    <th>Tệp Đính Kèm</th>
	                    <th>Hành Động</th>
	                </tr>
	            </thead>
	            <tbody>
	                <%
	                List<DocumentIncoming> documents = (List<DocumentIncoming>) request.getAttribute("incomingDocuments");
	                if (documents != null) {
	                    for (DocumentIncoming doc : documents) {
	                %>
	                <tr>
	                    <td><%= doc.getId() %></td>
	                    <td><%= doc.getCode() %></td>
	                    <td><%= doc.getTitle() %></td>
	                    <td><%= doc.getReceivedDate() %></td>
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
						    <button class="btn btn-warning btn-edit" 
						        data-id="<%= doc.getId() %>" 
						        data-code="<%= doc.getCode() %>" 
						        data-title="<%= doc.getTitle() %>" 
						        data-content="<%= doc.getContent() %>" 
						        data-receiveddate="<%= doc.getReceivedDate() %>" 
						        data-status="<%= doc.getStatus() %>" 
						        data-createdby="<%= doc.getCreatedBy() %>" 
						        data-file="<%= doc.getFile() %>" 
						        data-bs-toggle="modal" 
						        data-bs-target="#editModal">
						        Sửa
						    </button>
					    	<a href="delete-incoming-document?id=<%= doc.getId() %>" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa công văn này?')">Xóa</a>
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
	        
			<!-- Modal Thêm Công Văn -->
			<div class="modal fade" id="addDocumentModal" tabindex="-1" aria-labelledby="addDocumentLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="addDocumentLabel">Thêm Công Văn Đến</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <form id="addDocumentForm" method="post" action="/K22CNT2_NguyenVanThao_2210900125_Project3/add-incoming-document" enctype="multipart/form-data">
			                <div class="modal-body">
			                    <div class="mb-3">
			                        <label for="code" class="form-label">Mã Công Văn:</label>
			                        <input type="text" class="form-control" id="code" name="code" required>
			                    </div>
			                    
			                    <div class="mb-3">
			                        <label for="title" class="form-label">Tiêu Đề:</label>
			                        <input type="text" class="form-control" id="title" name="title" required>
			                    </div>
			                    
			                    <div class="mb-3">
			                        <label for="content" class="form-label">Nội Dung:</label>
			                        <textarea class="form-control" id="content" name="content" required></textarea>
			                    </div>
			                    
			                    <div class="mb-3">
			                        <label for="receivedDate" class="form-label">Ngày Nhận:</label>
			                        <input type="date" class="form-control" id="receivedDate" name="receivedDate" required>
			                    </div>
			                    
			                    <div class="mb-3">
			                        <label for="status" class="form-label">Trạng Thái:</label>
			                        <select class="form-control" id="status" name="status">
			                            <option value="Pending">Chờ xử lý</option>
			                            <option value="Processing">Đang xử lý</option>
			                            <option value="Completed">Hoàn thành</option>
			                            <option value="Received">Đã nhận</option>
			                        </select>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="createdBy" class="form-label">Người Tạo (Mã Người Dùng):</label>
			                        <select class="form-control" id="createdBy" name="createdBy" required>
			                            <option value="1">1</option>
			                            <option value="2">2</option>
			                        </select>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="file" class="form-label">Đính Kèm Tệp:</label>
			                        <input type="file" class="form-control" id="file" name="file">
			                    </div>
			                </div>
			                
			                <div class="modal-footer">
			                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
			                    <button type="submit" class="btn btn-primary">Thêm Công Văn</button>
			                </div>
			            </form>
			        </div>
			    </div>
			</div>
	        <!-- Modal Chỉnh Sửa -->
			<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="editModalLabel">Chỉnh Sửa Công Văn</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
			                <form id="editForm" action="update-incoming-document" method="post" enctype="multipart/form-data">
			                    <input type="hidden" id="edit-id" name="id">
			
			                    <div class="mb-3">
			                        <label for="edit-code" class="form-label">Mã Công Văn</label>
			                        <input type="text" class="form-control" id="edit-code" name="code" required>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="edit-title" class="form-label">Tiêu Đề</label>
			                        <input type="text" class="form-control" id="edit-title" name="title" required>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="edit-content" class="form-label">Nội Dung</label>
			                        <textarea class="form-control" id="edit-content" name="content" required></textarea>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="edit-receivedDate" class="form-label">Ngày Nhận</label>
			                        <input type="date" class="form-control" id="edit-receivedDate" name="receivedDate" required>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="edit-status" class="form-label">Trạng Thái</label>
			                        <select class="form-select" id="edit-status" name="status" required>
			                            <option value="Pending">Chờ xử lý</option>
			                            <option value="Processing">Đang xử lý</option>
			                            <option value="Completed">Hoàn thành</option>
			                            <option value="Received">Đã nhận</option>
			                        </select>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="edit-createdBy" class="form-label">Người Tạo</label>
			                        <input type="number" class="form-control" id="edit-createdBy" name="createdBy" required>
			                    </div>
			
			                    <div class="mb-3">
			                        <label for="edit-file" class="form-label">Tệp Đính Kèm</label>
			                        <input type="file" class="form-control" id="edit-file" name="file">
			                        <p id="edit-current-file"></p>
			                    </div>
			
			                    <div class="modal-footer">
			                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
			                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
			                    </div>
			                </form>
			            </div>
			        </div>
			    </div>
			</div>
	        <script>
			    document.addEventListener("DOMContentLoaded", function () {
			        const editButtons = document.querySelectorAll(".btn-edit");
			
			        editButtons.forEach(button => {
			            button.addEventListener("click", function () {
			                document.getElementById("edit-id").value = this.dataset.id;
			                document.getElementById("edit-code").value = this.dataset.code;
			                document.getElementById("edit-title").value = this.dataset.title;
			                document.getElementById("edit-content").value = this.dataset.content;
			                document.getElementById("edit-receivedDate").value = this.dataset.receiveddate;
			                document.getElementById("edit-status").value = this.dataset.status;
			                document.getElementById("edit-createdBy").value = this.dataset.createdby;
			
			                let filePath = this.dataset.file;
			                if (filePath) {
			                    document.getElementById("edit-current-file").innerHTML = `File hiện tại: <a href="${filePath}" target="_blank">Xem file</a>`;
			                } else {
			                    document.getElementById("edit-current-file").innerHTML = "Không có tệp đính kèm.";
			                }
			            });
			        });
			    });
			</script>
	        
	        
	        
	        

      <!--   Core JS Files   -->
      <script src="assets/js/core/jquery-3.7.1.min.js"></script>
      <script src="assets/js/core/popper.min.js"></script>
      <script src="assets/js/core/bootstrap.min.js"></script>
      <script src="assets/js/setup.js"></script>

      <!-- jQuery Scrollbar -->
      <script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

      <!-- Chart JS -->
      <script src="assets/js/plugin/chart.js/chart.min.js"></script>

      <!-- jQuery Sparkline -->
      <script src="assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

      <!-- Chart Circle -->
      <script src="assets/js/plugin/chart-circle/circles.min.js"></script>

      <!-- Datatables -->
      <script src="assets/js/plugin/datatables/datatables.min.js"></script>

      <!-- Bootstrap Notify -->
      <script src="assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

      <!-- jQuery Vector Maps -->
      <script src="assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
      <script src="assets/js/plugin/jsvectormap/world.js"></script>

      <!-- Sweet Alert -->
      <script src="assets/js/plugin/sweetalert/sweetalert.min.js"></script>

      <!-- Kaiadmin JS -->
      <script src="assets/js/kaiadmin.min.js"></script>

      <!-- Kaiadmin DEMO methods, don't include it in your project! -->
      <script src="assets/js/setting-demo.js"></script>
      <script src="assets/js/demo.js"></script>
      <script>
        $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
          type: "line",
          height: "70",
          width: "100%",
          lineWidth: "2",
          lineColor: "#177dff",
          fillColor: "rgba(23, 125, 255, 0.14)",
        });

        $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
          type: "line",
          height: "70",
          width: "100%",
          lineWidth: "2",
          lineColor: "#f3545d",
          fillColor: "rgba(243, 84, 93, .14)",
        });

        $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
          type: "line",
          height: "70",
          width: "100%",
          lineWidth: "2",
          lineColor: "#ffa534",
          fillColor: "rgba(255, 165, 52, .14)",
        });
      </script>
    </body>
  </html>

