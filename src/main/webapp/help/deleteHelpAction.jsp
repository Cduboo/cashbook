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
	int row = helpDao.deleteHelp(helpNo);
	
	if(row == 1) {
		out.println("<script>alert('삭제 완료'); location.href='" + request.getContextPath() + "/help/helpList.jsp" + "';</script>");
	} else {
		out.println("<script>alert('삭제 실패'); location.href='" + request.getContextPath() + "/help/helpList.jsp" + "';</script>");
	}
%>
