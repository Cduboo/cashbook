<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="vo.*" %>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(	request.getParameter("currentPw") == null || request.getParameter("currentPw").equals("")
		|| request.getParameter("updatePw") == null || request.getParameter("updatePw").equals("") 
		|| request.getParameter("updatePwCk") == null || request.getParameter("updatePwCk").equals("")){
		String msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	String currentPw = request.getParameter("currentPw");
	String updatePw = request.getParameter("updatePw");
	String updatePwCk = request.getParameter("updatePwCk");
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	//수정할 비밀번호와 비밀번호 확인 일치 검사
	if(! updatePw.equals(updatePwCk)){
		String msg = URLEncoder.encode("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
 	//현재 비밀번호와 수정 비밀번호 동일한지 검사 
	if(currentPw.equals(updatePw)){
		String msg = URLEncoder.encode("입력한 현재 비밀번호와 새 비밀번호가 동일합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}

	MemberDao updatePwDao = new MemberDao();
	int row = updatePwDao.updateMemberPw(memberId, currentPw, updatePw);
	
	//수정 실패
	if(row == 0){
		String msg = URLEncoder.encode("현재 비밀번호가 일치하지 않습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	//비밀번호 수정되면 로그아웃
	response.sendRedirect(request.getContextPath()+"/logOut.jsp");
%>