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
	
	if (request.getParameter("year") == null) {
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}
	
	//Model
	//회원의 년도(페이징) 월별(수입/지출) 합/평균
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> monthList = cashDao.selectIncomExpenditureSumAvgByMonth(memberId, year);
	
	DecimalFormat formatter = new DecimalFormat("###,###");
	int incomeSumByYear = 0;
	int expenditureSumByYear = 0;
	for(HashMap<String, Object> m : monthList) {
		incomeSumByYear += (int)m.get("incomeSum");
		expenditureSumByYear += (int)m.get("expenditureSum");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>memberMain</title>
		<link rel="preconnect" href="https://fonts.gstatic.com">
	    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="../assets/css/bootstrap.css">
	    <link rel="stylesheet" href="../assets/vendors/iconly/bold.css">
	    <link rel="stylesheet" href="../assets/vendors/apexcharts/apexcharts.css">
	    <link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
	    <link rel="stylesheet" href="../assets/vendors/bootstrap-icons/bootstrap-icons.css">
	    <link rel="stylesheet" href="../assets/css/app.css">
	    <link rel="shortcut icon" href="../assets/images/favicon.ico" type="image/x-icon">
	    <style>
	    	tr td:nth-child(7n) div span {
				color : #435EBE;
			}
	    	tr td:nth-child(7n+1) div span {
				color: #FF7976;
			}
			table,tr,td,th {
				border:1px solid silver; 
			}
			td:hover {
				background-color: #F2F7FF;
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
					<h3><%=year%>년 수입/지출</h3>
				</div>
				<div class="page-content">
					<section class="row">
						<div class="col-12 col-lg-9">
							<div class="row">
								<div class="col-6 col-lg-6 col-md-6">
									<div class="card">
										<div class="card-body px-3 py-4-5">
											<div class="row">
												<div class="col-md-3">
													<div class="stats-icon" style="background-color: #9694FF">
														<i class="fas fa-won-sign"></i>
													</div>
												</div>
												<div class="col-md-9">
													<h6 class="text-muted font-semibold"><%=year%>년 월평균 수입</h6>
													<h6 class="font-extrabold mb-0">+ <%=formatter.format(incomeSumByYear/12)%></h6>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-6 col-lg-6 col-md-6">
									<div class="card">
										<div class="card-body px-3 py-4-5">
											<div class="row">
												<div class="col-md-3">
													<div class="stats-icon" style="background-color: #57CAEB">
														<i class="fas fa-won-sign"></i>
													</div>
												</div>
												<div class="col-md-9">
													<h6 class="text-muted font-semibold"><%=year%>년 월평균 지출</h6>
													<h6 class="font-extrabold mb-0">- <%=formatter.format(expenditureSumByYear/12)%></h6>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 년도별 수입/지출 통계 -->
							<div class="row">
								<div class="col-12">
									<div class="card">
										<div class="card-header">
											<h4 class="text-center">
												<a class="p-3" href="<%=request.getContextPath()%>/member/memberMain.jsp?year=<%=year-1%>">&lt;</a>
												<%=year%>년
												<a class="p-3" href="<%=request.getContextPath()%>/member/memberMain.jsp?year=<%=year+1%>">&gt;</a>
											</h4>
											<!-- Button trigger for scrolling content modal -->
											<div class=" text-end">
												<button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#showTable">표로 보기</button>
											</div>
										</div>
										<div class="card-body">
		                                    <div id="bar"></div>
		                                </div>
									</div>
								</div>
							</div>
							<!--scrolling content Modal -->
							<div class="modal fade" id="showTable" tabindex="-1" role="dialog" aria-labelledby="showTableTitle" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable modal-xl" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="showTableTitle">표로 보기</h5>
											<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
												<i data-feather="x"></i>
											</button>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="col-12">
													<div class="card">
														<div class="card-header"  style="padding-bottom: 0">
															<h4 class="text-center"><%=year%>년</h4>
														</div>
														<div class="card-body">
															<div class="table-responsive">
																<table class="table table-bordered mt-3">
																	<thead class="table-light">
																		<tr>
																			<th>월</th>
																			<th>수입합계</th>
																			<th>수입평균</th>
																			<th>지출합계</th>
																			<th>지출평균</th>
																		</tr>
																	</thead>
																<%
																for (HashMap<String, Object> m : monthList) {
																%>
																	<tbody>
																		<tr>
																			<td><%=m.get("month")%>월</td>
																			<td>+<%=formatter.format(m.get("incomeSum"))%></td>
																			<td><%=formatter.format(m.get("incomeAvg"))%> (<%=m.get("incomeCount")%>건)</td>
																			<td><%=formatter.format(m.get("expenditureSum"))%></td>
																			<td>-<%=formatter.format(m.get("expenditureAvg"))%> (<%=m.get("expenditureCount")%>건)</td>
																		</tr>
																	</tbody>
																<%
																}
																%>
																</table>	
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
												<i class="bx bx-x d-block d-sm-none"></i> <span class="d-none d-sm-block">Close</span>
											</button>
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
							<div class="card">
								<div class="card-header">
									<h4>월평균 수입/지출</h4>
								</div>
								<div class="card-body">
									<div id="chart-cash-profile"></div>
									<!-- <div id="chart-category-profile"></div> -->
								</div>
							</div>
						</div>
					</section>
				</div>
				<!-- main end -->
			</div>
		<!-- app end -->
		</div>
		<script type="text/javascript">
			var barOptions = {
			  series: [
			    {
			      name: "수입",
			      data: [0,0,0,0,0,0,0,0,0,0,0,0],
			    },
			    {
			      name: "지출",
			      data: [0,0,0,0,0,0,0,0,0,0,0,0],
			    },
			  ],
			  chart: {
			    type: "bar",
			    height: 350,
			  },
			  plotOptions: {
			    bar: {
			      horizontal: false,
			      columnWidth: "50%",
			      endingShape: "rounded",
			    },
			  },
			  dataLabels: {
			    enabled: false,
			  },
			  stroke: {
			    show: true,
			    width: 2,
			    colors: ["transparent"],
			  },
			  xaxis: {
			    categories: ["1월","2월","3월","4월","5월","6월","7월", "8월","9월","10월","11월","12월"],
			  },
			  yaxis: {
			    title: {
			      text: "",
			    },
			  },
			  fill: {
			    opacity: 1,
			  },
			  tooltip: {
			    y: {
			      formatter: function(val) {
			        return val + "원";
			      },
			    },
			  },
			};
			
			<%
				for(HashMap<String, Object> m : monthList) {
			%>			
					for(var i=1; i<=12; i++) {
						if(i == <%=m.get("month")%>) {
							barOptions.series[0].data[i-1] = <%=m.get("incomeSum")%>
							barOptions.series[1].data[i-1] = <%=m.get("expenditureSum")%> 
						}	
					}	
						
			<%			
					}
			%>
		    
			let optionsCashProfile = {
				series: [<%=incomeSumByYear/12%>, <%=expenditureSumByYear/12%>],
				labels: ['평균 수입', '평균 지출'],
				colors: ['#9694FF','#57CAEB'],
				chart: {
					type: 'donut',
					width: '100%',
					height:'300px'
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
			<%-- let optionsCategoryProfile  = {
					series: [<%=incomeSumByYear/12%>, <%=expenditureSumByYear/12%>],
					labels: ['평균 수입', '평균 지출'],
					colors: ['#9694FF','#57CAEB'],
					chart: {
						type: 'donut',
						width: '100%',
						height:'200px'
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
				} --%>
		</script>
		<script src="https://kit.fontawesome.com/0917e5f385.js"></script>
		<script src="../assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	    <script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/vendors/apexcharts/apexcharts.js"></script>
		<script src="../assets/js/pages/ui-apexchart.js"></script>
		<script src="../assets/js/pages/dashboard.js"></script>
	    <script src="../assets/js/main.js"></script>
	</body>
</html>