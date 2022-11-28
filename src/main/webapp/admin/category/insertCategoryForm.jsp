<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%
	//C
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
		<title>insertCategoryForm</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
			<div>
				category Kind
				<input type="radio" name="categoryKind" value="수입"/>수입
				<input type="radio" name="categoryKind" value="지출"/>지출
			</div>
			<div>
				category Name
				<input type="text" name="categoryName"/>
			</div>
			<div>
				<button type="submit">추가</button>
			</div>
		</form>
	</body>
</html>