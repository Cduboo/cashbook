<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.MemberDao"%>
<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("name") == null || request.getParameter("name").equals("")  
		|| request.getParameter("id") == null || request.getParameter("id").equals("") 
		|| request.getParameter("pw") == null || request.getParameter("pw").equals("")){
		String msg = URLEncoder.encode("입력하지 않은 항목이 있습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("id"));
	paramMember.setMemberPw(request.getParameter("pw"));
	paramMember.setMemberName(request.getParameter("name"));
	
	MemberDao dao = new MemberDao();
	int row = dao.insertMember(paramMember);
	
	if(row == 0) {
		String msg = URLEncoder.encode("중복된 아이디입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
%>
