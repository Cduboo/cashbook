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
		<meta charset="UTF-8">
		<title>helpList</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<!-- 고객센터 문의 목록 -->
		<table border="1">
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list) {
			%>
					<tr>
						<td><a href="<%=request.getContextPath()%>/admin/help/helpOne.jsp?helpNo=<%=m.get("helpNo")%>"><%=m.get("helpTitle")%></a></td>
						<td><%=m.get("memberId")%></td>
						<td><%=m.get("createdate")%></td>
					</tr>
			<%		
				}
			%>
		</table>
	</body>
</html>