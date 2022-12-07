<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.HelpDao"%>
<%@ page import="vo.Member"%>
<% 
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); 
	}
	int rowPerPage = 10;
	int beginRow = (currentPage -1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta charset="UTF-8">
		<title>helpList</title>
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
						<h3>1:1 문의 목록</h3>
					</div>
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-md" style="table-layout: fixed;">
											<thead>
												<tr>
													<th class="text-center" style="width: 30%">제목</th>
													<th>작성자</th>
													<th>작성일</th>
													<th>답변일</th>
												</tr>
											</thead>
											<tbody>
												<%
													for(HashMap<String, Object> m : list) {
												%>
														<tr>
															<td class="text-center"><a href="<%=request.getContextPath()%>/admin/help/helpOne.jsp?helpNo=<%=m.get("helpNo")%>"><%=m.get("helpTitle")%></a></td>
															<td><%=m.get("memberId")%></td>
															<td><%=m.get("createdate")%></td>
															<td>답변일 조인하기</td>
														</tr>
												<%		
													}
												%>
											</tbody>
										</table>
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