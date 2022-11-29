<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.HelpDao"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	if(request.getParameter("helpTitle") == null || request.getParameter("helpTitle").equals("")
		|| request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")){
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?helpNo="+helpNo);
		return;
	}
	
	String helpTitle = request.getParameter("helpTitle");
	String helpMemo = request.getParameter("helpMemo");
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpTitle(helpTitle);
	help.setHelpMemo(helpMemo);
	
	HelpDao helpDao = new HelpDao();
	helpDao.updateHelp(help);
	
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
%>
