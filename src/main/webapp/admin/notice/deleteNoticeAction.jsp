<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect(request.getContextPath()+"/admin/adminMain.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNotice(notice);
	response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
%>