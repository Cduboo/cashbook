<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	
	//문의 상세정보
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);	
	//나의 문의 리스트
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>updateHelpForm</title>
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
				<div class="page-heading">
					<h3>문의 사항</h3>
				</div>
				<div class="page-content">
					<section class="card pt-3">
						<div class="card-content">
							<div class="card-body">
								<form class="form form-horizontal px-4" method="post">
									<div class="form-body">
										<div class="row">
											<div class="col-md-1">
												<label>제목</label>
											</div>
											<div class="col-md-11 form-group">
												<input type="text" class="form-control" name="helpTitle" value="<%=helpOne.getHelpTitle()%>" placeholder="Title">
											</div>
											<div class="col-md-1">
												<label>작성자</label>
											</div>
											<div class="col-md-11 form-group">
												<input type="text" class="form-control" value="<%=helpOne.getMemberId()%>" readonly="readonly">
											</div>
											<div class="col-md-1">
												<label>작성일</label>
											</div>
											<div class="col-md-11 form-group">
												<input type="text" class="form-control" value="<%=helpOne.getCreatedate()%>" readonly="readonly">
											</div>
											<div class="col-md-12 form-group mt-3">
												<textarea id="summernote" name="helpMemo"><%=helpOne.getHelpMemo()%></textarea>
											</div>
											<div class="d-flex justify-content-end mt-3">
												<a class="btn btn-outline-primary me-3" href="<%=request.getContextPath()%>/help/helpList.jsp">목록</a>
												<%
													for (HashMap<String, Object> map : list) {
														if (helpNo == (int)map.get("helpNo") && map.get("commentMemo") == null) {
												%>
															<button class="btn btn-outline-primary me-3" type="submit" formaction="<%=request.getContextPath()%>/help/updateHelpAction.jsp?helpNo=<%=helpNo%>">수정</button>
															<button class="btn btn-outline-primary" type="submit" formaction="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=helpNo%>">삭제</button>
												<%
														}
													}
												%>
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