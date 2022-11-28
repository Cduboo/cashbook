<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
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
	int rowPerPage = 3;
	int memberCount = 0;
	int lastPage = 0;
	
	MemberDao memberDao = new MemberDao();
	//전체 회원 수 
	memberCount = memberDao.selectMemberCount();
	//마지막 페이지
	lastPage = memberCount / rowPerPage;
	if(memberCount % rowPerPage != 0) {
		lastPage++;
	}

	if(request.getParameter("currentPage") != null) {
		if(!request.getParameter("currentPage").equals("") && Integer.parseInt(request.getParameter("currentPage")) > 1 && Integer.parseInt(request.getParameter("currentPage")) <= lastPage) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	}
	int beginRow = (currentPage-1) * rowPerPage;
	
	//회원리스트
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	//V
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>memberList</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<!-- nav -->	
		<jsp:include page="/inc/navAdmin.jsp"></jsp:include>
		
		<div>
			<h1>회원목록</h1>
			<!-- 회원목록 페이징 -->
			<div>
				<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=1">&lt;&lt;</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage-1%>">&lt;</a>
				<%		
					}
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage+1%>">&gt;</a>
				<%		
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=lastPage%>">&gt;&gt;</a>
				<span>총 <%=memberCount%>건 page : <%=currentPage%> / <%=lastPage%></span>
			</div>
<%-- 			<table border="1">
				<tr>
					<th>멤버번호</th>
					<th>아이디</th>
					<th>권한</th>
					<th>이름</th>
					<th>수정일자</th>
					<th>생성일자</th>
					<th>권한수정</th>
					<th>강제탈퇴</th>
				</tr>
				<%  //table안에 form , 관리자 -> 일반회원으로 변경해도 관리자페이지에 머뭄. 수정 
					for(Member m : list) {
				%>
					<tr> 
						<form action="<%=request.getContextPath()%>/admin/member/updateMemberAction.jsp" method="post">
							<input type="hidden" name="memberNo" value="<%=m.getMemberNo()%>">
								<td><%=m.getMemberNo()%></td>
								<td><%=m.getMemberId()%></td>
								<td>
									<%
										if(m.getMemberLevel() == 0){
									%>
											<select name="memberLevel">
												<option value="0" selected="selected">일반회원</option>
												<option value="1">관리자</option>
											</select>								
									<%		
										}else {
									%>
											<select name="memberLevel">
												<option value="0">일반회원</option>
												<option value="1" selected="selected">관리자</option>
											</select>								
									<%		
										}
									%>
								</td>
								<td><%=m.getMemberName()%></td>
								<td><%=m.getUpdatedate()%></td>
								<td><%=m.getCreatedate()%></td>
								<td>
									<button type="submit">수정</button>
								</td>
								<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">삭제</a></td>
						</form>
					</tr>
				<%		
					}
				%>
			</table> --%>
				<div>
					멤버번호
					아이디
					권한
					이름
					수정일자
					생성일자
					권한수정
					강제탈퇴
				</div>
				<%
					for(Member m : list) {
				%>
					<div>
						<form method="post">
							<%=m.getMemberNo()%>
							<%=m.getMemberId()%>
							<select name="memberLevel">
							<%
								if(m.getMemberLevel() == 0) {
							%>
									<option value="0" selected="selected">일반회원</option>
									<option value="1">관리자</option>
																
							<%		
								}else if(m.getMemberLevel() == 1) {
							%>
									
									<option value="0">일반회원</option>
									<option value="1" selected="selected">관리자</option>
							<%		
								}
							%>
							</select>	
							<%=m.getMemberName()%>
							<%=m.getUpdatedate()%>
							<%=m.getCreatedate()%>
							<button type="submit" formaction="<%=request.getContextPath()%>/admin/member/updateMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">수정</button>
							<button type="submit" formaction="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">삭제</button>
						</form>
					</div>
				<%		
					}
				%>
		</div>
	</body>
</html>