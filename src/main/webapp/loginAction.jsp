<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="java.net.*"%>
<% 
	//로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	//아이디 패스워드 빈 값 검사
	if(request.getParameter("id") == null || request.getParameter("id").equals("")
		|| request.getParameter("pw") == null || request.getParameter("pw").equals("")){
		String msg = URLEncoder.encode("입력하지 않은 항목이 있습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	//입력받은 아이디 패스워드 vo로 묶기
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("id"));
	paramMember.setMemberPw(request.getParameter("pw"));

	//로그인 검사
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	//로그인 실패 메세지
	String msg = URLEncoder.encode("일치하는 계정이 없습니다.", "utf-8");
	String redirectUrl = "/loginForm.jsp?msg="+msg;
	
	//로그인 성공 시
	if(resultMember != null) {
		session.setAttribute("loginMember", resultMember);
		redirectUrl = "/cash/cashList.jsp";
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>