<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/adminMain.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	NoticeDao noticeDao = new NoticeDao();
	Notice noticeOne = noticeDao.selectNoticeOne(notice);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateNoticeForm</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<div>
			<h1>공지수정</h1>
			<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp">
				<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
				<input type="text" name="noticeTitle" value="<%=noticeOne.getNoticeTitle()%>">
				<div>
					마지막 수정날짜: <%=noticeOne.getUpdatedate()%>
					공지날짜: <%=noticeOne.getCreatedate()%>
				</div>
				<textarea rows="10" cols="50" name="noticeMemo"><%=noticeOne.getNoticeMemo()%></textarea>
				<button type="submit">수정</button>
			</form>
		</div>		
	</body>
</html>