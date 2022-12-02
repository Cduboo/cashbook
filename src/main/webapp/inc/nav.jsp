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
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp"><img src="../assets/images/logo/logo.png" alt="Logo"></a>
				</div>
				<div class="toggler">
					<a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
				</div>
			</div>
		</div>
		<div class="sidebar-menu">
			<ul class="menu">
				<li class="sidebar-title">Menu</li>
				<li class="sidebar-item active">
					<a href="index.html" class='sidebar-link'>
						<i class="bi bi-grid-fill"></i>
						<span>Account book</span>
					</a>
				</li>	
				<%
					if (loginMember.getMemberLevel() > 0) {
				%>	
						<li class="sidebar-item  has-sub">
							<a href="#" class='sidebar-link'>
								<i class="bi bi-stack"></i>
								<span>Admin</span>
							</a>
							<ul class="submenu ">
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a>
								</li>
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a>
								</li>
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">회원관리</a>
								</li>
							</ul>
						</li>
				<%
					}
				%>
				<li class="sidebar-item  has-sub">
					<a href="#" class='sidebar-link'>
						<i class="bi bi-stack"></i>
						<span>Mypage</span>
					</a>
					<ul class="submenu ">
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보 수정</a>
						</li>
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 수정</a>
						</li>
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a>
						</li>
					</ul>
				</li>
				<%
					if(loginMember.getMemberLevel() > 0) {
				%>
						<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/admin/help/helpList.jsp" class='sidebar-link'>
								<i class="bi bi-grid-fill"></i>
								<span>Service center</span>
							</a>
						</li>
				<%
					}else {
				%>
					<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/help/helpList.jsp" class='sidebar-link'>
								<i class="bi bi-grid-fill"></i>
								<span>Service center</span>
							</a>
					</li>
				<%
					}
				%>
				<li class="sidebar-item">
					<a href="<%=request.getContextPath()%>/logOut.jsp" class='sidebar-link'>
						<i class="bi bi-grid-fill"></i>
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
