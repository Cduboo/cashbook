<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.CashDao"%>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	//해당 memberId의 삭제할 cash_no 담기 
	Cash cash = new Cash();
	cash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	cash.setMemberId(memberId);
	
	//삭제 후 redirect를 위해 날짜 가져오기 yyyy-mm-dd
	CashDao cashDao = new CashDao();
	String cashDate = cashDao.deleteCash(cash);
	String[] splitCashDate = cashDate.split("-"); 
	int year = Integer.parseInt(splitCashDate[0]);
	int month = Integer.parseInt(splitCashDate[1]);
	int date = Integer.parseInt(splitCashDate[2]);
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
%>
