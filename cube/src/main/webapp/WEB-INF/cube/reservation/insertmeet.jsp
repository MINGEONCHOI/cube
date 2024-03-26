<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회의실 예약</title>
<link rel="stylesheet" type="text/css" href="/css/insertrev.css" />
</head>
<body>

<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container">
		<h1>회의실 예약</h1>

		<div class="form-group">
			<label for="reItem">예약선택:</label>
			<input type="text" id="reItem" name="reItem" value="회의실" readonly
				required>
		</div>


		<div class="form-group">
			<label for="selectedDate">날짜 선택:</label> <input type="date"
				id="selectedDate" class="form-control" name="selectedDate" min="<%=LocalDate.now()%>" required>
		</div>
		

		<div class="form-group">
			<label for="reStart">시작 시간:</label> <select id="reStart"
				name="reStart" class="form-control" required>
				<option value="">시간을 선택하세요</option>
				<!-- 오전 9시부터 오후 6시까지의 옵션 생성 -->
				<c:forEach begin="9" end="18" var="hour">
					<c:set var="hour" value="${hour < 10 ? '09' : hour}" />
					<c:set var="amPm" value="${hour >= 12 ? '오후' : '오전'}" />
					<c:set var="hour12" value="${hour > 12 ? hour - 12 : hour}" />
					<option value="<c:out value='${hour}'/>:00">${amPm}
						<c:out value='${hour12}' />:00
					</option>
					<option value="<c:out value='${hour}'/>:30">${amPm}
						<c:out value='${hour12}' />:30
					</option>
				</c:forEach>
			</select>
		</div>

		<div class="form-group">
			<label for="reEnd">종료 시간:</label> <select id="reEnd" name="reEnd"
				class="form-control" required>
				<option value="">시간을 선택하세요</option>
				<!-- 오전 9시부터 오후 6시까지의 옵션 생성 -->
				<c:forEach begin="9" end="18" var="hour">
					<c:set var="hour" value="${hour < 10 ? '09' : hour}" />
					<c:set var="amPm" value="${hour >= 12 ? '오후' : '오전'}" />
					<c:set var="hour12" value="${hour > 12 ? hour - 12 : hour}" />
					<option value="<c:out value='${hour}'/>:00">${amPm}
						<c:out value='${hour12}' />:00
					</option>
					<option value="<c:out value='${hour}'/>:30">${amPm}
						<c:out value='${hour12}' />:30
					</option>
				</c:forEach>
			</select>
		</div>


		<div class="form-group">
			<label for="userId">주최자:</label> <input
				value="${login_user.userName}" id="userId" name="userId"
				readonly="readonly">
		</div>

		<div class="form-group">
			<label for="reCount">참석자 수:</label> <input type="text" id="reCount"
				name="reCount" required>
		</div>

		<label for="mrSelect">회의실 선택:</label> <select id="mrSelect"
			name="mrSelect" class="form-control" required>
			<option value="">회의실을 선택하세요</option>
			<!-- mrList에서 각 아이템을 반복하며 셀렉트 박스 옵션 생성 -->
			<c:forEach var="mr" items="${mrList}">
				<option value="${mr.mrId}">${mr.mrName}</option>
			</c:forEach>
		</select>




		<button id="btn-insert">예약등록</button>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="/js/revmeet.js"></script>

</body>
</html>

