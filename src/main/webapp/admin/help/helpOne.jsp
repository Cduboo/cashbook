<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	//문의 상세정보
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);	
	
	
   	//해당 문의글의 답변 리스트 출력
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> list = commentDao.selectCommentList(helpNo);
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
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<!-- main -->
		<div>
			<div>
				<h1>문의사항</h1>
					<div>제목 : <%=helpOne.getHelpTitle()%></div>
					<div>작성자 : <%=helpOne.getMemberId()%></div>
					<div>
						작성일: <%=helpOne.getCreatedate()%>
					</div>
					<div><%=helpOne.getHelpMemo()%></div>
				<a href="<%=request.getContextPath()%>/admin/help/helpList.jsp">목록</a>
			</div>	
			
			<!-- 해당 문의 답변 리스트 -->
			<%
				for(HashMap<String, Object> m : list) {
			%>
					<div>
						<div>
							<%=m.get("memberId")%>
							<%=m.get("createdate")%>
							<a href="<%=request.getContextPath()%>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">수정</a>
							<a href="<%=request.getContextPath()%>/admin/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">삭제</a>
						</div>
						<div>
							<%=m.get("commentMemo")%>
						</div>						
					</div>
			<%		
				}
			%>
			
			<!-- 답변 입력/삭제 -->
			<form action="<%=request.getContextPath()%>/admin/help/insertCommentAction.jsp" method="post">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<textarea rows="10" cols="30" name="commentMemo"></textarea>
				<button type="submit">답변입력</button>	
			</form>
		</div>		
	</body>
</html>