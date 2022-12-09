<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
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
	int rowPerPage = 10;
	int memberCount = 0;
	int lastPage = 0;
	
	MemberDao memberDao = new MemberDao();
	//전체 회원 수 
	memberCount = memberDao.selectMemberCount();
	//마지막 페이지
	lastPage = memberCount / rowPerPage;
	if(memberCount % rowPerPage != 0) {
		lastPage++;
	}

	if(request.getParameter("currentPage") != null) {
		if(!request.getParameter("currentPage").equals("") && Integer.parseInt(request.getParameter("currentPage")) > 1 && Integer.parseInt(request.getParameter("currentPage")) <= lastPage) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	}
	int beginRow = (currentPage-1) * rowPerPage;
	
	//회원리스트
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>memberList</title>
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
				<div class="page-content">
					<div class="page-heading">
						<h3>회원 관리</h3>
					</div>
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header pt-0">
									<!-- <h4 class="text-end me-3">
										
									</h4> -->
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-sm caption-top" style="table-layout: fixed;">
											<caption>total <%=memberCount%></caption>
											<thead>
												<tr>
													<th>멤버번호</th>
													<th>아이디</th>
													<th>권한</th>
													<th>이름</th>
													<th>수정일자</th>
													<th>가입일</th>
													<th>권한수정</th>
													<th>강제탈퇴</th>
												</tr>
											</thead>
											<tbody>
												<%  
													for(Member m : list) {
												%>
													<form method="post">
													<tr> 
														<td><%=m.getMemberNo()%></td>
														<td><%=m.getMemberId()%></td>
														<td>
															<select class="form-select" name="memberLevel">
															<%
																if(m.getMemberLevel() == 0) {
															%>
																	<option value="0" selected="selected">일반회원</option>
																	<option value="1">관리자</option>
																								
															<%		
																}else if(m.getMemberLevel() == 1) {
															%>									
																	<option value="0">일반회원</option>
																	<option value="1" selected="selected">관리자</option>
															<%		
																}
															%>
															</select>
														</td>
														<td><%=m.getMemberName()%></td>
														<td><%=m.getUpdatedate()%></td>
														<td><%=m.getCreatedate()%></td>
														<td>
															<button class="btn btn-sm btn-light-secondary" type="submit" formaction="<%=request.getContextPath()%>/admin/member/updateMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">수정</button>
														</td>
														<td>
															<button class="btn btn-sm btn-light-secondary" type="submit" formaction="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">탈퇴</button>
														</td>
													</tr>
													</form>
												<%		
													}
												%>
											</tbody>
										</table>
									</div>
									<div class="text-end">page : <%=currentPage%> / <%=lastPage%></div>
									<!-- 회원목록 페이징 -->
									<div class="text-center">
										<a class="me-2" href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=1">&lt;&lt;</a>
										<%
											if(currentPage >= 1){
										%>
												<a class="me-2" href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage-1%>">&lt;</a>
												<span class="me-2"><%=currentPage%></span>
										<%		
											}
											if(currentPage <= lastPage) {
										%>
												<a class="me-2" href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage+1%>">&gt;</a>
										<%		
											}
										%>
										<a class="me-2" href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=lastPage%>">&gt;&gt;</a>
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
	    <script src="../../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../../assets/js/pages/dashboard.js"></script>
	    <script src="../../assets/js/main.js"></script>
	</body>
</html>