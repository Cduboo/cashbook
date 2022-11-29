<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//helpNo
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	//commentNo
	if(request.getParameter("commentNo") == null || request.getParameter("commentNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpOne.jsp?helpNo="+helpNo);
		return;
	}
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	CommentDao commentDao = new CommentDao();
	commentDao.deleteComment(commentNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/help/helpOne.jsp?helpNo="+helpNo);
%>
