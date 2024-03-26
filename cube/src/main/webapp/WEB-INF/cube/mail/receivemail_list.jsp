<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
  java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
  String currentDateTime = java.time.LocalDateTime.now().format(formatter);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>ReceiveMailList</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/css/mailList.css"/>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>

  <h2>받은 메일함</h2>            
  <table class="table">
    <thead>
      <tr>
        <th>메일 순번</th>
        <th>제목</th>
        <th>보낸 사람</th>
        <th>받은시간</th>
        <th>읽음 여부</th>
        <th>읽은 날짜</th>
        <th>휴지통 이동</th>
        <th>중요메일함 이동</th>
        
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${receivedMailList}" >
        
         <tr> 
        <!-- 메일 순번  -->    <td>${mail.receiveMailId}<input type="hidden" value="${mail.receiveMailId}" id = "receiveMailId"></td>
        <!-- 제   목  -->    <td><a href="/getReceiveMail/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailTitle} 내용보기</a></td>
        <!-- 보낸 사람  -->    <td>${mail.receiveMailSenderEmail}</td>
        <!-- 받은 시간  -->   <td>${mail.receiveMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
        <!-- 읽음 여부  -->    <td>${mail.receiveMailReadStatus}</td>
        <!-- 읽은 날짜  -->    <td>${mail.receiveMailReadDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
        <!-- 휴지통 이동 -->    <td><a href="/changeReceiveIsDelete/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailIsDelete } 휴지통 이동</a></td>
        <!-- 중요함 이동 -->    <td><a href="/changeReceiveImportant/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailImportant } 중요 메일함 이동</a></td>
            
        </tr>
       
    </c:forEach>
</tbody>
  </table>
  <script src="/mail/js/sendMailIsDeleteBox.js"></script>
  <script src="/mail/js/receivedMailImportantBox.js"></script>
</body>
</html>

