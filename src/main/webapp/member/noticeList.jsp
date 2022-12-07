<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//M
	int currentPage = 1;
	int rowPerPage = 5;
	int noticeCount = 0;
	int lastPage = 0;
	
	NoticeDao noticeDao = new NoticeDao();
	//전체 회원 수 
	noticeCount = noticeDao.selectNoticeCount();
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
	int beginRow = (currentPage-1) * rowPerPage;
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	//V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>noticeList</title>
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
									<table class="table table-sm table-hover text-center caption-top" style="table-layout: fixed;">
										<caption>total <%=noticeCount%></caption>
										<thead>
											<tr>
												<th style="width: 60%">제목</th>
												<th>작성일</th>
											</tr>
										</thead>
										<tbody>
											<%
												for(Notice n : list) {
											%>		
													<tr> 
														<td>
															<a href="#" data-bs-toggle="modal" data-bs-target="#notice<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a>
	                                           				<div class="modal fade" id="notice<%=n.getNoticeNo()%>" tabindex="-1" role="dialog"
					                                            aria-labelledby="noticeTitle" aria-hidden="true">
					                                            <div class="modal-dialog modal-dialog-scrollable" role="document">
					                                                <div class="modal-content w-100">
					                                                    <div class="modal-header">
					                                                        <h5 class="modal-title" id="noticeTitle">
					                                                            <%=n.getNoticeTitle()%></h5>
					                                                        <button type="button" class="close" data-bs-dismiss="modal"
					                                                            aria-label="Close">
					                                                            <i data-feather="x"></i>
					                                                        </button>
					                                                    </div>
					                                                    <div class="modal-body">
					                                                        <div class="text-end mb-3"><%=n.getCreatedate()%></div>
					                                                        <p><%=n.getNoticeMemo()%></p>
					                                                    </div>
					                                                    <div class="modal-footer">
					                                                        <button type="button" class="btn btn-light-secondary"
					                                                            data-bs-dismiss="modal">
					                                                            <i class="bx bx-x d-block d-sm-none"></i>
					                                                            <span class="d-none d-sm-block">Close</span>
					                                                        </button>
					                                                    </div>
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
								<div class="text-end">page : <%=currentPage%> / <%=lastPage%></div>
								<!-- 공지사항 페이징 -->
								<div class="text-center">
									<a class="me-2" href="<%=request.getContextPath()%>/member/noticeList.jsp?currentPage=1">&lt;&lt;</a>
									<%
										if(currentPage >= 1){
									%>
											<a class="me-2" href="<%=request.getContextPath()%>/member/noticeList.jsp?currentPage=<%=currentPage-1%>">&lt;</a>
											<span class="me-2"><%=currentPage%></span>
									<%		
										}
										if(currentPage <= lastPage) {
									%>
											<a class="me-2" href="<%=request.getContextPath()%>/member/noticeList.jsp?currentPage=<%=currentPage+1%>">&gt;</a>
									<%		
										}
									%>
									<a class="me-2" href="<%=request.getContextPath()%>/member/noticeList.jsp?currentPage=<%=lastPage%>">&gt;&gt;</a>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		</div>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../assets/js/pages/dashboard.js"></script>
	    <script src="../assets/js/main.js"></script>
	</body>
</html>