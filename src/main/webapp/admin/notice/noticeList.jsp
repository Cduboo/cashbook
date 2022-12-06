<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	//C
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
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
				<div class="page-content w-75 m-auto">
					<div class="page-heading">
						<h3>공지사항 관리</h3>
					</div>
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h4 class="text-end me-3">
										<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">+ 공지 등록</a>
									</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-md table-hover text-center caption-top" style="table-layout: fixed;">
											<caption>total <%=noticeCount%></caption>
											<thead>
												<tr>
													<th>제목</th>
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
						                                                <div class="modal-content p-3">
						                                                    <div class="modal-header">
						                                                        <h5 class="modal-title" id="noticeTitle"><%=n.getNoticeTitle()%></h5>
						                                                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
						                                                            <i data-feather="x"></i>
						                                                        </button>
						                                                    </div>
						                                                    <div class="modal-body">
						                                                        <div class="text-end mb-3"><%=n.getCreatedate()%></div>
						                                                        <p><%=n.getNoticeMemo()%></p>
						                                                    </div>
					                                                    	<form method="post">
							                                                    <div class="modal-footer">
																					<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
																					<input type="hidden" name="noticeTitle" value="<%=n.getNoticeTitle()%>">
																					<input type="hidden" name="noticeMemo" value="<%=n.getNoticeMemo()%>">
							                                                        <button type="submit" class="btn btn-primary ml-1" formaction="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp">
							                                                            <i class="bx bx-check d-block d-sm-none"></i>
							                                                            <span class="d-none d-sm-block">수정</span>
							                                                        </button>
							                                                        <button type="submit" class="btn btn-primary ml-1" formaction="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp">
							                                                            <i class="bx bx-check d-block d-sm-none"></i>
							                                                            <span class="d-none d-sm-block">삭제</span>
							                                                        </button>
							                                                        <button type="submit" class="btn btn-light-secondary" data-bs-dismiss="modal">
							                                                            <i class="bx bx-x d-block d-sm-none"></i>
							                                                            <span class="d-none d-sm-block">닫기</span>
							                                                        </button>
							                                                    </div>
						                                                    </form>
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
									<div class="mt-2 text-center">
										<a class="me-2" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=1">&lt;&lt;</a>
										<%
											if(currentPage >= 1){
										%>
												<a class="me-2" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage-1%>">&lt;</a>
												<span class="me-2"><%=currentPage%></span>
										<%		
											}
											if(currentPage <= lastPage) {
										%>
												<a class="me-2" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage+1%>">&gt;</a>
										<%		
											}
										%>
										<a class="me-2" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>">&gt;&gt;</a>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../../assets/js/pages/dashboard.js"></script>
	    <script src="../../assets/js/main.js"></script>
	</body>
</html>