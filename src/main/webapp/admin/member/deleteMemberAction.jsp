<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
<%@ page import="java.net.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByAdmin(member);
	
	String delete = URLEncoder.encode("탈퇴 완료", "utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp?delete="+delete);
%>
