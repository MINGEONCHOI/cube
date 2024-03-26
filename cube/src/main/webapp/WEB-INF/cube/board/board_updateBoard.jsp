<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>게시글 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
      <label for="nboardTitle">제목</label>
      <input type="text" id="boardTitle"  value="${Board.boardTitle}">
      
      <label for="nboardWriter">작성자</nboardWriter>    
     <input type="text" id="boardWriter" value = "${login_user.userName}" readonly="readonly" />
     
     <label for="nboardContent">내용</label>
      <input type="text" id="boardContent" value="${Board.boardContent}">
  		
  	 <input type="hidden" id="boardId" value = "${Board.boardId}" >
  	 <input type="hidden" id="teamId" value = "${teamId}" >
   
 
    <button id="btn-updateBoard" class="btn btn-primary">글 수정</button>
  <script src="/js/tb.js"></script>
</body>
</html>
