<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>

<body>

	<div id="wrapper">
		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center mx-2"
				href="/index"> <img src="/image/logo_3.svg" alt="CUBE_icon"
				style="width: auto; height: 30px;">

				<div class="sidebar-brand-text mx-2">CUBE</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="/attendancePage">
					<i class="fas fa-fw fa-home"></i> <span>근태</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">근태</div>
			
			<li class="nav-item"><a class="nav-link" href="/att_FindPage">
					<i class="fas fa-calendar-alt mr-2"></i> <span>근태 조회</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/attplan_InsertPage">
					<i class="fas fa-calendar-check mr-2"></i> <span>근태 계획 등록</span>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">초과근무</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i class="fas fa-stopwatch mr-2"></i><span>초과근무</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">초과근무</h6>
						<a class="collapse-item" href="/att_Ot_InsertPage">초과근무 신청</a> <a
							class="collapse-item" href="/att_Ot_FindPage">초과근무 신청 내역</a>
					</div>
				</div></li>
				
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">휴가</div>
			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i class="fas fa-stamp mr-2"></i> <span>휴가</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">휴가 신청</h6>
						<a class="collapse-item" href="/att_Va_InsertPage">휴가 신청</a> <a
							class="collapse-item" href="/att_Va_FindPage">휴가 신청 내역</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">통계</div>
			
						<li class="nav-item"><a class="nav-link" href="/att_StatisticsPage">
					<i class="fas fa-chart-pie mr-2"></i> <span>통계</span>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		</div>
</body>
</html>