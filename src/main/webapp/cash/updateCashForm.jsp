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
	
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	CashDao cashDao = new CashDao();
	HashMap<String, Object> m = cashDao.selectCashListByCashNo(cashNo);
	
	
	//카테고리 리스트 가져오기 (select태그)
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>updateCashForm</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
		<link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
		<link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
		<link rel="stylesheet" href="../assets/css/app.css">
		<link rel="shortcut icon" href="../assets/images/favicon.svg" type="image/x-icon">
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<div class="page-content">
					<div class="page-heading">
						<h3>가계부 수정</h3>
					</div>
					<section class="card">
						<div class="card-content">
							<div class="card-body">
								<div class="table-responsive">
									<%
										if(msg != null) {
									%>
										<div><%=msg%></div>
									<%		
										}
									%>
									<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo%>" method="post">
										<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
										<table class="table table-md text-center" style="table-layout: fixed;">
											<tr>
												<td style="width: 30%">분류/종류</td>
												<td>
													<select class="form-select" name="categoryNo">
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
												<td style="width: 30%">가격</td>
												<td><input class="form-control type="number" name="cashPrice" value="<%=m.get("cashPrice")%>"/></td>
											</tr>
											<tr>
												<td style="width: 30%">날짜</td>
												<td><input class="form-control type="date" name="cashDate" value="<%=m.get("cashDate")%>"></td>					
											</tr>
											<tr>
												<td style="width: 30%">메모</td>
												<td>
													<textarea class="form-control rows="3" cols="50" name="cashMemo"><%=m.get("cashMemo")%></textarea>
												</td>
											</tr>
										</table>
										<div class="d-flex justify-content-end mt-3">
											<button class="btn btn-primary me-3" type="submit">수정하기</button>
										</div>									
									</form>
								</div>
							</div>	
						</div>
					</section>
				</div>
			</div>
		</div>
		
		<%-- <h1>가계부 수정</h1>
		<!-- main -->
		<%
			if(msg != null) {
		%>
			<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo%>" method="post">
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
		</form> --%>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/pages/dashboard.js"></script>
		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/main.js"></script>
	</body>
</html>