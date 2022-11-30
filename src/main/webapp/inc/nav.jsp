<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!-- 사이드 네비게이션 -->
<div class="container-fluid page-body-wrapper">
	<nav class="sidebar sidebar-offcanvas" id="sidebar">
		<!-- 유저 이미지 미완 -->
		<div class="user-profile">
			<div class="user-image">
				<img src="../images/duboo.jpg">
			</div>
			<div class="user-name">
			    <%=loginMember.getMemberName()%>
			</div>
			<div class="user-designation">
		    	<%=loginMember.getMemberId()%>
			</div>
		</div>
		<ul class="nav">
			<li class="nav-item">
				<a class="nav-link" href="#">
					<i class="icon-box menu-icon"></i>
					<span class="menu-title">공지사항(미완)</span>
				</a>
			<li class="nav-item">
				<a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
					<i class="icon-head menu-icon"></i>
					<span class="menu-title">내정보</span>
					<i class="menu-arrow"></i>
				</a>
				<div class="collapse" id="auth">
					<ul class="nav flex-column sub-menu">
						<li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp"> 회원정보 수정 </a></li>
						<li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp"> 비밀번호 수정 </a></li>
						<li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp"> 회원탈퇴 </a></li>
					</ul>
				</div>
			</li>
		</ul>
	</nav>
</div>