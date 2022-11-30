<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
	<!-- 로고 -->
	<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
		<a class="navbar-brand brand-logo" href="<%=request.getContextPath()%>/cash/cashList.jsp"><img src="../images/logo.svg" alt="logo"/></a>
		<a class="navbar-brand brand-logo-mini" href="index.html"><img src="images/logo-mini.svg" alt="logo"/></a>
	</div>
	<!-- 헤더 네비게이션 -->
	<div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
		<!-- 메뉴바 확대/축소 -->
		<button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
			<span class="icon-menu"></span>				
		</button>
		<!-- 내정보 -->
		<ul class="navbar-nav navbar-nav-right">
			<li class="nav-item dropdown d-flex mr-4 ">
				<a class="nav-link count-indicator dropdown-toggle d-flex align-items-center justify-content-center" id="notificationDropdown" href="#" data-toggle="dropdown">
					<i class="icon-grid"></i>
				</a>
				<div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
					<p class="mb-0 font-weight-normal float-left dropdown-header"><%=loginMember.getMemberName()%>님</p>
				  	<%
						if(loginMember.getMemberLevel() > 0) {
					%>
							<a class="dropdown-item preview-item" href="<%=request.getContextPath()%>/admin/adminMain.jsp">               
							    <i class="icon-head"></i> 관리자페이지
							</a>
					<%		
						}
					%>
					<a class="dropdown-item preview-item" href="<%=request.getContextPath()%>/member/memberOneForm.jsp">               
					    <i class="icon-head"></i> 마이페이지
					</a>
					<%
						if(loginMember.getMemberLevel() > 0) {
					%>
							
							<a class="dropdown-item preview-item" href="<%=request.getContextPath()%>/admin/help/helpList.jsp">               
					    		<i class="icon-head"></i> 고객센터
							</a>
					<%		
						}else {
					%>
							<a class="dropdown-item preview-item" href="<%=request.getContextPath()%>/help/helpList.jsp">               
					    		<i class="icon-head"></i> 고객센터
							</a>
					<%		
						}
					%>  
					<a class="dropdown-item preview-item" href="<%=request.getContextPath()%>/logOut.jsp">
					    <i class="icon-inbox"></i> Logout
					</a>
				</div>
			</li>
		</ul>
		<button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
		  <span class="icon-menu"></span>
		</button>
	</div>
</nav>