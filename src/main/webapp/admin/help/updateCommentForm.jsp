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
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	//문의 상세정보
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);	
	
   	//해당 문의글의 답변 리스트 출력
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> list = commentDao.selectCommentList(helpNo);
	
	//답변 정보
	HashMap<String, Object> map = commentDao.selectCommentOne(commentNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateComment.jsp</title>
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
						<form method="post">
			<%
					if(Integer.parseInt(m.get("commentNo").toString()) == Integer.parseInt(map.get("commentNo").toString())){
			%>
						<div>
							<div>
								<%=m.get("memberId")%>
								<%=m.get("createdate")%>
								<button type="submit" formaction="<%=request.getContextPath()%>/admin/help/updateCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">수정</button>
								<button type="submit" formaction="<%=request.getContextPath()%>/admin/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">삭제</button>
							</div>
							<div>
								<textarea rows="10" cols="30" name="commentMemo"><%=m.get("commentMemo")%></textarea>
							</div>						
						</div>						
			<%			
					}else {
			%>
						<div>
							<div>
								<%=m.get("memberId")%>
								<%=m.get("createdate")%>
								<button type="submit" formaction="<%=request.getContextPath()%>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">수정</button>
								<button type="submit" formaction="<%=request.getContextPath()%>/admin/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&helpNo=<%=helpNo%>">삭제</button>
							</div>
							<div>
								<%=m.get("commentMemo")%>
							</div>						
						</div>			
			<%			
					}
				}
			%>
						</form>
					</div>
			
			<!-- 답변 입력/삭제 -->
			<form action="<%=request.getContextPath()%>/admin/help/insertCommentAction.jsp" method="post">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<textarea rows="10" cols="30" name="commentMemo"></textarea>
				<button type="submit">답변입력</button>	
			</form>
		</div>		
	</body>
</html>