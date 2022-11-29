<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
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
		<title>noticeOne</title>
	</head>
	<body>
		<!-- header -->
		<div>
			<!-- 홈 링크 로고 추가 -->
			<a href="<%=request.getContextPath()%>/index.jsp">가계부</a>
			<div> 
				<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a>
				<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
			</div>
		</div>
		
		<!-- nav -->	
		
		<!-- main -->
		<div>
			<h1>공지사항</h1>
			<form method="post">
				<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
				<input type="hidden" name="noticeTitle" value="<%=noticeOne.getNoticeTitle()%>">
				<input type="hidden" name="noticeMemo" value="<%=noticeOne.getNoticeMemo()%>">
				<div>
					<button type="submit" formaction="<%=request.getContextPath()%>/index.jsp">목록</button>
				</div>
				<div><%=noticeOne.getNoticeTitle()%></div>
				<div>
					공지날짜: <%=noticeOne.getCreatedate()%>
				</div>
				<div><%=noticeOne.getNoticeMemo()%></div>
			</form>
		</div>		
	</body>
</html>