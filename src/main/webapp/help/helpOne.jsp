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
	//해당 문의글의 답변 리스트 출력
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> commentList = commentDao.selectCommentList(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpOne</title>
		<!-- css -->
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
			<div class="container-fluid page-body-wrapper" style="background-color: #F4F7FA;">
				<!-- 네비게이션/사이드  -->
				<jsp:include page="/inc/nav.jsp"></jsp:include>
				<!-- main -->
				<div class="container col-md-6 grid-margin stretch-card mt-5" style="height: 500px;">
					<div class="card">
						<div class="card-body">
							<p class="card-description">Service center</p>
							<h4 class="card-title mb-5">Q&A</h4>
							<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post" class="forms-sample">
								<div class="form-group row">
									<label for="exampleInputUsername2" class="col-sm-3 col-form-label">ID</label>
									<div class="col-sm-9">
										<input type="text" value="<%=loginMember.getMemberId()%>" readonly="readonly" class="form-control" id="exampleInputUsername2" placeholder="Username">
									</div>
								</div>
								<div class="form-group row">
									<label for="exampleInputEmail2" class="col-sm-3 col-form-label">NAME</label>
									<div class="col-sm-9">
										<input type="text" name="updateName" value="<%=loginMember.getMemberName()%>" class="form-control" id="exampleInputEmail2" placeholder="Email">
									</div>
								</div>   
								<div class="form-group row">
									<label for="exampleInputPassword2" class="col-sm-3 col-form-label">Password</label>
									<div class="col-sm-9">
										<input type="password" name="currentPw" class="form-control" id="exampleInputPassword2" placeholder="Password">
									</div>
								</div>
								<button type="submit" class="btn btn-primary mr-2">Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- main -->
		<div>
			<h1>문의사항</h1>
				<div>제목 : <%=helpOne.getHelpTitle()%></div>
				<div>작성자 : <%=helpOne.getMemberId()%></div>
				<div>
					작성일: <%=helpOne.getCreatedate()%>
				</div>
				<div><%=helpOne.getHelpMemo()%></div>
			<a href="<%=request.getContextPath()%>/help/helpList.jsp">목록</a>
			
			<%
				for(HashMap<String, Object> map : list){
					if(helpNo == (int)map.get("helpNo") && map.get("commentMemo") == null) {
			%>		
						<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=helpNo%>">수정</a>
						<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=helpNo%>">삭제</a>
			<%
					}
				}
			%>	
		</div>	
		
		<!-- 해당 문의 답변 리스트 -->
		<%
		for(HashMap<String, Object> m : commentList) {
		%>	
			<div>
				<div>
					<%=m.get("memberId")%>
					<%=m.get("createdate")%>
				</div>
				<div>
					<%=m.get("commentMemo")%>
				</div>						
			</div>
		<%		
			}
		%>
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