<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<nav
		class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

		<div class="navbar-nav">
			<a class="nav-link mx-3" href="/attendancePage">근태</a> <a
				class="nav-link mx-3" href="/receivemail_list">메일</a> <a
				class="nav-link mx-3" href="/listNotice">게시판</a> <a
				class="nav-link mx-3" href="/myRevpage">예약시스템</a>
			<c:if test="${sessionScope.login_user.userTeamId.teamId eq 1}">
				<a class="nav-link mx-3 mr-5" href="/hr_employeePage">HR</a>
			</c:if>
		</div>

		<ul class="navbar-nav ml-auto">
		
			<li class="nav-item no-arrow"><a class="nav-link" href="/orgPage"><span class = "text-gray-600">조직도</span></a></li>

			<div class="topbar-divider d-none d-sm-block"></div>

			<!-- Nav Item - User Information -->
			<li class="nav-item no-arrow"><a class="nav-link" href="/my_main"><span
					class="mr-2 d-none d-lg-inline text-gray-900 lg"><i
						class="fas fa-user fa-lg mr-1"></i>${login_user.userName}</span> </a></li>
		</ul>

		<div class="navbar-nav">
			<a href="/logout" class="ml-3 d-none d-lg-inline small"><i
				class="fas fa-sign-out-alt"></i>로그아웃</a>
		</div>
	</nav>
</body>
</html>