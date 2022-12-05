<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.HelpDao"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

	//나의 문의 리스트
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>helpList</title>
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
				<div class="page-heading">
					<h3>1대1 문의</h3>
				</div>
				<div class="page-content">
					<section class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h4 class=" me-3">
										내 문의 사항
									</h4>
									<h4 class="text-end me-3">
										<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">+ 1대1 문의</a>
									</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-lg" style="table-layout: fixed;">
											<thead>
												<tr>
													<th class="text-center" style="width: 70%">제목</th>
													<th>작성일</th>
													<th>답변일</th>
												</tr>
											</thead>
											<tbody>
												<%
													for(HashMap<String, Object> m : list) {
												%>
														<tr>
															<td class="text-center"><a href="<%=request.getContextPath()%>/help/helpOne.jsp?helpNo=<%=m.get("helpNo")%>"><%=m.get("helpTitle")%></a></td>
															<td><%=m.get("helpCreatedate")%></td>
															<td>
																<%
																	if(m.get("commentCreatedate") == null) {
																%>
																		Before answering 
																<%
																	}else {
																%>
																		<%=m.get("commentCreatedate")%>
																<%		
																	}
																%>
															</td>
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
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../assets/js/pages/dashboard.js"></script>
	    <script src="../assets/js/main.js"></script>
	</body>
</html>