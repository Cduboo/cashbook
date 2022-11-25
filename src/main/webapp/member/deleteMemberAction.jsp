<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8");

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("deleteId") == null || request.getParameter("deleteId").equals("") 
	|| request.getParameter("deletePw") == null || request.getParameter("deletePw").equals("")){
		String msg = URLEncoder.encode("아이디와 비밀번호를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	//회원 탈퇴에 입력한 회원 정보
	String deleteId = request.getParameter("deleteId");
	String deletePw = request.getParameter("deletePw");
	
%>