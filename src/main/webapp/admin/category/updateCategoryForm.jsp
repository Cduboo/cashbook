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
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");	
		return;
	}

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	CategoryDao categoryDao = new CategoryDao();
	//해당 카테고리
	Category category = categoryDao.selectCategoryOne(categoryNo);
	//카테고리 리스트
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
			<div>
				번호
				수입/지출
				이름
				마지막 수정 날짜
				생성 날짜
				수정
				삭제
			</div>
			<%
				for(Category c : categoryList) {
			%>
					<div>
						<form method="post">
			<%			
					if(c.getCategoryNo() == category.getCategoryNo()){
			%>
							<%=c.getCategoryNo()%>
							<%=c.getCategoryKind() %>	
							<input type="text" name="categoryName" value="<%=c.getCategoryName()%>">
							<%=c.getUpdatedate()%>
							<%=c.getCreatedate()%>
							<button type="submit" formaction="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</button>
							<button type="submit" formaction="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</button>
			<%			
					}else {
			%>							
							<%=c.getCategoryNo()%>
							<%=c.getCategoryKind()%>
							<%=c.getCategoryName()%>
							<%=c.getUpdatedate()%>
							<%=c.getCreatedate()%>
							<button type="submit" formaction="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</button>
							<button type="submit" formaction="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</button>
			<%										
					}	
				}
			%>
						</form>
					</div>
		</div>
	</body>
</html>