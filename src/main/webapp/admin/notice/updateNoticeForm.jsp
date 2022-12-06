<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	NoticeDao noticeDao = new NoticeDao();
	Notice noticeOne = noticeDao.selectNoticeOne(notice);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>updateNoticeForm</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="../../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../../assets/vendors/iconly/bold.css">
		<link rel="stylesheet" href="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
		<link rel="stylesheet" href="../../assets/vendors/bootstrap-icons/bootstrap-icons.css">
		<link rel="stylesheet" href="../../assets/css/app.css">
		<link rel="stylesheet" href="../../assets/vendors/summernote/summernote-lite.min.css">
		<link rel="shortcut icon" href="../../assets/images/favicon.svg" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-content w-75 m-auto">
					<div class="page-heading">
						<h3>Notice Management</h3>
					</div>
					<section class="card">
						<div class="card-header">
							<h4 class="card-title">Notice</h4>
						</div>
						<div class="card-content">
							<div class="card-body">
								<form class="form form-horizontal px-4" action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post">
									<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
									<div class="form-body">
										<div class="row">
											<div class="col-md-1">
												<label for="title">Title</label>
											</div>
											<div class="col-md-11 form-group">
												<input type="text" class="form-control" id="title" name="noticeTitle" value="<%=noticeOne.getNoticeTitle()%>" placeholder="Title">
											</div>
											<div class="col-md-12 form-group mt-3">
												<textarea id="summernote" name="noticeMemo"><%=noticeOne.getNoticeMemo()%></textarea>
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
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="../../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../../assets/vendors/jquery/jquery.min.js"></script>
	    <script src="../../assets/vendors/summernote/summernote-lite.min.js"></script>
	    <script>
	        $('#summernote').summernote({
	            tabsize: 2,
	            height: 300,
	        });	      
	    </script>
		<script src="../../assets/js/pages/dashboard.js"></script>
		<script src="../../assets/js/main.js"></script>	
	</body>
</html>