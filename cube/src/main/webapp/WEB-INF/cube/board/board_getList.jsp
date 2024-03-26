<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<title>게시글 입력</title>
<meta charset="utf-8">
</head>
<body>
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	
	<h2>${team.teamName}글목록</h2>
	<table class="table">
		<thead>
		<tr>
			<td><select class="select" name="searchType" id="searchType">
					<option value="userName">이름</option>
					<option value="boardTitle">제목</option>
			</select></td>
			<td><input type="text" id="searchInput"></td>
			<td><button id="btn-search">검색</button><input type = hidden id="teamId" value = "${team.teamId}" /></td>
			
		</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>내용</th>
				<th>생성일</th>
				<th>수정시간</th>


			</tr>
		</thead>
		<tbody>
			<c:forEach var="Board" items="${getTeamBoardList}">
				<tr>
					<td>${Board.boardId}</td>
					<td><a href="/getBoard/${team.teamId}/${Board.boardId}">${Board.boardTitle}</a></td>
					<td>${Board.boardWriter.userName}</td>
					<td>${Board.boardContent}</td>
					<td>${Board.boardCreated}</td>
					<td>${Board.boardUpdated}</td>


				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:choose>
		<c:when test="${team.teamId eq login_user.userTeamId.teamId}">
			<a href="/insertBoard/${team.teamId}">글등록</a>
		</c:when>

	</c:choose>
	<script src="/js/tb.js"></script>
</body>
</html>