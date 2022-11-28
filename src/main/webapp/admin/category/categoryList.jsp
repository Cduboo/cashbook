<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>categoryList</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<div>
			<h1>카테고리 목록</h1>
			<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">카테고리 추가</a>
			<table>
				<tr>
					<th>번호</th>
					<th>수입/지출</th>
					<th>이름</th>
					<th>마지막 수정 날짜</th>
					<th>생성 날짜</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<%
					for(Category c : categoryList) {
				%>
						<tr>
							<td><%=c.getCategoryNo()%></td>
							<td><%=c.getCategoryKind()%></td>
							<td><%=c.getCategoryName()%></td>
							<td><%=c.getUpdatedate()%></td>
							<td><%=c.getCreatedate()%></td>
							<td><a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
	</body>
</html>