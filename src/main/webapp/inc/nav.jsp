<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!-- nav  -->
<div>
	<h1>내정보</h1>
	<div>
		<%=loginMember.getMemberName()%>
		<%=loginMember.getMemberId()%>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보 수정</a>
		<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 수정</a>
		<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a>
	</div>
</div>
