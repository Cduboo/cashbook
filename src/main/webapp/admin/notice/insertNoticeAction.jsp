<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");	
	
 	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeTitle").equals("")
 		|| request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
		return;
	}
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeMemo = request.getParameter("noticeMemo");
	
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeMemo(noticeMemo);
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insertNotice(notice);
	
	response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
%>
