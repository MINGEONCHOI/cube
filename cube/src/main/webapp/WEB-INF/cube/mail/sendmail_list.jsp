<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>SendMailList</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/css/mailList.css"/>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>

  <h2>보낸 메일함</h2>            
  <table class="table">
    <thead>
      <tr>
        <th>메일 순번</th>
        <th>제목</th>
        <th>받는 사람</th>
        <th>보낸 날짜</th>
        <th>휴지통 이동</th>
        <th>중요메일함 이동</th>
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${sendMailList}" >
        <tr>
            <td>${mail.sendMailId}<input type="hidden" value="${mail.sendMailId}" id = "sendMailId"></td>
            <td><a href="/getSendMail/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailTitle} 내용보기</a></td>
            <td>${mail.sendMailReceiverEmail}</td>
            <td>${mail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
            <td><a href="/changeSendIsDelete/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailIsDelete } 휴지통 이동</a></td>
            <td><a href="/changeSendImportant/${mail.sendMailId}" class="btn btn-primary">${mail.sendMailId } ${mail.sendMailImportant } 중요 메일함 이동</a></td>
            
        </tr>
    </c:forEach>
</tbody>
  </table>
   
</body>
</html>
