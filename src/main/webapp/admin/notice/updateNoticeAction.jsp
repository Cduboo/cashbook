<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.NoticeDao"%>
<%
	//관리자가 아닐 경우 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeTitle").equals("")
		|| request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/notice/updateNoticeForm.jsp?noticeNo="+noticeNo);
		return;
	}
		
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeMemo = request.getParameter("noticeMemo");
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeMemo(noticeMemo);
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.updateNotice(notice);
	
	if(row == 1) {
		out.println("<script>alert('수정 완료'); location.href='" + request.getContextPath() + "/admin/notice/noticeList.jsp" + "';</script>");
	} else {
		out.println("<script>alert('수정 실패'); location.href='" + request.getContextPath() + "/admin/notice/noticeList.jsp" + "';</script>");
	}
%>
