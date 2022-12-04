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
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>categoryList</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
	    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="../../assets/css/bootstrap.css">
	    <link rel="stylesheet" href="../../assets/vendors/iconly/bold.css">
	    <link rel="stylesheet" href="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	    <link rel="stylesheet" href="../../assets/vendors/bootstrap-icons/bootstrap-icons.css">
	    <link rel="stylesheet" href="../../assets/css/app.css">
	    <link rel="shortcut icon" href="../../assets/images/favicon.svg" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>			
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-heading">
					<h3>Category Management</h3>
				</div>
				<div class="page-content">
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h4 class="text-end me-3">
										<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">+ Category</a>
									</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-lg" style="table-layout: fixed;">
											<thead>
												<tr>
													<th>번호</th>
													<th>수입/지출</th>
													<th>이름</th>
													<th>마지막 수정 날짜</th>
													<th>생성 날짜</th>
													<th>수정</th>
													<th>삭제</th>
												</tr>
											</thead>
											<tbody>
												<%
													for(Category c : categoryList) {
												%>
														<form method="post">
														<%			
															if(c.getCategoryNo() == category.getCategoryNo()){
														%>
																<tr>
																	<td><%=c.getCategoryNo()%></td>
																	<td><%=c.getCategoryKind()%></td>
																	<td><input type="text" name="categoryName" value="<%=c.getCategoryName()%>"></td>
																	<td><%=c.getUpdatedate()%></td>
																	<td><%=c.getCreatedate()%></td>
																	<td><a href="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
																	<td><a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
																</tr>
														<%			
															}else {
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
													}
														%>
														</form>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			<!-- main end -->
			</div>
		<!-- app end -->	
		</div>
		<%-- <div>
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
		</div> --%>
		
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../../assets/js/pages/dashboard.js"></script>
	    <script src="../../assets/js/main.js"></script>
	</body>
</html>