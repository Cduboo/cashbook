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
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>insertCategoryForm</title>
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
						<h3>카테고리 등록</h3>
					</div>
					<section class="card pt-3">
						<div class="card-content">
							<div class="card-body">
								<form class="form form-horizontal px-4" action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
									<div class="form-body">
										<div class="row">
											<div class="col-md-2">
												<label class="form-check-label" for="kind">분류</label>
											</div>
											<div class="col-md-10 form-group mb-4">
												<input class="form-check-input" type="radio" name="categoryKind" id="kind1" value="수입" checked/>
												<label class="form-check-label me-2" for="kind1">수입</label>
												<input class="form-check-input" type="radio" name="categoryKind" id="kind2" value="지출"/>
												<label class="form-check-label" for="kind2">지출</label>
											</div>
											<div class="col-md-2">
												<label for="name">종류</label>
											</div>
											<div class="col-md-10 form-group  mb-4">
												<input type="text" name="categoryName" id="name" class="form-control" placeholder="종류">
											</div>
											<div class="d-flex justify-content-end mt-3">
												<button type="submit" class="btn btn-outline-primary mr-2">등록하기</button>
											</div>
										</div>
									</div>
								</form>
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