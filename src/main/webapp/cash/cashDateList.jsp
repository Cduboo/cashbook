<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
	//비로그인 유저는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("year") == null || request.getParameter("year").equals("") 
		|| request.getParameter("month") == null || request.getParameter("month").equals("") 
		|| request.getParameter("date") == null || request.getParameter("date").equals("")) {
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
	
	//세자리 콤마
	DecimalFormat formatter = new DecimalFormat("###,###");
	
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
		<title>cashDateList</title>
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
				<div class="page-content row">
					<section class="card col-8 me-3">
						<div class="card-content">
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-md" style="table-layout: fixed;">
										<thead>
											<tr>
												<th>분류</th>
												<th>종류</th>
												<th style="width:15%">가격</th>
												<th style="width:30%">메모</th>
												<th style="width:15%">날짜</th>
												<th>수정</th>
												<th>삭제</th>
											</tr>
										</thead>
										<tbody>
											<%
												for(HashMap<String, Object> m : cashList) {
											%>
													<tr>
														<td><%=m.get("categoryKind")%></td>
														<td><%=m.get("categoryName")%></td>
														<td><%=formatter.format(m.get("cashPrice"))%></td>
														<td><%=m.get("cashMemo")%></td>
														<td><%=m.get("cashDate")%></td>
														<td>
															<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=m.get("cashNo")%>">수정</a>
														</td>
														<td>
															<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>">삭제</a>
														</td>
													</tr>
											<%			
												}
											%>
										</tbody>
									</table>
								</div>
							</div>	
						</div>
					</section>
     	  			<section class="card col">	
						<div class="card-content">
							<div class="card-body">
								<!-- 입력폼 -->
								<%
									if(msg != null) {
								%>
									<div><%=msg%></div>
								<%		
									}
								%>
								<form class="form form-horizontal px-4 container" action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
									<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
									<div class="form-body">
										<div class="row">
											<div class="col-md-3">
												<label>분류/종류</label>
											</div>
											<div class="col-md-9 form-group">
												<select class="form-select" name="categoryNo">
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
											</div>
											<div class="col-md-3">
												<label>가격</label>
											</div>
											<div class="col-md-9 form-group">
												<input class="form-control" type="number" name="cashPrice">
											</div>
											<div class="col-md-3">
												<label>날짜</label>
											</div>
											<div class="col-md-9 form-group">
												<input type="text" class="form-control" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
											</div>
											<div class="col-md-12 form-group mt-3">
												<textarea class="form-control" name="cashMemo" rows="3"></textarea>
											</div>
											<div class="d-grid">
												<button class="btn btn-primary" type="submit">입력하기</button>
											</div>
										</div>
									</div>
								</form>
							</div>	
						</div>
					</section>
				</div>
			</div>
		</div>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/pages/dashboard.js"></script>
		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/main.js"></script>
	</body>
</html>