<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>ReceiveMailContent</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
  <h2>메일 내용</h2>            
  <table class="table">
    <thead>
      <tr>
      <th>아이디 순번</th>
        <th>제목</th>
        <th>보낸 사람</th>
        <th>받은 날짜</th>
        <th>내용</th>
      </tr>
      <tr>
           <td>${ReceiveMail.receiveMailId}</td>
            <td>${ReceiveMail.receiveMailTitle}</td>
            <td>${ReceiveMail.receiveMailSenderEmail}</td>
            <td>${ReceiveMail.receiveMailReservationDate}</td>
            <td>${ReceiveMail.receiveMailContent}</td>
      </tr>
    </thead>
  </table>
   
</body>
</html>
