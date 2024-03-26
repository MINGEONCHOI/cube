<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>MailList</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>

  <h2>휴지통</h2>            
  <table class="table">
    <thead>
      <tr>
      <h2>보낸 메일 휴지통</h2>
        <th>메일 순번</th>
        <th>받는 사람</th>
        <th>제목</th>
        <th>받은 날짜</th>
        <th>다시 살리기</th>
        <th>완전 삭제</th>

        
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${sendIsDeleteEmail}" >
        <tr>
           <td>${mail.sendMailId}</td>
            <td>${mail.sendMailReceiverEmail}</td>
            <td><a href="/getSendMail/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailTitle} 내용보기</a></td>
            <td>${mail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
            <td><a href="/recoverySendIsDelete/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailIsDelete} 다시 살리기</a></td>
            <td><a href="/sendMailIsDelete/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailIsDelete } 완전 삭제</a></td>
         
        </tr>
    </c:forEach>
</tbody>
  </table>
  <table class="table">
    <thead>
      <tr>
      <h2>받은 메일 휴지통</h2>
        <th>메일 순번</th>
        <th>보낸 사람</th>
        <th>제목</th>
        <th>받은 날짜</th>
        <th>다시 살리기</th>
        <th>완전 삭제</th>
        
        
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${receivedIsDeleteEmail}" >
        <tr>
           <td>${mail.receiveMailId}</td>
            <td>${mail.receiveMailSenderEmail}</td>
           <td><a href="/getReceiveMail/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailTitle} 내용보기</a></td>
            <td>${mail.receiveMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
            <td><a href="/recoveryReceiveIsDelete/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailIsDelete} 다시 살리기</a></td>
            <td><a href="/receiveMailIsDelete/${mail.receiveMailId}" class="btn btn-primary">${mail.receiveMailId } ${mail.receiveMailIsDelete} 완전 삭제</a></td>
         <!--  <td>${mail.receiveMailReadDate}</td>-->   
        </tr>
    </c:forEach>
</tbody>
  </table>
</body>
</html>
