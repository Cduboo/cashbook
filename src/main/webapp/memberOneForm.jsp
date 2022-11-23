<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>memberOne</title>
	</head>
	<body>
		<h1>마이페이지</h1>
		<%=loginMember.getMemberId()%>
		<%=loginMember.getMemberName()%>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">홈</a>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호 수정</a>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">회원정보 수정</a>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
		</div>
	</body>
</html>