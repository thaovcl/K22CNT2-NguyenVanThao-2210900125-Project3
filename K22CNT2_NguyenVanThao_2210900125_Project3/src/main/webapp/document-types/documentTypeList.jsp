<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,java.sql.*,java.util.ArrayList,java.util.List,model.NVTDocument" %>
<%@ page import="java.util.List,model.DocumentType" %>
<%@ page session="true" %>


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
	              <a href="index.html" class="logo">
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
	                  <a href="index.jsp"  class="collapsed" aria-expanded="false">
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
	                
	                <!--Xử lý đăng nhập khi ấn vào menu  -->
	                <script>
					    function checkLogin(targetPage, isAdminRequired = false) {
					    	var roleId = "<%= session.getAttribute("roleId") != null ? session.getAttribute("roleId").toString() : "0" %>";
					        roleId = parseInt(roleId); // Chuyển thành số nguyên
					
					        if (roleId === 0) {
					            alert("Vui lòng đăng nhập để tiếp tục!");
					            window.location.href = "<%= request.getContextPath() %>/login.jsp";
					            return false;
					        }
					
					        // Nếu cần quyền admin nhưng user không phải admin (roleId !== 1)
					        if (isAdminRequired && roleId !== 1) {
					            alert("Bạn không có quyền truy cập vào trang này!");
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
	        
			<!-- Nút mở modal -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDocumentTypeModal">
			    Thêm Loại Công Văn
			</button>
	        <table class="table table-bordered table-striped table-hover">
			    <thead>
			        <tr>
			            <th>ID</th>
			            <th>Tên Loại</th>
			            <th>Loại Công Văn</th>
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
			            <td><%= dt.getDocumentType() %></td> <!-- Hiển thị loại công văn -->
			            <td>
			                <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal"
			                   data-id="<%= dt.getTypeID() %>" data-name="<%= dt.getTypeName() %>"
			                   data-documenttype="<%= dt.getDocumentType() %>">Sửa</a>
			                <a href="document-types/delete?id=<%= dt.getTypeID() %>" class="btn btn-danger"
			                   onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
			            </td>
			        </tr>
			        <% } } else { %>
			        <tr>
			            <td colspan="4" class="text-center text-danger fw-bold">Không có dữ liệu.</td>
			        </tr>
			        <% } %>
			    </tbody>
			</table>

        <!-- Modal Thêm Loại Công Văn -->
		<div class="modal fade" id="addDocumentTypeModal" tabindex="-1" aria-labelledby="addDocumentTypeLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="addDocumentTypeLabel">Thêm Loại Công Văn</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <form action="<%= request.getContextPath() %>/document-types/add" method="post">
		                    <div class="mb-3">
		                        <label for="typeName" class="form-label">Tên Loại Công Văn</label>
		                        <input type="text" class="form-control" id="typeName" name="typeName" required>
		                    </div>
		                    <div class="mb-3">
		                        <label for="documentType" class="form-label">Loại Công Văn</label>
		                        <select class="form-select" id="documentType" name="documentType" required>
		                            <option value="Incoming">Incoming</option>
		                            <option value="Outgoing">Outgoing</option>
		                        </select>
		                    </div>
		                    <div class="modal-footer">
		                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
		                        <button type="submit" class="btn btn-primary">Thêm</button>
		                    </div>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>

		<!-- Modal Chỉnh Sửa Loại Công Văn -->
		<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="editModalLabel">Chỉnh Sửa Loại Công Văn</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <form id="editForm" action="<%= request.getContextPath() %>/document-types/update" method="post">
		                    <input type="hidden" id="editTypeID" name="typeID">
		                    
		                    <div class="mb-3">
		                        <label for="editTypeName" class="form-label">Tên loại:</label>
		                        <input type="text" id="editTypeName" name="typeName" class="form-control" required>
		                    </div>
		
		                    <div class="mb-3">
		                        <label for="editDocumentType" class="form-label">Loại Công Văn</label>
		                        <select class="form-select" id="editDocumentType" name="documentType" required>
		                            <option value="Incoming">Incoming</option>
		                            <option value="Outgoing">Outgoing</option>
		                        </select>
		                    </div>
		
		                    <div class="modal-footer">
		                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
		                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
		                    </div>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>

		<script>
		document.addEventListener("DOMContentLoaded", function () {
		    var editModal = document.getElementById("editModal");
		    editModal.addEventListener("show.bs.modal", function (event) {
		        var button = event.relatedTarget; // Nút được nhấn để mở modal
		        var typeID = button.getAttribute("data-id");
		        var typeName = button.getAttribute("data-name");
		        var documentType = button.getAttribute("data-documenttype"); // Lấy giá trị loại công văn

		        document.getElementById("editTypeID").value = typeID;
		        document.getElementById("editTypeName").value = typeName;
		        document.getElementById("editDocumentType").value = documentType; // Set giá trị cho dropdown
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

