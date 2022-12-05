<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	//문의 상세정보
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);	
	
	
   	//해당 문의글의 답변 리스트 출력
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> list = commentDao.selectCommentList(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>helpOne</title>
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
				<div class="page-heading">
					<h3>1대1 문의</h3>
				</div>
				<div class="page-content">
					<section class="card">
						<div class="card-header">
							<h4 class="card-title">문의 사항</h4>
						</div>
						<div class="card-content">
							<div class="card-body">
								<h4 class="card-title">제목 : <%=helpOne.getHelpTitle()%></h4>
								<h4 class="card-title">작성자 : <%=helpOne.getMemberId()%></h4>
								<h4 class="card-title">작성일 : <%=helpOne.getCreatedate()%></h4>
								<hr>
								<h6 class="card-subtitle"><%=helpOne.getHelpMemo()%></h6>
								<div class="d-flex justify-content-end mt-3">
									<a class="btn btn-primary me-3 mt-5 mb-5" href="<%=request.getContextPath()%>/admin/help/helpList.jsp">목록</a>
								</div>
								<div class="divider mt-5">
                                	<div class="divider-text">답변 목록</div>
                   	  			</div>
								<div class="card">
									<div class="card-content">
										<div class="card-body">
											<div class="list-group">
												<!-- 해당 문의 답변 리스트 -->
												<%
													for(HashMap<String, Object> m : list) {
												%>
														<div class="list-group-item list-group-item-action">
															<div class="d-flex w-100 mb-3 justify-content-between">
																<h5 class="mb-1 text-primary">
																	<div class="avatar avatar-sm me-3">
																		<img src="<%=request.getContextPath()%>/assets/images/faces/1.jpg" alt="face">
																	</div>
																	<%=m.get("memberId")%>
																</h5>
																<small>
																	<%=m.get("createdate")%>
																	<a class="mx-2" href="<%=request.getContextPath()%>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">수정</a>
																	<a href="<%=request.getContextPath()%>/admin/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">삭제</a>
																</small>
															</div>
															<p class="mb-1"><%=m.get("commentMemo")%></p>
														</div>
												<%
													}
												%>
											</div>
										</div>
									</div>
								</div>
								<!-- 답변 입력 -->
								<div class="card">
									<div class="card-header">답변 쓰기</div>
									<div class="card-body">
										<form action="<%=request.getContextPath()%>/admin/help/insertCommentAction.jsp" method="post">
											<input type="hidden" name="helpNo" value="<%=helpNo%>">
											<div class="form-floating">
												<textarea class="form-control" name="commentMemo" placeholder="Leave a comment here" id="floatingTextarea" style="height: 150px"></textarea>
												<label for="floatingTextarea">Comments...</label>
											</div>
											<div class="text-end">
												<button class="btn btn-sm btn-primary mt-3" type="submit">등록하기</button>
											</div>
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
		<script src="../../assets/js/pages/dashboard.js"></script>
		<script src="../../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../../assets/js/main.js"></script>	
	</body>
</html>