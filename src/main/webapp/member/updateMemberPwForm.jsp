<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	response.setCharacterEncoding("utf-8");

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberPwForm</title>
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
				<div class="container col-md-6 grid-margin stretch-card mt-5" style="height: 500px;">
					<div class="card">
						<div class="card-body">
							<p class="card-description">MYPAGE</p>
							<h4 class="card-title mb-5">Edit password</h4>
							<%
								if(msg != null) {
							%>
								<div><%=msg%></div>
							<%		
								}
							%>
							<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post" class="forms-sample">
								<div class="form-group row">
									<label for="exampleInputPassword2" class="col-sm-3 col-form-label">Password</label>
									<div class="col-sm-9">
										<input type="password" name="currentPw" class="form-control" id="exampleInputPassword2" placeholder="Current Password">
									</div>
								</div>
								<div class="form-group row">
									<label for="exampleInputPassword2" class="col-sm-3 col-form-label">Password</label>
									<div class="col-sm-9">
										<input type="password" name="updatePw" class="form-control" id="exampleInputPassword2" placeholder="Update Password">
									</div>
								</div>
								<div class="form-group row">
			                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Confirm Password</label>
			                      <div class="col-sm-9">
			                        <input type="password" name="updatePwCk" class="form-control" id="exampleInputConfirmPassword2" placeholder="Confirm Password">
			                      </div>
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