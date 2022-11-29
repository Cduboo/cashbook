<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertHelpForm</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		
		<!-- main -->
		<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
			<h1>문의사항</h1>
			<div>제목 : <input type="text" name="helpTitle"></div>
			<textarea rows="10" cols="30" name="helpMemo"></textarea>
			<button type="submit">작성하기</button>
		</form>
	</body>
</html>