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
	<h1>회의실 목록</h1>

	<table>
<thead>
    <tr>
        <th>예약자 ID</th>
        <th>예약 항목</th>
        <th>참석 인원</th>
        <th>예약 날짜</th>
        <th>시작 시간</th>
        <th>종료 시간</th>
        <th>위치</th>
        <th>장소</th>
        <c:if test="${isAdmin}">
            <!-- 예약 변경 텍스트 -->
            <th>
                <c:if test="${isAdmin}">
                    예약변경
                </c:if>
            </th>
            <!-- 예약 삭제 텍스트 -->
            <th>
                <c:if test="${isAdmin}">
                    예약취소
                </c:if>
            </th>
        </c:if>
    </tr>
</thead>


<tbody>
    <c:forEach var="reservation" items="${revList}">
        <tr>
            <!-- 예약자 ID, 예약 항목, ... 등 각 열의 데이터를 출력합니다. -->
            <td>${reservation.userId.userId}</td>
            <td>${reservation.reItem}</td>
            <td>${reservation.reCount}</td>
            <td>${reservation.reDate}</td>
            <td>${reservation.reStart}</td>
            <td>${reservation.reEnd}</td>
            <td>${reservation.reNum.mrLocation }</td>
            <td>${reservation.reNum.mrName}</td>
            
            <!-- 예약 변경 및 취소 버튼 -->
            <c:if test="${isAdmin}">
                <td>
                    <form action="/updateRev/${reservation.reId}" method="get">
                        <button type="submit" class="edit-btn">예약변경</button>
                    </form>
                </td>
                <td>
                    <form class="delete-form">
                        <input type="hidden" class="reId" value="${reservation.reId}">
                        <button type="button" class="btn-delete">예약취소</button>
                    </form>
                </td>
            </c:if>
        </tr>
    </c:forEach>
</tbody>

	</table>
	<script src="/js/revmeet.js"></script>

</body>
</html>
