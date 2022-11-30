<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
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
		<div class="container-scroller">
			<div class="container-fluid page-body-wrapper full-page-wrapper">
				<div class="content-wrapper d-flex align-items-center auth px-0">
					<div class="row w-100 mx-0">
						<div class="col-lg-4 mx-auto">
							<div class="auth-form-light text-left py-5 px-4 px-sm-5">
								<div class="brand-logo">
									<img src="../../images/logo-dark.svg" alt="logo">
								</div>
								<h4>New here?</h4>
								<h6 class="font-weight-light">Signing up is easy. It only takes a few steps</h6>
								<form class="pt-3" action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
									<div class="form-group">
										<input type="text" name="name" class="form-control form-control-lg" id="exampleInputUsername1" placeholder="Username">
									</div>
									<div class="form-group">
										<input type="text" name="id" class="form-control form-control-lg" id="exampleInputEmail1" placeholder="UserId">
									</div>
									<div class="form-group">
										<input type="password" name="pw" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="Password">
									</div>
									<div class="mt-3">
										<button class="btn btn-block btn-info btn-lg font-weight-medium auth-form-btn" type="submit">SIGN UP</button>
									</div>
									<div class="text-center mt-4 font-weight-light">
										Already have an account? <a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-primary">Login</a>
									</div>
								</form>
							</div>
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