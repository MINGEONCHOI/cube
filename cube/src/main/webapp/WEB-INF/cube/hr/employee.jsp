<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
<body>
  <h2>임직원 조회</h2>            
  <table class="table">
  	<tr>
  	  <td>
  	    <select class="select" name="searchType" id="searchType">
  	      <option value="userName">이름</option>
  	      <option value="userTeamId">팀</option>
  	    </select>
  	  </td>
  	  <td><input type="text" id="searchInput"></td>
  	  <td><button id="btn-search">검색</button></td>
  	</tr>
  </table>
  <script src="/js/hr.js"></script>
  <table class="table">
    <thead>
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>사번</th>
        <th>팀</th>
        <th>직책</th>
        <th>휴대전화번호</th>
        <th>메일</th>
        <th>입사일</th>
        <th>상태</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${userList}">
        <input type="hidden" id="userId" value="${user.userId}">
        <tr>
           <td>번호넣을방법</td>
           <td>${user.userName}</td>
           <td>${user.userNum}</td>
           <td>${user.userTeamId.teamName}</td>
           <td>${user.userPosition}</td>
           <td>${user.userMobile}</td>
           <td>${user.userEmail}</td>
           <td>${user.userHireDate}</td>
           <td>${user.userStatus}</td>
           <td><a href="/hr_updateEmployee/${user.userId }" class="button">수정하기</a></td>
        </tr>
    </c:forEach>
</tbody>
  </table>
</body>
</html>
