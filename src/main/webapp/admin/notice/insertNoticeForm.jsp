<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertNoticeForm</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<!-- main -->
		<div>
			<h1>공지등록</h1>
			<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp">
				<div><button type="submit">공지쓰기</button></div>
				<div><input type="text" name="noticeTitle"></div>
				<div><textarea rows="10" cols="50" name="noticeMemo"></textarea></div>
			</form>
		</div>
	</body>
</html>