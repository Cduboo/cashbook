<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//비로그인 유저는 접근 불가
	if (session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member) session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	if (request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	//문의 상세정보
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);
	//나의 문의 리스트
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
	//해당 문의글의 답변 리스트 출력
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> commentList = commentDao.selectCommentList(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>helpOne</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
		<link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
		<link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
		<link rel="stylesheet" href="../assets/css/app.css">
		<link rel="shortcut icon" href="../assets/images/favicon.ico" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-content">
					<div class="page-heading">
						<h3>문의 사항</h3>
					</div>
					<section class="card pt-3">
						<div class="card-content">
							<div class="card-body">
								<h4 class="card-title">제목 : <%=helpOne.getHelpTitle()%></h4>
								<h4 class="card-title">작성자 : <%=helpOne.getMemberId()%></h4>
								<h4 class="card-title">작성일 : <%=helpOne.getCreatedate()%></h4>
								<hr class="mb-4">
								<h6 class="card-subtitle"><%=helpOne.getHelpMemo()%></h6>
								<div class="d-flex justify-content-end mt-3">
									<a class="btn btn-sm btn-primary me-3" href="<%=request.getContextPath()%>/help/helpList.jsp">목록</a>
									<%
										for (HashMap<String, Object> map : list) {
											if (helpNo == (int)map.get("helpNo") && map.get("commentMemo") == null) {
									%>
												<a class="btn btn-sm btn-primary me-3" href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=helpNo%>">수정</a>
												<a class="btn btn-sm btn-primary" href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=helpNo%>">삭제</a>
									<%
											} else if(helpNo == (int)map.get("helpNo") && map.get("commentMemo") != null) {
									%>												
												<a class="btn btn-sm btn-primary me-3 disabled">수정</a>
												<a class="btn btn-sm btn-primary disabled">삭제</a>
									<%
											}
										}
									%>			
								</div>
								<div class="divider mt-5">
                                	<div class="divider-text">답변 목록</div>
                   	  			</div>
								<!-- 해당 문의 답변 리스트 -->
								<%
									for (HashMap<String, Object> m : commentList) {
								%>
										<div class="card m-0">
											<div class="card-content">
												<div class="card-body p-3">
													<div class="list-group">
														<div href="#" class="list-group-item list-group-item-action">
															<div class="d-flex w-100 mb-3 justify-content-between">
																<div class="mb-1 text-primary fw-bold">
																	<div class="avatar avatar-sm me-3">
																		<img src="<%=request.getContextPath()%>/assets/images/faces/1.jpg" alt="face">
																	</div>
																	<%=m.get("memberId")%>1
																</div>
																<small><%=m.get("createdate")%></small>
															</div>
															<p class="mb-1"><%=m.get("commentMemo")%></p>
														</div>
													</div>
												</div>
											</div>
										</div>
								<%
									}
								%>
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
		<script src="../assets/js/pages/dashboard.js"></script>
		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/main.js"></script>
	</body>
</html>