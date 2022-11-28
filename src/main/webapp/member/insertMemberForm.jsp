<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
	</head>
	<body>
		<div>
			<h1>회원가입</h1>
			<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
				<div><input type="text" name="name" placeholder="이름"></div>
				<div><input type="text" name="id" placeholder="아이디"></div>
				<div><input type="password" name="pw" placeholder="패스워드"></div>
				<button type="submit">회원가입</button>
			</form>
		</div>
	</body>
</html>