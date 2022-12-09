<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
<%@ page import="java.net.*"%>
<%
	//C
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	if(request.getParameter("memberLevel") == null || request.getParameter("memberLevel").equals("")
		|| request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(member);
	
	if(row == 1) {
		out.println("<script>alert('수정 완료'); location.href='" + request.getContextPath() + "/admin/member/memberList.jsp" + "';</script>");
	} else {
		out.println("<script>alert('수정 실패'); location.href='" + request.getContextPath() + "/admin/member/memberList.jsp" + "';</script>");
	}
%>
