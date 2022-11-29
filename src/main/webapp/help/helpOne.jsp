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
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		
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
	</body>
</html>