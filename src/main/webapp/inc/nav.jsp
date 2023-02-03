<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
%>
<div id="sidebar" class="active">
	<div class="sidebar-wrapper active">
		<div class="sidebar-header">
			<div class="">
				<div class="">
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a>
				</div>
				<div class="toggler">
					<a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
				</div>
			</div>
		</div>
		<div class="sidebar-menu">
			<ul class="menu">
				<li class="sidebar-title">Menu</li>
				<li class="sidebar-item">
					<a href="<%=request.getContextPath()%>/member/memberMain.jsp" class='sidebar-link'>
						<i class="fa-sharp fa-solid fa-chart-simple"></i>
						<span>통계</span>
					</a>
				</li>
				<li class="sidebar-item">
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class='sidebar-link'>
						<i class="far fa-calendar"></i>
						<span>가계부</span>
					</a>
				</li>	
				<%
					if (loginMember.getMemberLevel() > 0) {
				%>	
						<li class="sidebar-item  has-sub">
							<a href="#" class='sidebar-link'>
								<i class="fas fa-user-check"></i>
								<span>관리자페이지</span>
							</a>
							<ul class="submenu ">
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지사항</a>
								</li>
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리</a>
								</li>
								<li class="submenu-item ">
									<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">회원</a>
								</li>
							</ul>
						</li>
				<%
					}
				%>
				<li class="sidebar-item has-sub">
					<a href="#" class='sidebar-link'>
						<i class="fas fa-user"></i>
						<span>마이페이지</span>
					</a>
					<ul class="submenu ">
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보 수정</a>
						</li>
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 변경</a>
						</li>
						<li class="submenu-item ">
							<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원 탈퇴</a>
						</li>
					</ul>
				</li>
				<%
					if(loginMember.getMemberLevel() > 0) {
				%>
						<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/admin/help/helpList.jsp" class='sidebar-link'>
								<i class="fas fa-question-circle"></i>
								<span>1:1 문의</span>
							</a>
						</li>
				<%
					}else {
				%>
					<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/help/helpList.jsp" class='sidebar-link'>
								<i class="fas fa-question-circle"></i>
								<span>1:1 문의</span>
							</a>
					</li>
				<%
					}
				%>
				<%
					if(loginMember.getMemberLevel() == 0) {
				%>
						<li class="sidebar-item">
							<a href="<%=request.getContextPath()%>/member/noticeList.jsp" class='sidebar-link'>
								<i class="fas fa-exclamation-circle"></i>
								<span>공지 사항</span>
							</a>
						</li>
				<%
					}
				%>
				<li class="sidebar-item">
					<a href="<%=request.getContextPath()%>/logOut.jsp" class='sidebar-link'>
						<i class="fas fa-sign-out-alt"></i>
						<span>로그아웃</span>
					</a>
				</li>
			</ul>
		</div>
		<button class="sidebar-toggler btn x">
			<i data-feather="x"></i>
		</button>
	</div>
</div>
