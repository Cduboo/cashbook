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
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		
		<!-- main -->
		<h1>고객센터</h1>
		<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a>
		<table>
			<tr>
				<th>제목</th>
				<th>문의날짜</th>
				<th>답변날짜</th>
			</tr>
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
		</table>
	</body>
</html>