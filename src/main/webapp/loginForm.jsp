<%@page import="vo.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	//로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	//공지 페이징
	int currentPage = 1;
	int rowPerPage = 5;
	int noticeCount= 0;
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
	int beginRow = (currentPage - 1) * rowPerPage;
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
	</head>
	<body>
		<h1>공지사항</h1>
		<!-- 공지사항 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">&lt;&lt;</a>
			<%
				if(currentPage > 1){
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">&lt;</a>
			<%		
				}
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">&gt;</a>
			<%		
				}
			%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">&gt;&gt;</a>
			<span>총 <%=noticeCount%>건 page : <%=currentPage%> / <%=lastPage%></span>
		</div>
		<!-- (최근 공지 5개) 게시판 -->
		<div>
			<table border="1">
				<tr>
					<th>제목</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : list) {
				%>		
						<tr> 
							<td><%=n.getNoticeTitle()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		
		<!-- 로그인 폼 -->
		<div>
			<form action="<%=request.getContextPath()%>/loginAction.jsp">
				<input type="text" name="id" placeholder="아이디">
				<input type="password" name="pw" placeholder="패스워드">
				<button type="submit">로그인</button>
			</form>			
			<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
		</div>
	</body>
</html>