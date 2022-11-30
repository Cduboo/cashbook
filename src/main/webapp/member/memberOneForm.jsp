<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>memberOne</title>
		<!-- css -->
		<link rel="stylesheet" href="../vendors/mdi/css/materialdesignicons.min.css">
		<link rel="stylesheet" href="../vendors/feather/feather.css">
		<link rel="stylesheet" href="../vendors/base/vendor.bundle.base.css">
		<link rel="stylesheet" href="../vendors/flag-icon-css/css/flag-icon.min.css"/>
		<link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../vendors/jquery-bar-rating/fontawesome-stars-o.css">
		<link rel="stylesheet" href="../vendors/jquery-bar-rating/fontawesome-stars.css">
		<link rel="stylesheet" href="../css/style.css">
		<link rel="shortcut icon" href="../images/favicon.png" />
	</head>
	<body>
		<!-- 네비게이션/헤더부분 -->
		<div class="container-scroller">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<!-- 네비게이션/사이드  -->
			<jsp:include page="/inc/nav.jsp"></jsp:include>
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