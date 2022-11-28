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
	<title>noticeList</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<!-- main -->
		<div>
			<h1>공지사항</h1>
			<!-- 공지사항 페이징 -->
			<div>
				<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=1">&lt;&lt;</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage-1%>">&lt;</a>
				<%		
					}
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage+1%>">&gt;</a>
				<%		
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>">&gt;&gt;</a>
				<span>총 <%=noticeCount%>건 page : <%=currentPage%> / <%=lastPage%></span>
			</div>
			<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지등록</a>
			<table border="1">
				<tr>
					<th>제목</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><a href="<%=request.getContextPath()%>/admin/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
	</body>
</html>