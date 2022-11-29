<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.HelpDao"%>
<%
	request.setCharacterEncoding("utf-8");	

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")
		|| request.getParameter("helpTitle") == null || request.getParameter("helpTitle").equals("")) {
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	}
	//helpTitle
	String helpTitle = request.getParameter("helpTitle");
	//helpMemo
	String helpMemo = request.getParameter("helpMemo");
	//memberId
	Member loginMember = (Member)session.getAttribute("loginMember");	
	String memberId = loginMember.getMemberId();	
	
	Help help = new Help();
	help.setHelpMemo(request.getParameter("helpMemo"));
	help.setHelpTitle(helpTitle);
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	
	HelpDao helpDao = new HelpDao();
	helpDao.insertHelp(help);
	
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
%>