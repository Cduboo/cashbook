<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<% 
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));	
	int date = Integer.parseInt(request.getParameter("date"));	

	//카테고리 리스트 가져오기 (select태그)
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	//해당 유저의 특정 일자 cashList(가계부 정보) 가져오기
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> cashList = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
	</head>
	<body>
		<!-- cash 입력 폼 -->
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<%
				if(msg != null) {
			%>
					<span><%=msg%></span>			
			<%		
				}
			%>
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<table border="1">
				<tr>
					<td>categoryNo</td>
					<td>
						<select name="categoryNo">
							<%
								//category 목록 출력
								for(Category c : categoryList) {
							%>
									<option value="<%=c.getCategoryNo()%>">
										<%=c.getCategoryKind() %> <%=c.getCategoryName()%>
									</option>
							<%		
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td><input type="number" name="cashPrice"/></td>
				</tr>
				<tr>
					<td>cashDate</td>
					<td><input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly"></td>					
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="3" cols="50" name="cashMemo"></textarea>
					</td>
				</tr>
			</table>	
			<button type="submit">입력</button>
		</form>
		
		<!-- cash 목록 출력 -->
		<table border="1">
			<tr>
				<td>categoryKind</td>
				<td>categoryName</td>
				<td>cashPrice</td>
				<td>cashMemo</td>
				<td>수정</td> <!-- /cash/deleteCash.jsp?cashNo=  -->
				<td>삭제</td> <!-- /cash/updateForm.jsp?cashNo= -->
			</tr>
			<%
				for(HashMap<String, Object> m : cashList) {
			%>
					<tr>
						<td><%=m.get("categoryKind")%></td>
						<td><%=m.get("categoryName")%></td>
						<td><%=m.get("cashPrice")%></td>
						<td><%=m.get("cashMemo")%></td>
						<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=m.get("cashNo")%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>">삭제</a></td>
					</tr>
			<%			
				}
			%>
		</table>
	</body>
</html>