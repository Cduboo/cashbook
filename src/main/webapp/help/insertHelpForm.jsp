<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//비로그인 유저는 접근 불가
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>insertHelpForm</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
		<link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
		<link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
		<link rel="stylesheet" href="../assets/css/app.css">
		<link rel="stylesheet" href="../assets/vendors/summernote/summernote-lite.min.css">
		<link rel="shortcut icon" href="../assets/images/favicon.svg" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<header class="mb-3">
					<a href="#" class="burger-btn d-block d-xl-none"> <i class="bi bi-justify fs-3"></i>
					</a>
				</header>
				<div class="page-heading">
					<h3>Service center</h3>
				</div>
				<div class="page-content">
					<section class="card">
						<div class="card-header">
							<h4 class="card-title">Question</h4>
						</div>
						<div class="card-content">
							<div class="card-body">
								<form class="form form-horizontal px-4" action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
									<div class="form-body">
										<div class="row">
											<div class="col-md-1">
												<label for="title">Title</label>
											</div>
											<div class="col-md-11 form-group">
												<input type="text" id="title" name="helpTitle" class="form-control" placeholder="Title">
											</div>
											<div class="col-md-12 form-group mt-3">
												<textarea id="summernote" name="helpMemo"></textarea>
											</div>
										</div>
										<div class="d-flex justify-content-end mt-3">
											<button type="submit" class="btn btn-primary">Submit</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</section>
					<!-- page-content end -->
				</div>
				<!-- main end -->
			</div>
			<!-- app end -->
		</div>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/vendors/jquery/jquery.min.js"></script>
	    <script src="../assets/vendors/summernote/summernote-lite.min.js"></script>
	    <script>
	        $('#summernote').summernote({
	            tabsize: 2,
	            height: 300,
	        });	      
	    </script>
		<script src="../assets/js/pages/dashboard.js"></script>
		<script src="../assets/js/main.js"></script>
	</body>
</html>