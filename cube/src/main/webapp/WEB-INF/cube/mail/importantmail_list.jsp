<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>ImportantMailList</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>

  <h2>중요 메일함</h2>            
  <table class="table">
    <thead>
      <tr>
      <h2>보낸 중요 메일함</h2>
      <th>메일 순번</th>
        <th>받는 사람</th>
        <th>제목</th>
        <th>받은 날짜</th>
        <th>휴지통 이동</th>
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${sendImportantEmail}" >
        <tr>
           <td>${mail.sendMailId}</td>
            <td>${mail.sendMailReceiverEmail}</td>
            <td><a href="/getSendMail/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailTitle} 내용보기</a></td>
            <td>${mail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
            <td><a href="/throwSendIsDelete/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailIsDelete} 휴지통 이동</a></td>
        </tr>
    </c:forEach>
</tbody>
  </table>
  <table class="table">
    <thead>
      <tr>
      <h2>받은 중요 메일함</h2>
      <th>메일 순번</th>
        <th>보낸 사람</th>
        <th>제목</th>
        <th>받은 날짜</th>
        <th>읽은 날짜</th>
        <th>휴지통 이동</th>
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${receivedImportantEmail}" >
        <tr>
           <td>${mail.receiveMailId}</td>
            <td>${mail.receiveMailSenderEmail}</td>
            <td><a href="/getReceiveMail/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailTitle} 내용보기</a></td>
            <td>${mail.receiveMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
            <td>${mail.receiveMailReadDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
            <td><a href="/throwReceiveIsDelete/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailIsDelete} 다시 살리기</a></td>
        </tr>
    </c:forEach>
</tbody>
  </table>
</body>
</html>
