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
		<title>helpList</title>
		<!-- css -->
		<!-- CSS only -->
		<link rel="stylesheet" href="../vendors/mdi/css/materialdesignicons.min.css">
		<link rel="stylesheet" href="../vendors/feather/feather.css">
		<link rel="stylesheet" href="../vendors/base/vendor.bundle.base.css">
		<link rel="stylesheet" href="../vendors/flag-icon-css/css/flag-icon.min.css"/>
		<link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../vendors/jquery-bar-rating/fontawesome-stars-o.css">
		<link rel="stylesheet" href="../vendors/jquery-bar-rating/fontawesome-stars.css">
		<link rel="stylesheet" href="../css/style.css">
		<link rel="stylesheet" href="../css/styles.css">
		<link rel="shortcut icon" href="../images/favicon.png" />
	</head>
	<body>
		<!-- 네비게이션/헤더부분 -->
		<div class="container-scroller">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="container-fluid page-body-wrapper">
				<!-- 네비게이션/사이드  -->
				<jsp:include page="/inc/nav.jsp"></jsp:include>
				<!-- 고객센터 -->
				<div class="main-panel">
		        	<div class="content-wrapper">
						<div class="stretch-card">
							<div class="card">
								<div class="card-body">
									<div class="d-flex justify-content-between align-items-center">
										<h1>고객센터</h1>
										<a class="btn btn-info font-weight-bold" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">+ 문의하기</a>
									</div>
									<div class="table-responsive mt-3">
										<table class="table table-header-bg">
											<thead>
												<tr>
													<th>제목</th>
													<th>문의날짜</th>
													<th>답변날짜</th>
												</tr>
											</thead>
											<tbody>
												<%
													for(HashMap<String, Object> m : list) {
												%>
														<tr>
															<td><a href="<%=request.getContextPath()%>/help/helpOne.jsp?helpNo=<%=m.get("helpNo")%>"><%=m.get("helpTitle")%></a></td>
															<td><%=m.get("helpCreatedate")%></td>
															<td>
																<%
																	if(m.get("commentCreatedate") == null) {
																%>
																		답변전 
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
					</div>
				</div>
			</div>
		</div>
		<!-- js -->
		<script src="../vendors/base/vendor.bundle.base.js"></script>
		<script src="../js/off-canvas.js"></script>
		<script src="../js/hoverable-collapse.js"></script>
		<script src="../js/template.js"></script>
		<script src="../vendors/chart.js/Chart.min.js"></script>
		<script src="../vendors/jquery-bar-rating/jquery.barrating.min.js"></script>
		<script src="../js/dashboard.js"></script>
		<script src="https://kit.fontawesome.com/0917e5f385.js" crossorigin="anonymous"></script>
	</body>
</html>