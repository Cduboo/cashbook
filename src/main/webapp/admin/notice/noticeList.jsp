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
	int beginRow = (currentPage-1) * rowPerPage;
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
		<title>noticeList</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
	    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="../../assets/css/bootstrap.css">
	    <link rel="stylesheet" href="../../assets/vendors/iconly/bold.css">
	    <link rel="stylesheet" href="../../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	    <link rel="stylesheet" href="../../assets/vendors/bootstrap-icons/bootstrap-icons.css">
	    <link rel="stylesheet" href="../../assets/css/app.css">
	    <link rel="shortcut icon" href="../../assets/images/favicon.ico" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>			
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-content">
					<div class="page-heading">
						<h3>공지사항 관리</h3>
					</div>
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header pb-0">
									<h4 class="text-end me-3">
										<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">+ 공지 등록</a>
									</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<div class="accordion" id="accordion">
											<table class="table table-hover text-center caption-top" style="table-layout: fixed;">
												<caption>
													total
													<%=noticeCount%></caption>
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
																		<div class="accordion-body p-3">
																			<strong><%=n.getNoticeMemo()%></strong>
																			<form class="mt-3" method="post">
																				<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
																				<input type="hidden" name="noticeTitle" value="<%=n.getNoticeTitle()%>">
																				<input type="hidden" name="noticeMemo" value="<%=n.getNoticeMemo()%>">
						                                                        <button type="submit" class="btn btn-sm btn-link" formaction="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp">
					                                                            	수정
						                                                        </button>
						                                                        <button type="submit" class="btn btn-sm btn-link" formaction="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp">
					                                                            	삭제
						                                                        </button>
						                                                        <button type="submit" class="btn btn-sm btn-link">
						                                                            닫기
						                                                        </button>
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
									</div>
									<!-- 공지사항 페이징 -->
									<div class="container">
										<div class="text-end">
											page : <%=currentPage%> / <%=lastPage%>
										</div>
										<ul class="pagination pagination-primary justify-content-center">
											<li class="page-item">
												<a class="p-2 page-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=1&select=<%=select%>&search=<%=search%>">
													<span aria-hidden="true"><i class="bi bi-chevron-double-left"></i></span>
												</a>
											</li>
											<%
												if(lastPage > 10) {
											%>
												<li class="page-item">
													<a class="p-2 page-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage-showNum%>&search=<%=search%>">
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
																<a class="p-2 page-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=i%>&select=<%=select%>&search=<%=search%>"><%=i%></a>
															</li>																			
											<%				
														}else{
											%>
															<li class="page-item">
																<a class="p-2 page-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=i%>&select=<%=select%>&search=<%=search%>"><%=i%></a>
															</li>
											<%				
														}										
													}
												}
												if(lastPage > 10) {
											%>
													<li class="page-item">
														<a class="p-2 page-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage+showNum%>&select=<%=select%>&search=<%=search%>">
															<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
														</a>
													</li>									
											<%		
												}
											%>
											<li class="page-item">
												<a class="p-2 page-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>&select=<%=select%>&search=<%=search%>">
													<span aria-hidden="true"><i class="bi bi-chevron-double-right"></i></span>
												</a>
											</li>
										</ul>
										<div class="mt-3">
											<form class="d-flex" action="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">
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
								<!-- card body 끝 -->
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