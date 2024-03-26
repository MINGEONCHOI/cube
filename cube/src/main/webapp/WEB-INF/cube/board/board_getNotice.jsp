<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="en">
<head>
<title>글 상세보기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
					<td>${NoticeBoard.nboardId}</td>
					<td>${NoticeBoard.nboardTitle}</td>
					<td>${login_user.userName}</td>
					<td>${NoticeBoard.nboardContent}</td>
					<td>${NoticeBoard.nboardFile}<input id = "nboardId" type = hidden value = ${NoticeBoard.nboardId}></td>
				</tr>
			
		</tbody>
	</table>
	<a href = "/updateNotice/${nboardId}">글 수정</a>
	<button id="btn-deleteNotice" class="btn btn-primary">글 삭제</button>
	<script src="/js/nb.js"></script>
	
</body>
</html>