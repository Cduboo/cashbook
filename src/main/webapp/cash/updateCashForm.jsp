<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*" %>
<%
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");

	//updateCashAction
	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	CashDao cashDao = new CashDao();
	HashMap<String, Object> m = cashDao.selectCashListByCashNo(cashNo);
	
	
	//카테고리 리스트 가져오기 (select태그)
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCashForm</title>
	</head>
	<body>
		<!-- cash 입력 폼 -->
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo%>" method="post">
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
									if(c.getCategoryNo() == (int)m.get("categoryNo")) {
							%>
										<option value="<%=c.getCategoryNo()%>" selected="selected">
											<%=c.getCategoryKind() %> <%=c.getCategoryName()%>
										</option>
							<%			
									}
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
					<td><input type="number" name="cashPrice" value="<%=m.get("cashPrice")%>"/></td>
				</tr>
				<tr>
					<td>cashDate</td>
					<td><input type="date" name="cashDate" value="<%=m.get("cashDate")%>"></td>					
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="3" cols="50" name="cashMemo"><%=m.get("cashMemo")%></textarea>
					</td>
				</tr>
			</table>	
			<button type="submit">수정</button>
		</form>
	</body>
</html>