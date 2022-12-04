<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("updateName") == null || request.getParameter("updateName").equals("")
		|| request.getParameter("currentPw") == null || request.getParameter("currentPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	//입력한 수정 정보 -> Member vo 묶기
	Member updateMember = new Member();
	updateMember.setMemberName(request.getParameter("updateName"));
	
	Member currentMember = new Member();
	currentMember.setMemberId(loginMember.getMemberId());
	currentMember.setMemberPw(request.getParameter("currentPw"));
	
	//기존 아이디,이름 비교 -> 변경이 일어나지 않으면 수정 x
	if(updateMember.getMemberName().equals(loginMember.getMemberName())) {
		String msg = URLEncoder.encode("기존 정보와 동일합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	//false : 본인인증(비밀번호) 실패
	if(! memberDao.selectMemberPwCk(currentMember, updateMember)) {
		String msg = URLEncoder.encode("비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	//본인인증(비밀번호) 성공 시 
	int row = memberDao.updateMember(currentMember, updateMember);
	if(row ==1) {
		updateMember.setMemberId(loginMember.getMemberId());
		updateMember.setMemberLevel(loginMember.getMemberLevel());
		session.setAttribute("loginMember", updateMember);		
	}
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
%>
