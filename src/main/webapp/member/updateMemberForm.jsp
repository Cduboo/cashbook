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
	
	String msg1 = null;
	String msg2 = null;
	String msg3 = null;
	
	if(request.getParameter("msg1") != null) {
		msg1 = request.getParameter("msg1");
	}
	if(request.getParameter("msg2") != null) {
		msg2 = request.getParameter("msg2");
	}
	if(request.getParameter("msg3") != null) {
		msg3 = request.getParameter("msg3");
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
		<link rel="shortcut icon" href="../assets/images/favicon.ico" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-content w-75 m-auto">
					<div class="page-heading">
						<h3>마이페이지</h3>
					</div>
				<section class="section">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">내 정보</h4>
						</div>
						<div class="card-body">
							<div class="user-img d-flex flex-column align-items-center">
								<div class="avatar avatar-xl">
									<img style="height: 100px; width: 100px" src="<%=request.getContextPath()%>/assets/images/faces/1.jpg">	
								</div>
								<div class="fw-bold mt-3"><%=loginMember.getMemberName()%></div>
								<small><%=loginMember.getMemberId()%></small>
							</div>
						</div>
					</div>
				</section>
				<section class="section">
						<div class="col-md-12">
							<div class="card">
								<div class="card-body">
									<ul class="nav nav-tabs" id="myTab" role="tablist">
										<li class="nav-item" role="presentation"><a class="nav-link active" id="updateName-tab" data-bs-toggle="tab" href="#updateName" role="tab" aria-controls="updateName" aria-selected="true">회원정보 수정</a></li>
										<li class="nav-item" role="presentation"><a class="nav-link" id="updatePw-tab" data-bs-toggle="tab" href="#updatePw" role="tab" aria-controls="updatePw" aria-selected="false">비밀번호 변경</a></li>
										<li class="nav-item" role="presentation"><a class="nav-link" id="delete-tab" data-bs-toggle="tab" href="#delete" role="tab" aria-controls="delete" aria-selected="false">회원 탈퇴</a></li>
									</ul>
									<div class="tab-content" id="myTabContent">
										<div class="tab-pane fade show active" id="updateName" role="tabpanel" aria-labelledby="updateName-tab">
											<form class="form form-horizontal px-4 mt-5" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
												<%
													if(msg1 != null) {
												%>
												<div class="text-danger mb-3"><%=msg1%></div>
												<%		
													}
												%>
												<div class="form-body">
													<div class="row">
														<div class="col-12">
															<div class="form-group has-icon-left">
																<label for="id">아이디</label>
																<div class="position-relative mt-1">
																	<input type="text" class="form-control" value="<%=loginMember.getMemberId()%>" placeholder="아이디" id="id">
																	<div class="form-control-icon">
																		<i class="bi bi-person"></i>
																	</div>
																</div>
															</div>
														</div>
														<div class="col-12">
															<div class="form-group has-icon-left">
																<label for="name">이름</label>
																<div class="position-relative mt-1">
																	<input type="text" class="form-control" id="name" name="updateName" value="<%=loginMember.getMemberName()%>" placeholder="이름">
																	<div class="form-control-icon">
																		<i class="bi bi-person"></i>
																	</div>
																</div>
															</div>
														</div>
														<div class="col-12">
															<div class="form-group has-icon-left">
																<label for="pw">비밀번호</label>
																<div class="position-relative mt-1">
																	<input type="password" name="currentPw" id="pw" class="form-control" placeholder="비밀번호">
																	<div class="form-control-icon">
																		<i class="bi bi-lock"></i>
																	</div>
																</div>
															</div>
														</div>
														<div class="col-12 d-flex justify-content-end">
															<button type="submit" class="btn btn-outline-primary me-1 mt-3">수정하기</button>
														</div>
													</div>
												</div>
											</form>
										</div>
										<div class="tab-pane fade" id="updatePw" role="tabpanel" aria-labelledby="updatePw-tab">
											<form class="form form-horizontal px-4  mt-5" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
												<%
													if(msg2 != null) {
												%>
												<div class="text-danger mb-3"><%=msg2%></div>
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
										<div class="tab-pane fade" id="delete" role="tabpanel" aria-labelledby="delete-tab">
											<form class="form form-horizontal px-4 mt-5" action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
												<%
													if(msg3 != null) {
												%>
												<div class="text-danger mb-3"><%=msg3%></div>
												<%		
													}
												%>
												<div class="form-body">
													<div class="row">
														<div class="col-12">
															<div class="form-group has-icon-left">
																<label for="pw">비밀번호</label>
																<div class="position-relative mt-1">
																	<input type="password" name="memberPw" class="form-control" id="pw" placeholder="비밀번호">
																	<div class="form-control-icon">
																		<i class="bi bi-lock"></i>
																	</div>
																</div>
															</div>
														</div>
														<div class="col-12 d-flex justify-content-end">
															<div class="me-1 mb-1 d-inline-block">
																<button type="button" class="btn btn-outline-danger me-1 mt-3" data-bs-toggle="modal" data-bs-target="#defaultSize">회원 탈퇴</button>
																<div class="modal fade text-left" id="defaultSize" tabindex="-1" role="dialog" aria-labelledby="myModalLabel18" aria-hidden="true">
																	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
																		<div class="modal-content">
																			<div class="modal-header">
																				<h4 class="modal-title" id="myModalLabel18">회원 탈퇴</h4>
																				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
																					<i data-feather="x"></i>
																				</button>
																			</div>
																			<div class="modal-body">회원님의 계정을 <code>삭제합니다.</code> 계정을 삭제하려면 확인을 클릭하세요.</div>
																			<div class="modal-footer">
																				<button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
																					<i class="bx bx-x d-block d-sm-none"></i> <span class="d-none d-sm-block">닫기</span>
																				</button>
																				<button type="submit" class="btn btn-outline-danger ml-1">
																					<i class="bx bx-check d-block d-sm-none"></i> <span class="d-none d-sm-block">확인</span>
																				</button>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</form>
										</div>
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
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/pages/dashboard.js"></script>
		<script src="../assets/js/main.js"></script>
	</body>
</html>