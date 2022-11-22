<%@page import="dao.CashDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="java.util.*"%>
<%
/* 	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member)session.getAttribute("loginMember");
	String name = loginMember.getMemberName(); */
	
	
	//Controller : session, request
	//request -> 년,월
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		//month가 -1 or 12 일 경우, 0~11
		if(month == -1) {
			month = 11;
			year -= 1;
		} 
		if(month == 12) {
			month = 1;
			year += 1;
		}
	}
	
	//출력하고자 하는 년,월의 1일의 요일(일요일:1,월요일:2,화요일:3,...,토요일:7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); //1일의 요일
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); //마지막 날짜
	int beginBlank = firstDay - 1; //달력 출력테이블의 시작 공백일(td)과 마지막 공백(td)의 개수
	int endBlank = 0; //beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다.
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	//Model -> 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1);
	
	//View -> 달력 출력 + 일별 cash 목록 출력  
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashList</title>
	</head>
	<body>
		<div>
			<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
		</div>
		
		<div>
			<%=year%>년 <%=month+1%>월
		</div>
		<div>
			<!-- 달력 -->
			<table border="1">
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
				<tr>
			<%
				for(int i=1; i<=totalTd; i++) {
			%>
					<td>
			<%
						int date = i - beginBlank;
						if(date > 0 && date <= lastDate){
			%>
							<div>
								<a href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
									<%=date%>
								</a>
							</div>
							<div>
								<%
									for(HashMap<String, Object> m : list) {
										String cashDate = (String)(m.get("cashDate"));
										if(Integer.parseInt(cashDate.substring(8)) == date) {
								%>			
											[<%=(String)(m.get("categoryKind"))%>]
											<%=(String)(m.get("categoryName"))%>
											<%=(Long)(m.get("cashPrice"))%>원
											<br>
								<%	
										}
									}
								%>
							</div>
			<%				
						}
			%>			
					</td>
			<%		
					if(i % 7 == 0 && i!=totalTd) {
			%>
						</tr><tr><!-- td7개 만들고 테이블 줄 바꿈 -->
			<%
					}
				}
			%>
			</table>
		</div>
	</body>
</html>