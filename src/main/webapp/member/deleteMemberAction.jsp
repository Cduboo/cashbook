<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.*"%>
<%
	request.setCharacterEncoding("utf-8");

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){
		String msg = URLEncoder.encode("비밀번호를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg3="+msg);
		return;
	}
	
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	//탈퇴확인비밀번호
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberId(loginMemberId);
	member.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(member);
	
	if(row == 0) {
		String msg = URLEncoder.encode("잘못된 패스워드", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg3="+msg);
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/logOut.jsp");
%>