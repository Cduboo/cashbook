<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@page import="dao.MemberDao"%>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("updateId") == null || request.getParameter("updateId").equals("")
		|| request.getParameter("updateName") == null || request.getParameter("updateName").equals("")){
		String msg = URLEncoder.encode("수정할 아이디와 이름을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	//입력한 수정 정보 -> Member vo 묶기
	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("updateId"));
	updateMember.setMemberName(request.getParameter("updateName"));
	updateMember.setMemberPw(request.getParameter("currentPw"));
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	//기존 아이디,이름 비교 -> 변경이 일어나지 않으면 수정 x
	if(updateMember.getMemberId().equals(loginMember.getMemberId()) && updateMember.getMemberName().equals(loginMember.getMemberName())){
		String msg = URLEncoder.encode("기존 정보와 동일합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMember(loginMember.getMemberId(), updateMember);
	if(row != 1) {
		String msg = URLEncoder.encode("비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	//수정 성공 시 session update
	session.setAttribute("loginMember", updateMember);
	response.sendRedirect(request.getContextPath()+"/memberOneForm.jsp");
%>
