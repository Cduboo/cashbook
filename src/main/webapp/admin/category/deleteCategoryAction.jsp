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
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");	
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(categoryNo);
	
	if(row == 1) {
		out.println("<script>alert('삭제 완료'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
	} else {
		out.println("<script>alert('삭제 실패'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
	}
%>
