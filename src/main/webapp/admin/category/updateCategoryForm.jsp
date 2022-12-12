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
	Category categoryOne = categoryDao.selectCategoryOne(categoryNo);
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
	    <link rel="shortcut icon" href="../../assets/images/favicon.ico" type="image/x-icon">
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
										<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">+ 카테고리</a>
									</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<form method="post">
											<table class="table table-lg" style="table-layout: fixed;">
												<thead>
													<tr>
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
															<%			
																if(c.getCategoryNo() == categoryOne.getCategoryNo()){
															%>
																	<tr>
																		<td><%=c.getCategoryKind()%></td>
																		<td><input class="form-control" type="text" name="categoryName" value="<%=c.getCategoryName()%>"></td>
																		<td><%=c.getUpdatedate()%></td>
																		<td><%=c.getCreatedate()%></td>
																		<td>
																			<button class="btn btn-sm btn-light-secondary" type="submit" formaction="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</button>
																		</td>
																		<td>
																			<button class="btn btn-sm btn-light-secondary" type="submit" formaction="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</button>
																		</td>
																	</tr>
															<%			
																}else {
															%>
																	<tr>
																		<td><%=c.getCategoryKind()%></td>
																		<td><%=c.getCategoryName()%></td>
																		<td><%=c.getUpdatedate()%></td>
																		<td><%=c.getCreatedate()%></td>
																		<td>
																			<button class="btn btn-sm btn-light-secondary" type="submit" formaction="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</button>
																		</td>
																		<td>
																			<button class="btn btn-sm btn-light-secondary" type="submit" formaction="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</button>
																		</td>
																	</tr>
															<%										
																	}	
														}
															%>
												</tbody>
											</table>
										</form>
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