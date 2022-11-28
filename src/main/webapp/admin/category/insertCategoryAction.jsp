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
	
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryKind").equals("")
		|| request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp");
		return;
	}
	
	Category category = new Category();
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	System.out.print(categoryKind);
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");
%>
