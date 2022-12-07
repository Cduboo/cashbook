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
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>updateMemberPwForm</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
		<link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
		<link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
		<link rel="stylesheet" href="../assets/css/app.css">
		<link rel="shortcut icon" href="../assets/images/favicon.svg" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-content w-75 m-auto">
				<div class="page-heading">
					<h3>비밀번호 변경</h3>
				</div>
					<section class="card pt-3">
						<div class="card-content">
							<div class="card-body">
								<form class="form form-horizontal px-4" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
									<%
										if(msg != null) {
									%>
										<div class="text-danger mb-3"><%=msg%></div>
									<%		
										}
									%>
									<div class="form-body">
										<div class="row">
											<div class="col-12">
												<div class="form-group has-icon-left">
													<label for="currentPw">현재 비밀번호</label>
													<div class="position-relative mt-1">
														<input type="password" name="currentPw" id="currentPw" class="form-control" placeholder="현재 비밀번호">
														<div class="form-control-icon">
															<i class="bi bi-lock"></i>
														</div>
													</div>
												</div>
											</div>
											<div class="col-12">
												<div class="form-group has-icon-left">
													<label for="newPw">새 비밀번호</label>
													<div class="position-relative mt-1">
														<input type="password" name="updatePw" id="newPw" class="form-control" placeholder="새 비밀번호">
														<div class="form-control-icon">
															<i class="bi bi-lock"></i>
														</div>
													</div>
												</div>
											</div>
											<div class="col-12">
												<div class="form-group has-icon-left">
													<label for="confirmPw">새 비밀번호 확인</label>
													<div class="position-relative mt-1">
														<input type="password" name="updatePwCk" id="confirmPw" class="form-control" placeholder="새 비밀번호 확인">
														<div class="form-control-icon">
															<i class="bi bi-lock"></i>
														</div>
													</div>
												</div>
											</div>
											<div class="col-12 d-flex justify-content-end">
												<button type="submit" class="btn btn-outline-primary me-1 mt-3">변경하기</button>
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
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/pages/dashboard.js"></script>
		<script src="../assets/js/main.js"></script>
	</body>
</html>