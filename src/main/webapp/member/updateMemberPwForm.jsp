<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	response.setCharacterEncoding("utf-8");

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
		<title>updateMemberPwForm</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav  -->
		<jsp:include page="/inc/nav.jsp"></jsp:include>
		
		<!-- main -->
		<h1>비밀번호 수정</h1>
		<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
			<table>
				<tr>
					<td>현재 비밀번호</td>
					<td><input type="password" name="currentPw"></td>
				</tr>
				<tr>
					<td>새 비밀번호</td>
					<td><input type="password" name="updatePw"></td>
				</tr>
				<tr>
					<td>새 비밀번호 확인</td>
					<td><input type="password" name="updatePwCk"></td>
				</tr>
				<tr>
					<td><button type="submit">비밀번호 수정</button></td>
				</tr>
			</table>
		</form>
	</body>
</html>