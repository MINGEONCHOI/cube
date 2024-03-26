<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.ccnc.cube.user.Users" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   <% Users login_user = (Users)session.getAttribute("login_user"); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Mail</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>

      <label for="mailSenderEmail">보내는 사람 </label>
      <%=login_user.getUserEmail()%>
      <input id = "mailSenderEmail" type = "hidden" value = "<%=login_user.getUserEmail()%>" />

      <label for="mailReceiverEmail">받는사람</label>
      <input type="text" class="form-control" id="mailReceiverEmail" placeholder="받는사람을 입력하세요" name="mailReceiverEmail" value = "${receiverEmail}">
      
      <label for="mailTitle">제목</label>
      <input type="text" class="form-control" id="mailTitle" placeholder="제목을 입력하세요" name="mailTitle">
      
      <label for="mailcontent">내용</label>
      <input type="text" class="form-control" id="mailContent" placeholder="내용을 입력하세요" name="mailContent">
   
      <label for="sendMailReservationDate">날짜와 시간을 선택하세요</label>
      <%
  java.time.LocalDateTime now = java.time.LocalDateTime.now();
  java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
  String currentDateTime = now.format(formatter);
%>
      <input type="datetime-local" id="sendMailReservationDate" max="2100-06-20T23:59" min="<%= currentDateTime %>" value="<%= currentDateTime %>">

  
    <button id="btn-mailSend" class="btn btn-primary">메일보내기</button>

<script src="/js/mailSend.js"></script>
</body>
</html>

