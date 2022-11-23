<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.Cash"%>
<%@ page import="dao.CashDao"%>
<%
	request.setCharacterEncoding("utf-8");

	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String cashDate = request.getParameter("cashDate"); //yyyy-mm-dd
	String[] splitCashDate = cashDate.split("-"); 
	int year = Integer.parseInt(splitCashDate[0]);
	int month = Integer.parseInt(splitCashDate[1]);
	int date = Integer.parseInt(splitCashDate[2]);

	if(request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")) {
		String msg = URLEncoder.encode("입력하지 않은 항목이 있습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	}
	
	Cash cash = new Cash();
	cash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	cash.setMemberId(request.getParameter("memberId"));
	cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	cash.setCashDate(request.getParameter("cashDate"));
	String cashMemo = "";
	if(request.getParameter("cashMemo") != null || ! request.getParameter("cashMemo").equals("")){
	cashMemo = request.getParameter("cashMemo");
	}
	cash.setCashMemo(cashMemo);

	CashDao cashDao = new CashDao();
	cashDao.updateCashList(cash);
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
%>
