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
		<title>loginForm</title>
	</head>
	<body>
		<div>
			<%
				if(msg != null) {
			%>
					<span><%=msg%></span>			
			<%		
				}
			%>
			<form action="<%=request.getContextPath()%>/loginAction.jsp">
				<input type="text" name="id" placeholder="아이디">
				<input type="password" name="pw" placeholder="패스워드">
				<button type="submit">로그인</button>
			</form>			
			<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		</div>
	</body>
</html>