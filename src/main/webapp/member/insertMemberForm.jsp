<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
	</head>
	<body>
		<%
			if(msg != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<div><input type="text" name="name" placeholder="이름"></div>
			<div><input type="text" name="id" placeholder="아이디"></div>
			<div><input type="password" name="pw" placeholder="패스워드"></div>
			<button type="submit">회원가입</button>
		</form>
	</body>
</html>