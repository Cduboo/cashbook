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
	
	//updateMemberAction.jsp
	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}
%>

<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberForm</title>
	</head>
	<body>
		<%
			if(msg != null){
		%>
				<div><%=msg%></div>
		<%
			}
		%>
		<h1>회원정보 수정</h1>
		<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="updateName" value="<%=loginMember.getMemberName()%>"></td>
				</tr>
				<tr>
					<td><input type="password" name="currentPw" placeholder="비밀번호 확인"></td>
					<td><button type="submit">회원정보 수정</button></td>
				</tr>
			</table>
		</form>
	</body>
</html>