<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.ArrayList"%>
<%
	//로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	//공지 페이징
	int currentPage = 1;
	int rowPerPage = 10;
	int noticeCount= 0;
	int lastPage = 0;
	String search = "";
	String select = "";
	
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	
	if(request.getParameter("select") != null) {
		select = request.getParameter("select");
	}
	
	NoticeDao noticeDao = new NoticeDao();
	//전체 회원 수
	noticeCount = noticeDao.selectNoticeCount(select ,search);
	//마지막 페이지
	lastPage = noticeCount / rowPerPage;
	if(noticeCount % rowPerPage != 0) {
		lastPage++;
	}
	
	if(request.getParameter("currentPage") != null) {
		if(!request.getParameter("currentPage").equals("") && Integer.parseInt(request.getParameter("currentPage")) > 1 && Integer.parseInt(request.getParameter("currentPage")) <= lastPage) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	}
	int beginRow = (currentPage - 1) * rowPerPage;
	int showNum = 10; // 보여줄 페이지 수 
	//for문 1:1~10, 2:1~10, 3:1~10... 10: 1~10, 11: 11~20, 12:11~20, ...
	int startNum = currentPage - (currentPage-1) % showNum;
	int endNum = startNum + showNum;
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(select, search, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>index</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
	    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="assets/css/bootstrap.css">
	    <link rel="stylesheet" href="assets/vendors/iconly/bold.css">
	    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
	    <link rel="stylesheet" href="assets/css/app.css">
	    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
	</head>
	
	<body>
		<div id="sidebar" class="active">
			<div class="sidebar-wrapper active">
				<div class="sidebar-header">
					<div class="d-flex justify-content-between">
						<div class="logo">
							<a href="<%=request.getContextPath()%>/cash/cashList.jsp"><img src="assets/images/logo/logo.png" alt="Logo"></a>
						</div>
						<div class="toggler">
							<a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
						</div>
					</div>
				</div>
				<div class="sidebar-menu">
					<ul class="menu">
						<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/index.jsp" class='sidebar-link'>
								<i class="fas fa-home-lg-alt"></i>
								<span>홈</span>
							</a>
						</li>
						<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/loginForm.jsp" class='sidebar-link'>
								<i class="fas fa-user"></i>
								<span>로그인</span>
							</a>
						</li>
					</ul>
				</div>
				<button class="sidebar-toggler btn x">
					<i data-feather="x"></i>
				</button>
			</div>
		</div>
		<div id="main">
			<header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>
			<div class="page-content container">
				<div class="page-heading">
					<h3>공지사항</h3>
				</div>
				<section class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<div class="accordion" id="accordion">
										<table class="table table-hover text-center caption-top" style="table-layout: fixed;">
											<caption>
												total <%=noticeCount%>
											</caption>
											<thead>
												<tr>
													<th style="width: 60%">제목</th>
													<th>작성일</th>
												</tr>
											</thead>
											<tbody>
												<%
												for (Notice n : list) {
												%>
													<tr>
														<td>
															<div class="accordion-item">
																<div class="accordion-header" id="headingOne">
																	<div class="accordion-button" role="button" data-bs-toggle="collapse" data-bs-target="#notice<%=n.getNoticeNo()%>" aria-expanded="true" aria-controls="collapseOne">
																		<%=n.getNoticeTitle()%>
																	</div>
																</div>
																<div id="notice<%=n.getNoticeNo()%>" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordion">
																	<div class="accordion-body mt-5 p-3">
																		<strong><%=n.getNoticeMemo()%></strong>
																	</div>
																</div>
															</div>
														</td>
														<td><%=n.getCreatedate()%></td>
													</tr>
												<%		
													}
												%>
											</tbody>
										</table>
									</div>
								</div>
								<!-- 공지사항 페이징 -->
								<div class="container">
									<div class="text-end">
										page : <%=currentPage%> / <%=lastPage%>
									</div>
									<ul class="pagination pagination-primary justify-content-center">
										<li class="page-item">
											<a class="p-2 page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=1&select=<%=select%>&search=<%=search%>">
												<span aria-hidden="true"><i class="bi bi-chevron-double-left"></i></span>
											</a>
										</li>
										<%
											if(lastPage > 10) {
										%>
											<li class="page-item">
												<a class="p-2 page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-showNum%>&search=<%=search%>">
													<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
												</a>	
											</li>								
										<%		
											}
											for(int i=startNum; i<endNum; i++) {
												if(i <= lastPage) {
													if(currentPage == i){
										%>
														<li class="page-item active">
															<a class="p-2 page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&select=<%=select%>&search=<%=search%>"><%=i%></a>
														</li>																			
										<%				
													}else{
										%>
														<li class="page-item">
															<a class="p-2 page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&select=<%=select%>&search=<%=search%>"><%=i%></a>
														</li>
										<%				
													}										
												}
											}
											if(lastPage > 10) {
										%>
												<li class="page-item">
													<a class="p-2 page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+showNum%>&select=<%=select%>&search=<%=search%>">
														<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
													</a>
												</li>									
										<%		
											}
										%>
										<li class="page-item">
											<a class="p-2 page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>&select=<%=select%>&search=<%=search%>">
												<span aria-hidden="true"><i class="bi bi-chevron-double-right"></i></span>
											</a>
										</li>
									</ul>
									<div class="mt-3">
										<form class="d-flex" action="<%=request.getContextPath()%>/index.jsp">
											<select name="select" class="form-select w-25 me-1">
												<%
													if(select.equals("") || select.equals("title")) {
												%>
														<option value="title">제목</option>
														<option value="memo">본문</option>
														<option value="titleMemo">제목+본문</option>
												<%		
													}
													else if(select.equals("memo")) {
												%>
														<option value="title">제목</option>
														<option value="memo" selected="selected">본문</option>
														<option value="titleMemo">제목+본문</option>
												<%		
													} else if(select.equals("titleMemo")) {
												%>
														<option value="title">제목</option>
														<option value="memo">본문</option>
														<option value="titleMemo" selected="selected">제목+본문</option>
												<%		
													}
												%>
											</select>
											<input class="form-control p-2" type="text" name="search" value="<%=search%>" placeholder="검색">
										</form>
									</div>
								<!-- 공지 페이징 끝 -->
								</div>
							<!-- card body 끝  -->
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	    <script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="assets/js/bootstrap.bundle.min.js"></script>
	    <script src="assets/js/pages/dashboard.js"></script>
	    <script src="assets/js/main.js"></script>
	</body>
</html>