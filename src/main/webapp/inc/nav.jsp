<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
%>
<div id="sidebar" class="active">
	<div class="sidebar-wrapper active">
		<div class="sidebar-header">
			<div class="d-flex justify-content-between">
				<div class="logo">
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp"><img src="/cashbook/assets/images/logo/logo.png" alt="Logo"></a>
				</div>
				<div class="toggler">
					<a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
				</div>
			</div>
		</div>
		<div class="sidebar-menu">
			<ul class="menu">
				<li class="sidebar-title">Menu</li>
				<li class="sidebar-item">
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class='sidebar-link'>
						<i class="far fa-calendar"></i>
						<span>Account book</span>
					</a>
				</li>	
				<%
					if (loginMember.getMemberLevel() > 0) {
				%>	
						<li class="sidebar-item  has-sub">
							<a href="#" class='sidebar-link'>
								<i class="fas fa-user-check"></i>
								<span>Admin</span>
							</a>
							<ul class="submenu ">
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">Notice management</a>
								</li>
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">Category Management</a>
								</li>
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">Member management</a>
								</li>
							</ul>
						</li>
				<%
					}
				%>
				<li class="sidebar-item  has-sub">
					<a href="#" class='sidebar-link'>
						<i class="fas fa-user"></i>
						<span>Mypage</span>
					</a>
					<ul class="submenu ">
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">Edit information</a>
						</li>
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">Edit password</a>
						</li>
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">Delete account</a>
						</li>
					</ul>
				</li>
				<%
					if(loginMember.getMemberLevel() > 0) {
				%>
						<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/admin/help/helpList.jsp" class='sidebar-link'>
								<i class="fas fa-question-circle"></i>
								<span>Service center</span>
							</a>
						</li>
				<%
					}else {
				%>
					<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/help/helpList.jsp" class='sidebar-link'>
								<i class="fas fa-question-circle"></i>
								<span>Service center</span>
							</a>
					</li>
				<%
					}
				%>
				<li class="sidebar-item">
					<a href="<%=request.getContextPath()%>/logOut.jsp" class='sidebar-link'>
						<i class="fas fa-sign-out-alt"></i>
						<span>Logout</span>
					</a>
				</li>
			</ul>
		</div>
		<button class="sidebar-toggler btn x">
			<i data-feather="x"></i>
		</button>
	</div>
</div>
