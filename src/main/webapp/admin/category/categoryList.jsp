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
	
	// 카테고리 수정 시 알림창
	if(request.getParameter("update") != null) {		  
		out.print("<script>alert('"+request.getParameter("update")+"')</script>");
	}
	
	// 카테고리 삭제 시 알림창
	if(request.getParameter("delete") != null) {
		out.print("<script>alert('"+request.getParameter("delete")+"')</script>");
	}
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
				<div class="page-content">
					<div class="page-heading">
						<h3>카테고리 관리</h3>
					</div>
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h4 class="text-end me-3">
										<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">+ 카테고리 등록</a>
									</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-md" style="table-layout: fixed;">
											<thead>
												<tr>
													<th>분류</th>
													<th>종류</th>
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
														<tr>
															<td><%=c.getCategoryKind()%></td>
															<td><%=c.getCategoryName()%></td>
															<td><%=c.getUpdatedate()%></td>
															<td><%=c.getCreatedate()%></td>
															<td><a class="btn btn-sm btn-light-secondary" href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
															<td><a class="btn btn-sm btn-light-secondary" href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
														</tr>
												<%		
													}
												%>
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
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../../assets/js/pages/dashboard.js"></script>
	    <script src="../../assets/js/main.js"></script>
	</body>
</html>