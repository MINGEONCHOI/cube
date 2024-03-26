<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
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

  <h2>메일함</h2>            
  <table class="table">
    <thead>
      <tr>
      <th>메일 순번</th>
        <th>받은 사람</th>
        <th>보낸 사람</th>
        <th>제목</th>
        <th>받은 날짜</th>
        <th>읽음 날짜</th>
        <th>휴지통 이동</th>
        <th>중요메일함 이동</th>
        
        
      </tr>
    </thead>
    <tbody>
    <c:forEach var="mail" items="${mailList}" >
        <tr>
           <td>${mail.mailId}</td>
            <td>${mail.mailReceiverEmail}</td>
            <td>${mail.mailSenderEmail}</td>
            <td>${mail.mailTitle}</td>
            <td>${mail.mailReservationDate}</td>
            <td>${mail.mailReadDate}</td>
            <td>${mail.mailIsDelete}</td>
            <td>${mail.mailImportant}</td>
        </tr>
    </c:forEach>
</tbody>
  </table>
</body>
</html>
