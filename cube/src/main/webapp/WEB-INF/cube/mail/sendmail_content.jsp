<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>SendMailContent</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/css/mailList.css"/>
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
        <th>받는사람</th>
        <th>보낸날짜</th>
        <th>내용</th>
      </tr>
      <tr>
           <td>${SendMail.sendMailId}</td>
            <td>${SendMail.sendMailTitle}</td>
            <td>${SendMail.sendMailReceiverEmail}</td>
            <td>${SendMail.sendMailReservationDate}</td>
            <td>${SendMail.sendMailContent}</td>
      </tr>
    </thead>
  </table>
   
</body>
</html>
