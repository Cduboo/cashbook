<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.MemberDao"%>
<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("name") == null || request.getParameter("name").equals("")  
		|| request.getParameter("id") == null || request.getParameter("id").equals("") 
		|| request.getParameter("pw") == null || request.getParameter("pw").equals("")){
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp");
		return;
	}
	
	Member member = new Member();
	member.setMemberId(request.getParameter("id"));
	member.setMemberPw(request.getParameter("pw"));
	member.setMemberName(request.getParameter("name"));
	
	MemberDao memberDao = new MemberDao();
	//true -> 중복된 아이디
	if(memberDao.selectMemberIdCk(member.getMemberId())) {
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp");
		return;
	}
	//중복된 아이디가 아니라면
	int row = memberDao.insertMember(member);
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>
