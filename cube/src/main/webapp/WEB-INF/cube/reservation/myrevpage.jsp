<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 목록</title>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
    <h1>예약 목록</h1>

    <table>
        <thead>
            <tr>
                <th>예약자 ID</th>
                <th>예약 항목</th>
                <th>참석/탑승 인원</th>
                <th>예약 날짜</th>
                <th>시작 시간</th>
                <th>종료 시간</th>
                <th>장소 또는 차량</th>
                <th>예약변경</th> <!-- 수정 버튼 추가 -->
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="reservation" items="${revList}">
                <tr>
                    <td>${reservation.userId.userId}</td>
                    <td>${reservation.reItem}</td>
                    <td>${reservation.reCount}</td>
                    <td>${reservation.reDate}</td>
                    <td>${reservation.reStart}</td>
                    <td>${reservation.reEnd}</td>
                    <td>${reservation.reNum.mrName}</td>
                    <td><a href="/updateRev/${reservation.reId}" class="edit-btn">예약변경</a></td>
                    <td><input type="hidden" class="reId"
                        value="${reservation.reId}">
                        <button class="btn-delete">예약취소</button></td>
                </tr>
            </c:forEach>

            <c:forEach var="carreservation" items="${carList}">
                <tr>
                    <td>${carreservation.userId.userId}</td>
                    <td>${carreservation.creItem}</td>
                    <td>${carreservation.creCount}</td>
                    <td>${carreservation.creDate}</td>
                    <td>${carreservation.creStart}</td>
                    <td>${carreservation.creEnd}</td>
                    <td>${carreservation.creNum.carName}</td>
                    <td><a href="/updateCar/${carreservation.creId}" class="edit-btn">예약변경</a></td>
                    <td><input type="hidden" class="creId"
                        value="${carreservation.creId}">
                        <button class="btn-delete">예약취소</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
	<script src="/js/revmeet.js"></script>
	<script src="/js/revcar.js"></script>
</body>
</html>
