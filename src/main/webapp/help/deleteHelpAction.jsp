<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	helpDao.deleteHelp(helpNo);
	
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
%>
