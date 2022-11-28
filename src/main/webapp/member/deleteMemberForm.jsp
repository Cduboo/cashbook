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
		<title>deleteMemberForm</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav  -->
		<jsp:include page="/inc/nav.jsp"></jsp:include>
		
		<!-- main -->
		<h1>회원탈퇴</h1>
		<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="deleteId"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="deletePw"></td>
				</tr>
				<tr>
					<td><button type="submit">회원탈퇴</button></td>
				</tr>
			</table>
		</form>
	</body>
</html>