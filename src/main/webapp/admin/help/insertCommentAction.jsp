<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%@page import="java.util.HashMap"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	
	//helpNo
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	//commentMemo
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/help/helpOne.jsp?helpNo="+helpNo);
		return;
	}
	String commentMemo = request.getParameter("commentMemo");
	
	//memberId
	String memberId = loginMember.getMemberId();
	
	HashMap<String, Object> map = new HashMap<>();
	map.put("helpNo", helpNo);
	map.put("commentMemo", commentMemo);
	map.put("memberId", memberId);
	
	CommentDao commentDao = new CommentDao();
	commentDao.insertComment(map);
	
	response.sendRedirect(request.getContextPath()+"/admin/help/helpOne.jsp?helpNo="+helpNo);
%>
