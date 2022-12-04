<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<div id="main" class='layout-navbar'>
	<header class='mb-3'>
		<nav class="navbar navbar-expand navbar-light ">
			<div class="container-fluid">
				<div>
	                <a href="#" class="burger-btn d-block d-xl-none">
	                    <i class="bi bi-justify fs-3"></i>
	                </a>
	            </div>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					</ul>
					<div class="dropdown">
						<a href="#" data-bs-toggle="dropdown" aria-expanded="false">
							<div class="user-menu d-flex">
								<div class="user-name text-end me-3">
									<h6 class="mb-0 text-gray-600"><%=loginMember.getMemberName()%></h6>
									<p class="mb-0 text-sm text-gray-600"><%=loginMember.getMemberId()%></p>
								</div>
								<div class="user-img d-flex align-items-center">
									<div class="avatar avatar-md">
										<img src="/cashbook/assets/images/faces/1.jpg">	
									</div>
								</div>
							</div>
						</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
							<li>
								<h6 class="dropdown-header">
									Hello, <%=loginMember.getMemberName()%>!
								</h6>
							</li>
							<li><a class="dropdown-item" href="#"><i class="icon-mid bi bi-person me-2"></i> My Profile</a></li>
							<li>
								<hr class="dropdown-divider">
							</li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/logOut.jsp"><i class="icon-mid bi bi-box-arrow-left me-2"></i>Logout</a></li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
	</header>
</div>