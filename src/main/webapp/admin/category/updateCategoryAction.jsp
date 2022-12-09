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
	
	request.setCharacterEncoding("utf-8");
	
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")
		|| request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");	
		return;
	}
	
	Category category = new Category();
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category);
	
	if(row == 1) {
		out.println("<script>alert('수정 완료'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
	} else {
		out.println("<script>alert('수정 실패'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
	}
%>
