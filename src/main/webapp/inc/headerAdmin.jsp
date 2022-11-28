<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!-- header -->
<div>
	<!-- 홈 링크 로고 추가 -->
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a>
	<div> <!-- drop down 처리 -->
		<a href="#"><%=loginMember.getMemberName()%></a> <!-- dropdown-toggle -->
		<div>
			<div>
				<div>
					<%=loginMember.getMemberName()%>님
					<a href="<%=request.getContextPath()%>/logOut.jsp">로그아웃</a>
				</div>
				<div><%=loginMember.getMemberId()%></div>						
			</div>
			<div>
				<%
					if(loginMember.getMemberLevel() > 0) {
				%>
						<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
				<%		
					}
				%>
				<a href="<%=request.getContextPath()%>/member/memberOneForm.jsp">마이페이지</a>
			</div>
		</div>
	</div>
</div>