<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<h2>글 상세</h2>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>내용</th>
				<th>파일첨부</th>
			</tr>
		</thead>
		<tbody>

			<tr>
				<td>${Board.boardId}<input id="boardId" type=hidden
					value="${Board.boardId}" >
					<input id="teamId" type=hidden
					value="${teamId}" ></td>
				<td>${Board.boardTitle}</td>
				<td>${Board.boardWriter.userName}</td>
				<td>${Board.boardContent}</td>
				<td>${Board.boardFile}</td>
			</tr>

		</tbody>
	</table>
	<a href="/updateBoard/${boardId}">글 수정</a>
	<button id="btn-deleteBoard" class="btn btn-primary">글 삭제</button>
	
	
	<table>
	<tr>
				<th>작성자</th>
				<th>내용</th>
				<th>작성 시간</th>
				<th>삭제하기</th>
			</tr>
		<c:forEach var="comment" items="${commentList}">
			<tr>
				<td>${comment.commentWriter.userName}<input type = hidden value = ${comment.commentId} id="commentId"></td>
				<td>${comment.commentContent}</td>
				<td>${comment.commentCreated}</td>
				<td> <button id ="btn-deleteComment">댓삭</button></td>
				
			</tr>
		</c:forEach>
	</table>
	<label for="commentWriter">작성자</label>
      <input type="text" id="commentWriter" value = "${login_user.userName}" readonly="readonly" />

      <label for="commentContent">내용</label>
      <input type="text" id="commentContent" placeholder="내용을 입력하세요">
  	  	<button id="btn-insertComment" class="btn btn-primary">댓글 등록</button>
  	  	
	<script src="/js/tb.js"></script>

</body>
</html>