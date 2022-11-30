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
		<!-- css -->
		<link rel="stylesheet" href="../vendors/mdi/css/materialdesignicons.min.css">
		<link rel="stylesheet" href="../vendors/feather/feather.css">
		<link rel="stylesheet" href="../vendors/base/vendor.bundle.base.css">
		<link rel="stylesheet" href="../vendors/flag-icon-css/css/flag-icon.min.css"/>
		<link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../vendors/jquery-bar-rating/fontawesome-stars-o.css">
		<link rel="stylesheet" href="../vendors/jquery-bar-rating/fontawesome-stars.css">
		<link rel="stylesheet" href="../css/style.css">
		<link rel="stylesheet" href="../css/styles.css">
		<link rel="shortcut icon" href="../images/favicon.png" />
	</head>
	<body>
		<!-- 네비게이션/헤더부분 -->
		<div class="container-scroller">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="container-fluid page-body-wrapper" style="background-color: #F4F7FA;">
				<!-- 네비게이션/사이드  -->
				<jsp:include page="/inc/nav.jsp"></jsp:include>
				<!-- main -->
				<div class="container stretch-card mt-5" style="height: 500px;">
					<div class="card">
						<div class="card-body">
							<p class="card-description">Service center</p>
							<h4 class="mb-5">Q&A</h4>
							<form class="forms-sample" action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
								<div class="form-group">
									<label for="exampleInputUsername1">Title</label>
									<input type="text" class="form-control" name="helpTitle" id="exampleInputUsername1">
								</div>
								<div class="form-group">
									<label for="exampleTextarea1">Contents</label>
									<textarea class="form-control" name="helpMemo" id="exampleTextarea1" rows="4"></textarea>
			                    </div>
								<button type="submit" class="btn btn-primary mr-2">Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- js -->
		<script src="../vendors/base/vendor.bundle.base.js"></script>
		<script src="../js/off-canvas.js"></script>
		<script src="../js/hoverable-collapse.js"></script>
		<script src="../js/template.js"></script>
		<script src="../vendors/chart.js/Chart.min.js"></script>
		<script src="../vendors/jquery-bar-rating/jquery.barrating.min.js"></script>
		<script src="../js/dashboard.js"></script>
		<script src="https://kit.fontawesome.com/0917e5f385.js" crossorigin="anonymous"></script>
	</body>
</html>