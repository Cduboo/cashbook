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
		<title>adminMain</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
	    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="../assets/css/bootstrap.css">
	    <link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
	    <link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	    <link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
	    <link rel="stylesheet" href="../assets/css/app.css">
	    <link rel="shortcut icon" href="../assets/images/favicon.ico" type="image/x-icon">
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
					<h3>관리자</h3>
				</div>
				<div class="page-content">
					<section class="row">
						<div class="col-12 col-lg-9">
							<div class="row">
								<div class="col-12">
									<div class="card">
										<div class="card-header">
											<h4>2022(변수) 가입자 수 통계</h4>
										</div>
										<div class="card-body">
											<div id="chart-profile-visit"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-lg-3">
							<a href="#" data-bs-toggle="dropdown" aria-expanded="false">
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
	                        </a>
	                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
								<li>
									<h6 class="dropdown-header">
										환영합니다. <%=loginMember.getMemberName()%>님!
									</h6>
								</li>
								<li><a class="dropdown-item" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp"><i class="icon-mid bi bi-person me-2"></i>마이페이지</a></li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li><a class="dropdown-item" href="<%=request.getContextPath()%>/logOut.jsp"><i class="icon-mid bi bi-box-arrow-left me-2"></i>로그아웃</a></li>
							</ul>
						</div>	
					</section>
				</div>
				<!-- main end -->
			</div>
		<!-- app end -->
		</div>
		<script type="text/javascript">
			let optionsVisitorsProfile  = {
				series: [<%=totalIncome%>, <%=totalExpenditure%>],
				labels: ['수입', '지출'],
				colors: ['#9694FF','#57CAEB'],
				chart: {
					type: 'donut',
					width: '100%',
					height:'350px'
				},
				legend: {
					position: 'bottom'
				},
				plotOptions: {
					pie: {
						donut: {
							size: '30%'
						}
					}
				}
			}
			var optionsProfileVisit = {
				annotations: {
					position: 'back'
				},
				dataLabels: {
					enabled:false
				},
				chart: {
					type: 'bar',
					height: 300
				},
				fill: {
					opacity:1
				},
				plotOptions: {
				},
				series: [{
					name: 'sales',
					data: [9,20,30,20,10,20,30,20,10,20,30,20]
				}],
				colors: '#435ebe',
				xaxis: {
					categories: ["1월","2월","3월","4월","5월","6월","7월", "8월","9월","10월","11월","12월"],
				},
			}
		</script>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/vendors/apexcharts/apexcharts.js"></script>
		<script src="../assets/js/pages/dashboard.js"></script>
	    <script src="../assets/js/main.js"></script>
	</body>
</html>