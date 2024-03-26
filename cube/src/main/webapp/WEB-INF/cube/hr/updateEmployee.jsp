<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
  <h2>임직원 조회</h2>            
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
    	<c:if test="${user.userId == requestScope.userId}">
	        <tr>
	           <td>번호넣을방법</td>
	           <td>${user.userName}</td>
	           <td>${user.userNum}</td>
	           <td>${user.userTeamId.teamName }
	             <select class="select" name="teamId" id="teamId">
	             	<option value="${user.userTeamId.teamId }">${user.userTeamId.teamName }</option>
	             	<option value="">소속없음</option>
	             	<c:forEach var="team" items="${requestScope.teamList }">
	             		<c:if test="${user.userTeamId.teamId != team.teamId}">
	             			<option value="${team.teamId }">${team.teamName }</option>
	             		</c:if>
	             	</c:forEach>
	             </select>
	           </td>
	           <td>${user.userPosition}
	             <select class="select" name="userPosition" id="userPosition">
	             	<option value="${user.userPosition }">${user.userPosition }</option>
	             	<c:if test="${user.userPosition != '팀장'}">
	             		<option value="팀장">팀장</option>
	             	</c:if>
	             	<c:if test="${user.userPosition != '팀원'}">
	             		<option value="팀원">팀원</option>
	             	</c:if>
	             </select>
	           </td>
	           <td>${user.userMobile}</td>
           	   <td>${user.userEmail}</td>
	           <td>${user.userHireDate}</td>
	           <td>${user.userStatus}
	             <select class="select" name="userStatus" id="userStatus">
	             	<option value="${user.userStatus }">${user.userStatus }</option>
	             	<c:if test="${user.userStatus != '활성화'}">
	             		<option value="활성화">활성화</option>
	             	</c:if>
	             	<c:if test="${user.userStatus != '비활성화'}">
	             		<option value="비활성화">비활성화</option>
	             	</c:if>
	             </select>
	           </td>
	           <td><button id="btn-updateEmployee" data-user-id="${user.userId}">완료</button></td>
	        </tr>
        </c:if>
        
        <c:if test="${user.userId != requestScope.userId}">
        	<input type="hidden" id="userId" value="${user.userId }">
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
		</c:if>
	</c:forEach>
	</tbody>
	</table>
	<script src="/js/hr.js"></script>
</body>
</html>