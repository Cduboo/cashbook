<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.CashDao"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>

<%
	//비로그인 유저는 접근 불가
	if (session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	//session에 담긴 로그인한 계정 정보
	Member loginMember = (Member) session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	//Controller : session, request
	//request -> 년,월
	int year = 0;
	int month = 0;
	
	if (request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		//month가 -1 or 12 일 경우, 0~11
		if (month == -1) {
			month = 11;
			year -= 1;
		}
		if (month == 12) {
			month = 0;
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
	if ((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	//Model -> 해당 유저의 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(memberId, year, month+1);
	//회원의 해당 년월 총 수입/지출
	DecimalFormat formatter = new DecimalFormat("###,###");
	int totalIncome = cashDao.selectIncomeByMonth(memberId, year, month+1);
	int totalExpenditure = cashDao.selectExpenditureByMonth(memberId, year, month+1);
	//View -> 달력 출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>cashList</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
	    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="../assets/css/bootstrap.css">
	    <link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
	    <link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	    <link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
	    <link rel="stylesheet" href="../assets/css/app.css">
	    <link rel="shortcut icon" href="../assets/images/favicon.svg" type="image/x-icon">
	    <style>
	    	tr td:nth-child(7n) a{
				color : blue;
			}
	    	tr td:nth-child(7n+1) a{
				color: #FF7976
			}
	    </style>
	</head>
	<body>
		<div id="app">
			<jsp:include page="/inc/nav.jsp"></jsp:include>
			<div id="main">
				<header class="mb-3">
					<a href="#" class="burger-btn d-block d-xl-none">
						<i class="bi bi-justify fs-3"></i>
					</a>
				</header>
				<div class="page-heading">
					<h3>가계부</h3>
				</div>
				<div class="page-content">
					<section class="row">
						<div class="col-12 col-lg-9">
							<div class="row">
								<div class="col-6 col-lg-3 col-md-6">
									<div class="card">
										<div class="card-body px-3 py-4-5">
											<div class="row">
												<div class="col-md-4">
													<div class="stats-icon purple">
														<i class="iconly-boldShow"></i>
													</div>
												</div>
												<div class="col-md-8">
													<h6 class="text-muted font-semibold"><%=month+1%>월 수입</h6>
													<h6 class="font-extrabold mb-0">+ <%=formatter.format(totalIncome)%></h6>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-6 col-lg-3 col-md-6">
									<div class="card">
										<div class="card-body px-3 py-4-5">
											<div class="row">
												<div class="col-md-4">
													<div class="stats-icon blue">
														<i class="iconly-boldProfile"></i>
													</div>
												</div>
												<div class="col-md-8">
													<h6 class="text-muted font-semibold"><%=month+1%>월 지출</h6>
													<h6 class="font-extrabold mb-0">- <%=formatter.format(totalExpenditure)%></h6>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-6 col-lg-3 col-md-6">
									<div class="card">
										<div class="card-body px-3 py-4-5">
											<div class="row">
												<div class="col-md-4">
													<div class="stats-icon green">
														<i class="iconly-boldAdd-User"></i>
													</div>
												</div>
												<div class="col-md-8">
													<h6 class="text-muted font-semibold">뭐할까</h6>
													<h6 class="font-extrabold mb-0">80.000</h6>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-6 col-lg-3 col-md-6">
									<div class="card">
										<div class="card-body px-3 py-4-5">
											<div class="row">
												<div class="col-md-4">
													<div class="stats-icon red">
														<i class="iconly-boldBookmark"></i>
													</div>
												</div>
												<div class="col-md-8">
													<h6 class="text-muted font-semibold">모르겠다</h6>
													<h6 class="font-extrabold mb-0">112</h6>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 달력 -->
							<div class="row">
								<div class="col-12">
									<div class="card">
										<div class="card-header"  style="padding-bottom: 0">
											<h4 class="text-center">
												<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&lt;</a>
												<%=year%>년 <%=month + 1%>월
												<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month + 1%>">&gt;</a>
											</h4>
										</div>
										<div class="card-body">
											<div class="table-responsive">
												<table class="table table-lg" style="table-layout: fixed;">
													<thead>
														<tr>
															<th style="color: #FF7976">일</th>
															<th>월</th>
															<th>화</th>
															<th>수</th>
															<th>목</th>
															<th>금</th>
															<th class="text-primary">토</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<%
																for (int i = 1; i <= totalTd; i++) {
															%>
																	<td style="vertical-align:top; font-size:0.8rem; padding-top: 10px; height: 90px;">
															<%
																	int date = i - beginBlank;
																	if (date > 0 && date <= lastDate) {
															%>
																	<div>
																		<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month + 1%>&date=<%=date%>"> <%=date%></a>
																	</div>
																		<div>
																			<%
																				long totalIncomDate = 0;
																				long totalExpenditureDate = 0;
																				
																				for (HashMap<String, Object> m : list) {
																					String cashDate = (String)(m.get("cashDate"));
																					if (Integer.parseInt(cashDate.substring(8)) == date) {
																						if(m.get("categoryKind").equals("지출")){
																							totalExpenditureDate += (Long)m.get("cashPrice");
																						}else if(m.get("categoryKind").equals("수입")) {
																							totalIncomDate += (Long)m.get("cashPrice");				
																						}
																					}
																				}
																				if(totalExpenditureDate > 0){
																			%>
																					<div class="fw-bold">-<%=formatter.format(totalExpenditureDate)%>원</div>																																									
																			<%																			
																				}
																				
																				if(totalIncomDate > 0){
																			%>
																					<div class="fw-bold" style="color: #CE2D59">+<%=formatter.format(totalIncomDate)%>원</div>	
																			<%		
																				}
																			%>		
																			
																		</div> 
															<%
																	 }
															%>
																	</td>
															<%
																	if (i % 7 == 0 && i != totalTd) {
															%>
																		</tr><tr><!-- td7개 만들고 테이블 줄 바꿈 -->
															<%
																	}
																}
															%>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-lg-3">
	                        <div class="card">
	                            <div class="card-body py-4 px-5">
	                                <div class="d-flex align-items-center">
	                                    <div class="avatar avatar-xl">
	                                        <img src="<%=request.getContextPath()%>/assets/images/faces/1.jpg" alt="Face 1">
	                                    </div>
	                                    <div class="ms-3 name">
	                                        <h5 class="font-bold"><%=loginMember.getMemberName()%></h5>
	                                        <h6 class="text-muted mb-0"><%=loginMember.getMemberId()%></h6>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="card">
	                            <div class="card-header">
	                                <h4>Visitors Profile</h4>
	                            </div>
	                            <div class="card-body">
	                                <div id="chart-visitors-profile"></div>
	                            </div>
	                        </div>
	                    </div>	
					</section>
				</div>
				<!-- main end -->
			</div>
		<!-- app end -->
		</div>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../assets/js/bootstrap.bundle.min.js"></script>
	    <script src="../assets/vendors/apexcharts/apexcharts.js"></script>
	    <script src="../assets/js/pages/dashboard.js"></script>
	    <script src="../assets/js/main.js"></script>
	</body>
</html>