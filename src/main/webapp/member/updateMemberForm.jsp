<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
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
		<title>updateMemberForm</title>
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
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-heading">
					<h3>Mypage</h3>
				</div>
				<div class="page-content w-70 container">
					<section class="card">
						<div class="card-header">
							<h4 class="card-title">Edit information</h4>
						</div>
						<div class="card-content">
							<div class="card-body">
								<%
									if(msg != null) {
								%>
									<div><%=msg%></div>
								<%		
									}
								%>
								<form class="form form-horizontal px-4" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
									<div class="form-body">
										<div class="row">
											<div class="col-md-2">
												<label>ID</label>
											</div>
											<div class="col-md-10 form-group">
												<input type="text" class="form-control" value="<%=loginMember.getMemberId()%>" placeholder="id" readonly="readonly">
											</div>
											<div class="col-md-2">
												<label for="name">NAME</label>
											</div>
											<div class="col-md-10 form-group">
												<input type="text" class="form-control" id="name" name="updateName" value="<%=loginMember.getMemberName()%>" placeholder="Name">
											</div>
											<div class="col-md-2">
												<label for="pw">PASSWORD</label>
											</div>
											<div class="col-md-10 form-group">
												<input type="password" name="currentPw" id="pw" class="form-control" placeholder="Password">
											</div>
											<div class="d-flex justify-content-end mt-3">
												<button type="submit" class="btn btn-primary mr-2">Submit</button>
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