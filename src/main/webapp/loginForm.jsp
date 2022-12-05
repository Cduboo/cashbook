<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 유저는 접근 불가
	if (session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>loginForm</title>
		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="assets/css/bootstrap.css">
		<link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
		<link rel="stylesheet" href="assets/css/app.css">
		<link rel="stylesheet" href="assets/css/pages/auth.css">
	</head>
	<body>
		<div id="auth">
			<div class="row h-100">
				<div class="col-lg-5 col-12">
					<div id="auth-left">
						<h4 class="auth-title">로그인</h4>
						<p class="auth-subtitle mb-5">환영합니다!</p>
						<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
							<div class="form-group position-relative has-icon-left mb-4">
								<input type="text" name="id" class="form-control form-control-xl" placeholder="아이디">
								<div class="form-control-icon">
									<i class="bi bi-person"></i>
								</div>
							</div>
							<div class="form-group position-relative has-icon-left mb-4">
								<input type="password" name="pw" class="form-control form-control-xl" placeholder="비밀번호">
								<div class="form-control-icon">
									<i class="bi bi-shield-lock"></i>
								</div>
							</div>
							<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">로그인</button>
						</form>
						<div class="text-center mt-5 text-lg fs-4">
							<p class="text-gray-600">
								회원이 아니신가요? <a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="font-bold">회원가입</a>
							</p>
						</div>
					</div>
				</div>
				<div class="col-lg-7 d-none d-lg-block">
					<div id="auth-right"></div>
				</div>
			</div>
		</div>
	</body>
</html>