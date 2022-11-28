<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- nav -->
<div>
	<h1>관리자</h1>
	<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a>
	<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a>
	<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a>
</div>